# Dependencias del proyecto

```py
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from networkx import *
```
Los datos estaban almacenados en una unidad compartidad de Drive por lo que los datos se importaron desde ahí. Si se desea correr, entonces cambie esta ubicación.
```py
ruta_datos = '/content/drive/Shareddrives/TAE/Entregas/1/Datos/Encuesta/'
ruta_destino_datos = '/content/drive/Shareddrives/TAE/Entregas/1/Datos/Exportados/'
```

## Funciones helpers
```py
def crear_id_persona(dataFrame):
  dataFrame['ID_Persona'] = (dataFrame['DIRECTORIO'].astype(str) + 
                           dataFrame['SECUENCIA_ENCUESTA'].astype(str) + 
                           dataFrame['SECUENCIA_P'].astype(str)).astype(int)
  return dataFrame

def crear_id_hogar(dataFrame):
  dataFrame['ID_Hogar'] = (dataFrame['DIRECTORIO'].astype(str) + 
                         dataFrame['SECUENCIA_P'].astype(str)).astype(int)
  return dataFrame
```

# Lectura de las bases de datos
Debido a que cada tabla contiene mucha información no relevante para el proyecto, se filtraron para obtener las características que se definieron. Adicionalmente, se construyeron nuevas variables que se necesitaban para poder realizar consultas entre tablas.

## Características y composición del hogar
```py
df_car_hogar = pd.read_csv(ruta_datos + 'Características y composición del hogar.csv', sep=';')

#Reemplazar espacios por null
df_car_hogar = df_car_hogar.replace(' ',np.nan)

# Clasificar los ninos entre 6 y 12 años
df_car_hogar['Clasificación'] = df_car_hogar['P6040'].apply(lambda edad: 'nino' 
                                                            if edad <= 12 and edad > 5  else 'otro')

# Generar un ID Persona
df_car_hogar = crear_id_persona(df_car_hogar)

# Generar un ID Hogar para conoces a qué hogar pertenece cada persona
df_car_hogar = crear_id_hogar(df_car_hogar)

# Eliminar los datos que no pertenecen a niños
indx_otro = df_car_hogar[df_car_hogar['Clasificación']=='otro'].index
df_car_hogar=df_car_hogar.drop(indx_otro)

# Renombrar las variables que usaremos
df_car_hogar.rename(columns={'P6040':'EDAD', 'P6080':'ETNIA', 'P6081':'VIVE_CON_PADRE',
                    'P6083':'VIVE_CON_MADRE', 'P6087':'EDUCACION_PADRE', 
                    'P6088':'EDUCACION_MADRE'}, inplace=True)

df_car_hogar = df_car_hogar.astype({'EDUCACION_MADRE':float, 'EDUCACION_PADRE':float})
```
Las variables de 'EDUCACION_MADRE' y 'EDUCACION_PADRE' las resumiremos como sigue:
0. Ninguna
1. Primaria
2. Secundaria
3. Técnica o Tecnología
4. Universidad

```py
df_car_hogar.EDUCACION_PADRE.replace(2.0, 1.0, overwrite = True)
df_car_hogar.EDUCACION_PADRE.replace(3.0, 2.0, overwrite = True).replace(4, 2.0, overwrite = True)
df_car_hogar.EDUCACION_PADRE.replace(5.0, 3.0, overwrite = True).replace(6, 3.0, overwrite = True)
df_car_hogar.EDUCACION_PADRE.replace(7.0, 4.0, overwrite = True).replace(8, 4.0, overwrite = True)
df_car_hogar.EDUCACION_PADRE.replace(9.0, 0.0, overwrite = True)
df_car_hogar.EDUCACION_PADRE.replace(np.nan, -1.0, overwrite = True).replace(10.0, -1, overwrite = True)

df_car_hogar.EDUCACION_MADRE.replace(2.0, 1.0, overwrite = True)
df_car_hogar.EDUCACION_MADRE.replace(3.0, 2.0, overwrite = True).replace(4, 2.0, overwrite = True)
df_car_hogar.EDUCACION_MADRE.replace(5.0, 3.0, overwrite = True).replace(6, 3.0, overwrite = True)
df_car_hogar.EDUCACION_MADRE.replace(7.0, 4.0, overwrite = True).replace(8, 4.0, overwrite = True)
df_car_hogar.EDUCACION_MADRE.replace(9.0, 0.0, overwrite = True)
df_car_hogar.EDUCACION_MADRE.replace(np.nan, -1.0, overwrite = True).replace(10.0, -1, overwrite = True)
```
Generamos la variable de 'EDUCACION_PADRES' como el máximo entre 'EDUCACION_MADRE' y 'EDUCACION_PADRE'
```py
df_car_hogar['EDUCACION_PADRES'] = df_car_hogar[['EDUCACION_PADRE', 'EDUCACION_MADRE']].max(axis=1)

df_car_hogar.loc[df_car_hogar['EDUCACION_PADRES'] == -1.0, 'EDUCACION_PADRES'] = np.nan

# Sacar las variables que se van a usar posteriormente
df_car_hogar = df_car_hogar[['ID_Hogar', 'ID_Persona', 'EDAD', 'ETNIA', 'VIVE_CON_PADRE', 
                             'VIVE_CON_MADRE', 'EDUCACION_PADRES']]
```
## Educación
```py
df_educacion  = pd.read_csv(ruta_datos + 'Educación.csv', sep=';')

df_educacion = df_educacion.replace(' ',np.nan)

# conbinacion escuela oficial con inoficial con y sin substito
df_educacion.update(df_educacion.P5674.replace('2', '3').replace('1', '2').rename('P5673'), overwrite=True)

# anadir 0 para el valor de beca para todos que no tienen beca.
df_educacion.update(df_educacion.P8610.replace('2', 1).rename('P8610S1'), overwrite=False)

df_educacion = crear_id_persona(df_educacion)

df_educacion.rename(columns={'P5673':'ESCUELA_OFICIAL', 'P6223':'UBICACION_ESCUELA', 
                             'P6238':'ORIGEN_SUBSIDIO_EDUC', 'P8586':'ESTUDIA', 
                             'P8610S1':'VALOR_BECA', 'P4693':'TRANSPORTE_ESCUELA',
                             'P6167':'TIEMPO_TRANSPORTE_ESC', 'P782':'EDAD_CUIDADOR', 
                             'P3004S1':'ACT1', 'P3004S2':'ACT2', 'P3004S3':'ACT3', 
                             'P3004S4':'ACT4','P3004S5':'ACT5', 'P3004S6':'ACT6',
                             'P3004S7':'ACT7', 'P3004S8':'NO_ACT'}, inplace=True)

df_educacion = df_educacion[['ID_Persona', 'ESCUELA_OFICIAL', 'UBICACION_ESCUELA', 
                             'ORIGEN_SUBSIDIO_EDUC', 'ESTUDIA', 'VALOR_BECA',
                             'TRANSPORTE_ESCUELA', 'TIEMPO_TRANSPORTE_ESC', 'EDAD_CUIDADOR',
                             'ACT1', 'ACT2', 'ACT3','ACT4', 'ACT5', 'ACT6', 'ACT7',
                             'NO_ACT']]
```
## Salud
```py
df_salud = pd.read_csv(ruta_datos + 'Salud.csv', sep=';')

df_salud = df_salud.replace(' ',np.nan)

df_salud['P6090'].replace(9, np.nan, inplace=True )

df_salud = crear_id_persona(df_salud)

df_salud.rename(columns={'P6090':'AFILIADO_SALUD', 'P6127':'ESTADO_SALUD', 'P1930':'ENFERMEDAD_CRONICA'}, inplace=True)

# Crear la variable incap - la suma de las gravedades de las incapacidades (8 - incapacido; 32 - no tiene incapacidades)
df_salud['INCAP'] = df_salud[['P1906S1', 'P1906S2', 'P1906S3', 'P1906S4', 
                              'P1906S5', 'P1906S6', 'P1906S7', 'P1906S8']].sum(axis=1, min_count=8)

df_salud = df_salud[['ID_Persona', 'AFILIADO_SALUD', 'ESTADO_SALUD', 'ENFERMEDAD_CRONICA',
                     'INCAP']]
```

## Trabajo infaltil
```py
df_trabajo = pd.read_csv(ruta_datos + 'Trabajo infantil.csv', sep=';')

df_trabajo = df_trabajo.replace(' ',np.nan)

df_trabajo = crear_id_persona(df_trabajo)

# TRABAJO1, TRABAJO2, TRABAJO3 hacen referencia a preguntas relacionadas a trabajos
# durante la últimas semanas
df_trabajo.rename(columns={'P171':'HORAS_TRABAJO', 'P400':'ACTIVIDAD_ULT_SEMANA', 
                          'P401':'TRABAJO1', 'P402':'TRABAJO2', 'P403':'TRABAJO3',
                          'P404':'TRABAJO4', 'P420':'LUGAR_TRABAJO'}, inplace=True)

df_trabajo = df_trabajo[['ID_Persona', 'HORAS_TRABAJO', 'ACTIVIDAD_ULT_SEMANA', 
                         'TRABAJO1', 'TRABAJO2', 'TRABAJO3', 'TRABAJO4', 'LUGAR_TRABAJO']]
```

## Servicios del hogar
```py
df_serv_hogar = pd.read_csv(ruta_datos + 'Servicios del hogar.csv', sep=';')

df_serv_hogar = df_serv_hogar .replace(' ',np.nan)

df_serv_hogar = crear_id_hogar(df_serv_hogar)

df_serv_hogar  = df_serv_hogar [['ID_Hogar', 'PERCAPITA', 'CANT_PERSONAS_HOGAR']]
```

## Condiciones de vida del hogar y tenencia de bienes
```py
df_cond_hogar = pd.read_csv(ruta_datos + 'Condiciones de vida del hogar y tenencia de bienes.csv', sep=';')

df_cond_hogar = df_cond_hogar.replace(' ',np.nan)

df_cond_hogar = crear_id_hogar(df_cond_hogar)

df_cond_hogar.rename(columns={'P9090':'INCRESOS_AUTOPERCIBIDOS_HOGAR', 
                             'P9030':'CONDIC_VIDA_HOGAR'}, inplace=True)
                             
df_cond_hogar = df_cond_hogar[['ID_Hogar', 'INCRESOS_AUTOPERCIBIDOS_HOGAR', 
                               'CONDIC_VIDA_HOGAR']]
```

# Construcción del dataframe general
```py
# Merge entre Características del hogar y Educación
df = df_car_hogar.merge(df_educacion, how='left', on='ID_Persona')

# Merge entre el Dataframe y Salud
df = df.merge(df_salud, how='left', on='ID_Persona')

# Merge entre el Dataframe y Trabajo infantil
df = df.merge(df_trabajo, how='left', on='ID_Persona')

# Merge entre el Dataframe y Servicios del hogar
df = df.merge(df_serv_hogar, how='left', on='ID_Hogar')

# Merge entre el Dataframe y Condiciones de vida del hogar
df = df.merge(df_cond_hogar, how='left', on='ID_Hogar')

# Crear la varible actividades que tiene el número de las diferentes actividedas que hacen.
p3004 = df[['ACT1', 'ACT2', 'ACT3', 'ACT4', 'ACT5', 'ACT6', 'ACT7',]].astype(float)

df['ACTIVIDADES'] = p3004.sum(axis=1, min_count=1)

df.update((df['NO_ACT'].astype(float)%1).rename('ACTIVIDADES'), overwrite=False)

# Anadir cero horas trabajando para los que no trabajan
no_trabaja = ((df['ACTIVIDAD_ULT_SEMANA'].astype(float)>1) * (df['TRABAJO1'].astype(float)!=1) * 
              (df['TRABAJO2'].astype(float)!=1) * (df['TRABAJO3'].astype(float)!=1))

df.update((no_trabaja.replace(False, np.nan)%1).rename('HORAS_TRABAJO'), overwrite=False)

df1 = df['ACTIVIDAD_ULT_SEMANA'].astype(str).str.get_dummies()
df1.loc[df1.nan==1, '1.0'] = np.nan

df.TRABAJO1.replace('2', 0, inplace=True)
df.TRABAJO2.replace('2', 0, inplace=True)
df.TRABAJO3.replace('2', 0, inplace=True)

df['TRABAJA'] = (df1['1.0'] + df['TRABAJO1'].replace(np.nan, 0).astype(int) + 
                df['TRABAJO2'].replace(np.nan, 0).astype(int) + 
                df['TRABAJO3'].replace(np.nan, 0).astype(int))

df.update(df['TRABAJA'].replace(1.0, np.nan).replace(0.0,'0').rename('LUGAR_TRABAJO'), overwrite=False)

# Reemplazar ',' por '.' para la correcta lectura de los datos en la variable 'PERCAPITA'
df['PERCAPITA'] = df['PERCAPITA'].astype(str).apply(lambda x: x.replace(',','.'))

# Cambiar el tipo de dato de algunas variables
df = df.astype({'ESTUDIA':float, 'ESTADO_SALUD':float, 'ETNIA':float, 
                'PERCAPITA':float, 'INCRESOS_AUTOPERCIBIDOS_HOGAR':float, 
                'CONDIC_VIDA_HOGAR':float})
```

## Cálculo de la variable de satisfacción
Usamos los siguientes dos variable:
 - Salud - P6127: Estado de salud del niño
 - Educación - P3004: Número de las actividades realiza fuera de la jornada escolar.
Decimos que el óptimo es participar en todas las actividades y tener un estado de salud 1 ("muy bueno").
Asímismo decimos que el peor de los casos es que el niño no practique ninguna actividad y su estado se salud sea 4 ("malo").

Primero poderamos la variable "Actividades" con la fórmula de Gauß. Así, la diverencia entre realizar 6 o 7 actividades no es tan grande como la diferencia entre realizar 1 o ninguna actividad.

```py
lfunc = np.vectorize(lambda n: n*8 -((n+1)*n/2))

df['Actividades_p'] = lfunc(df['ACTIVIDADES'])
```

Ahora queremos sumar las dos variables. Para eso relacionamos los valores de salud al mismo tamaño.
```py
lfunc = np.vectorize(lambda n: n*(-9) + 36)

df['Salud_p'] = lfunc(df['ESTADO_SALUD'])
```
Y las sumamos
```py
df['SATISFACCION'] = df[['Salud_p', 'Actividades_p']].sum(axis=1, skipna=False).astype(float)
```
Se borran los datos que contengan NaN en satisfaccion, puesto que no podemos usarlos para entrenar.
```py
df.drop(df[df.SATISFACCION.isna()].index, inplace=True)
```

# Exportar datos a CSV
```py
# dataframe con los datos necesarios para el modelo de los niños
df.to_csv(ruta_destino_datos + 'datos_ninos.csv', 
          sep=';', index=False)
```
