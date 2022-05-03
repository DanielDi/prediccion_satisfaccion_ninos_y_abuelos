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

Se procede a realizar una interpolación en los datos nulos o atípicos de las variables escogidas como posibles predictoras de satisfacción, en caso de que algunos valores no se puedan interpolar se reemplazan por la media.

    El INGRESO_AUTOPERCIBIDO de una persona que no recibe ingresos es de 99 en una escala de 1 a 10, por lo tanto se llevará este valor a esta escala para evitar sacar del modelo a las personas que no perciben ingresos.

    Se interpola la columna donde se define si una persona está o no afiliada a algún prestador de salud, ya que hay algunos datos donde la persona no sabe o no responde.

```py
# 1.
def interpolacion_persona(df):
  df['P1896'] = df['P1896'].astype(str).replace('99', np.nan)
  df['P1896'] = df.P1896.astype('category').cat.codes.replace('nan', np.nan).astype(float)

  df['P1897'] = df['P1897'].astype('category')
  df['P2059'] = df['P2059'].astype('category')  
  df['P5502'] = df['P5502'].astype('category')
  df['P1898'] = df['P1898'].astype('category')
  df['P1899'] = df['P1899'].astype('category')
  df['P1895'] = df['P1895'].astype('category')


  # Se reemplazan los -1 por nan para poder realizar la interpolación. 
  # El -1 lo asigna como identificación en las filas con valores en null.
  # La función interpolate retorna los valores como punto flotante, por esto
  # se convierten a enteros y luego a categóricos. Finalmente, esos códigos 
  # vuelve a las categorías iniciales. 


  df.P1895 = (df.P1895.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P1895'].cat.categories))
  
  df.P1899 = (df.P1899.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P1899'].cat.categories))
 
  df.P1898 = (df.P1898.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P1898'].cat.categories))
  
  df.P1898 = (df.P1898.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P1898'].cat.categories))

  df.P2059 = (df.P2059.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P2059'].cat.categories))
  
  df.P1897 = (df.P1897.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P1897'].cat.categories))
  
  df.P5502 = (df.P5502.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P5502'].cat.categories))
  
  # Los valores que no pudieron ser interpolados se reemplazan por la media
  moda_ingreso = df.loc[df['Clasificación'] == "3ra_edad", 'P1896'].value_counts().idxmax()
  df['P1896'].fillna(moda_ingreso, inplace=True)
  return df

def interpolacion_salud(df):
  df['P6090'] = df['P6090'].astype(str).replace('9', np.nan)
  df['P6100'] = df['P6100'].astype(str).replace('9', np.nan)
  
  df['P6100'] = df.P6100.astype('category').cat.codes.replace('nan', np.nan).astype(float)

  df.P6090 = df.P6090.astype('category')
  df.P6127 = df.P6127.astype('category')
  df.P6100 = df.P6100.astype('category')
  df.P1930 = df.P1930.astype('category')

  # Se reemplazan los -1 por nan para poder realizar la interpolación. 
  # El -1 lo asigna como identificación en las filas con valores en null.
  # La función interpolate retorna los valores como punto flotante, por esto
  # se convierten a enteros y luego a categóricos. Finalmente, esos códigos 
  # vuelve a las categorías iniciales. 

  df.P6090 = (df.P6090.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P6090'].cat.categories))
  
  df.P6127 = (df.P6127.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P6127'].cat.categories))
  

  df.P6100 = (df.P6100.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P6100'].cat.categories))
  
  df.P1930 = (df.P1930.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['P1930'].cat.categories))

  df['P6181'] = df['P6181'].astype(str).replace('9', np.nan)
  df['P6181'] = df['P6181'].astype(str).replace('nan', np.nan)
  moda_calidad = df.loc[df['Clasificación'] == "3ra_edad", 'P6181'].value_counts().idxmax()
  df['P6181'] = df.loc[df['Clasificación'] == "3ra_edad", 'P6181'].replace(np.nan, moda_calidad)

  return df

def interpolacion_educación(df):
  df.NIVEL_DE_EDUCACION = df.NIVEL_DE_EDUCACION.astype('category')
  
  # Se reemplazan los -1 por nan para poder realizar la interpolación. 
  # El -1 lo asigna como identificación en las filas con valores en null.
  # La función interpolate retorna los valores como punto flotante, por esto
  # se convierten a enteros y luego a categóricos. Finalmente, esos códigos 
  # vuelve a las categorías iniciales. 
  df.NIVEL_DE_EDUCACION = (df.NIVEL_DE_EDUCACION.cat.codes.replace(-1, np.nan)
              .interpolate().astype(int).astype('category')
              .cat.rename_categories(df['NIVEL_DE_EDUCACION'].cat.categories))

  return df

def interpolacion_datos_vivienda(df):
  df.P8520S1A1 = df.P8520S1A1.astype('category')
  # Se reemplazan los -1 por nan para poder realizar la interpolación. 
  # El -1 lo asigna como identificación en las filas con valores en null.
  # La función interpolate retorna los valores como punto flotante, por esto
  # se convierten a enteros y luego a categóricos. Finalmente, esos códigos 
  # vuelve a las categorías iniciales. 
  df.P8520S1A1 = (df.P8520S1A1.cat.codes.replace(-1, np.nan)
            .interpolate().astype(int).astype('category')
            .cat.rename_categories(df['P8520S1A1'].cat.categories))

  #Los valores que no se pudieron interpolar se cambian por la frecuencia
  moda_servicios = df['P8520S1A1'].value_counts().idxmax()
  df['P8520S1A1'] = df['P8520S1A1'].replace('9', moda_servicios)

  return df

def interpolacion_datos_cond_hogar(df):
  df.P9030 = df.P9030.astype('category')
  
  # Los NaNs se reemplazan por su media debido a que son pocos
  moda_cond_hogar = df.loc[df['Clasificación'] == "3ra_edad", 'P9030'].value_counts().idxmax()
  df['P9030'].fillna(moda_cond_hogar, inplace=True)

  return df
```

## Características y composición del hogar

```py
#Reemplazar espacios por nan
df_car_hogar = df_car_hogar.replace(' ',np.nan)

# Clasificar personas de la tercera edad (mayores a 60 años) y niños (menores de 13)
df_car_hogar['Clasificación'] = df_car_hogar['P6040'].apply(
                                          lambda edad: '3ra_edad' if edad >= 60 
                                          else ('niño' if edad <= 12 and edad >= 6 
                                                else 'otro'))

df_car_hogar = interpolacion_persona(df_car_hogar)

# Generar un IDs para cada persona
df_car_hogar = crear_id_persona(df_car_hogar)

# Generar un ID Hogar para conocer a qué hogar pertenece cada persona
df_car_hogar = crear_id_hogar(df_car_hogar)

# Eliminar los datos que contengan un SECUENCIA_ENCUESTA >= 10 por cuestiones de
# practicidad en lo que sigue
df_car_hogar.drop(df_car_hogar[df_car_hogar['SECUENCIA_ENCUESTA']>=10].index, inplace=True)

# Sacar las variables que se van a usar posteriormente
df_car_hogar = df_car_hogar[['DIRECTORIO', 'SECUENCIA_P', 'ID_Persona', 'ID_Hogar', 
                       'P6020', 'P1897', 'P5502', 'P6080', 'Clasificación', 
                       'P1896', 'P1898', 'P1899', 'P1895', 'P6081S1', 
                       'P6083S1', 'P6080', 'P2059']]
    
# Cantidad de abuelos
df_car_hogar.groupby('Clasificación').count()
```

## Educación

```py
df_educacion = pd.read_csv(ruta_datos + 'Educación.csv', sep=';')

df_educacion = df_educacion.replace(' ',np.nan) # Reemplazar espacios por null

df_educacion = crear_id_persona(df_educacion)

df_educacion = df_educacion[['ID_Persona','P8587']] # Obtener la variable de interés
```

Se decidió limitar las categorías de la característica *P8587* ya que estas comparten información similar. A continuación se presentan las categorías que quedaron:


<table> <tr> <td>
1. Ninguno <br>
2. Preescolar <br>
3. Básica primaria <br>
4. Básica secundaria <br>
5. Media <br> <td>
6. Técnica <br>
7. Tecnólogo <br>
8. Universitario <br>
9. Postgrado <br>
</td> </tr> </table>

```py
df_educacion.loc[df_educacion['P8587'] == '1', 'NIVEL_DE_EDUCACION'] = '1'
df_educacion.loc[df_educacion['P8587'] == '2', 'NIVEL_DE_EDUCACION'] = '2'
df_educacion.loc[df_educacion['P8587'] == '3', 'NIVEL_DE_EDUCACION'] = '3'
df_educacion.loc[df_educacion['P8587'] == '4', 'NIVEL_DE_EDUCACION'] = '4'
df_educacion.loc[df_educacion['P8587'] == '5', 'NIVEL_DE_EDUCACION'] = '5'
df_educacion.loc[df_educacion['P8587'] == '6', 'NIVEL_DE_EDUCACION'] = '6'
df_educacion.loc[df_educacion['P8587'] == '7', 'NIVEL_DE_EDUCACION'] = '6'
df_educacion.loc[df_educacion['P8587'] == '8', 'NIVEL_DE_EDUCACION'] = '7'
df_educacion.loc[df_educacion['P8587'] == '9', 'NIVEL_DE_EDUCACION'] = '7'
df_educacion.loc[df_educacion['P8587'] == '10', 'NIVEL_DE_EDUCACION'] = '8'
df_educacion.loc[df_educacion['P8587'] == '11', 'NIVEL_DE_EDUCACION'] = '8'
df_educacion.loc[df_educacion['P8587'] == '12', 'NIVEL_DE_EDUCACION'] = '9'
df_educacion.loc[df_educacion['P8587'] == '13', 'NIVEL_DE_EDUCACION'] = '9'

df_educacion.drop(['P8587'], axis=1, inplace=True)

df_educacion = pd.merge(df_educacion, df_car_hogar[['ID_Persona', 'Clasificación']], how="left", on=["ID_Persona"])

print(df_educacion.groupby('Clasificación').count())
df_educacion = interpolacion_educación(df_educacion)

df_educacion.drop(['Clasificación'], axis=1, inplace=True)
```

## Salud
```py
from pandas.core.dtypes.missing import isna
df_salud = df_salud.replace(' ', np.nan) # Reemplazar espacios por null

df_salud = crear_id_persona(df_salud)

df_salud = df_salud[['ID_Persona', 'P6090', 'P6100', 'P6181', 'P6115', 'P6127', 'P1930']]

df_salud = pd.merge(df_salud, df_car_hogar[['ID_Persona', 'Clasificación']], how="left", on=["ID_Persona"])

df_salud = interpolacion_salud(df_salud)

df_salud.drop(['Clasificación'], axis=1, inplace=True)
```

## Fuerza de trabajo
```py
df_fuerza_trabajo = df_fuerza_trabajo.replace(' ',np.nan)

df_fuerza_trabajo = crear_id_persona(df_fuerza_trabajo)

df_fuerza_trabajo = df_fuerza_trabajo[['ID_Persona', 'P6435', 'P6440', 'P6460', 
                                       'P8624', 'P8631', 'P8642', 'P415']]
```

## Servicios del hogar
```py
df_serv_hogar = pd.read_csv(ruta_datos + 'Servicios del hogar.csv', sep=';')

df_serv_hogar = df_serv_hogar.replace(' ',np.nan)

df_serv_hogar = crear_id_hogar(df_serv_hogar)

df_serv_hogar = df_serv_hogar[['ID_Hogar', 'I_HOGAR', 'PERCAPITA']]
```

## Condiciones de vida del hogar y tendencia de bienes

```py
df_cond_hogar = df_cond_hogar.replace(' ',np.nan)

df_cond_hogar = crear_id_hogar(df_cond_hogar)

df_cond_hogar = df_cond_hogar[['ID_Hogar', 'P9030', 'P9010', 'P9025S2', 'P9025S1', 'P1913S5']]

df_cond_hogar = pd.merge(df_cond_hogar, df_car_hogar[['ID_Hogar', 'Clasificación']], how="left", on=["ID_Hogar"])

# df_cond_hogar.groupby('Clasificación', dropna=False).count()
# print(df_cond_hogar['P9030'].isna().sum())
print(df_cond_hogar['P9030'].unique())

df_cond_hogar = interpolacion_datos_cond_hogar(df_cond_hogar)

df_cond_hogar.drop(['Clasificación'], axis=1, inplace=True)
```

## Datos de la vivienda

```py
df_datos_vivienda = df_datos_vivienda.replace(' ',np.nan)

df_datos_vivienda = interpolacion_datos_vivienda(df_datos_vivienda)

df_datos_vivienda = df_datos_vivienda[['DIRECTORIO', 'P8520S1A1', 'P1070']]
```

# Análisis de los abuelos
Con el fin de determinar con cuál definición de abuelos se iba a trabajar - cualquier persona mayor a 60 años o personas que tuviesen nietos - se realizó un análisis con las tablas que involucran esta información. Para este análisis se construyó un grafo dirigido donde sus aristas indicaban la relación padre-hijo, luego se invirtió el grafo debido a que no se contaba con un algoritmo para determinar los sucesores, sino antecesores. Finalmente se utilizó un algoritmo para determinar los nodos que estaban a una distancia 2 (relación de abuelo).

**Nota**: para realizar esto se utilizó la librería networkx.
```py
def transform(n):
  n = list(map(str, n))
  return [int(n[-1]), int(''.join(n[:-1]))]

def gen_data(gender):
  L = []
  X = list(filter(lambda x : str(x[1]).isnumeric(), df_car_hogar[['DIRECTORIO', gender,  'SECUENCIA_P', 'ID_Persona']].values.tolist()))
  L = list(map(transform, X))

  Nodes = list(df_car_hogar['ID_Persona'])

  G = DiGraph()
  G.add_edges_from(L)
  GG = reverse(G)

  abuelos = []
  for node in Nodes:
    if node in G:
      l = list(descendants_at_distance(GG, node, 2))
      if len(l) > 1:
        abuelos.append(node)

  return abuelos
```

Como los datos sobre abuelos o abuelas estaban en características diferentes, se llamó a la función con cada una de ellas:

```py
Total = gen_data('P6081S1') + gen_data('P6083S1')
```

Finalmente, se deseaba saber cuántos de estas personas con nietos eran menores o mayores a 60 años, lo cual se determinó de la siguiente manera:

```py
abuelos_menores_a_60 = 0

for a in Total:
  abuelo = df_car_hogar[df_car_hogar['ID_Persona'] == a]
  if "otro" in abuelo.Clasificación.values:
    abuelos_menores_a_60 += 1
  
abuelos_mayores_a_60 = len(Total) - abuelos_menores_a_60

print(f"Abuelos menores a 60 años {abuelos_menores_a_60}")
print(f"Abuelos mayores a 60 años {abuelos_mayores_a_60}")
```

# Construcción del dataframe general
Para poder ralizar los primeros análisis descriptivos de los datos que se tiene se construyó un dataframe con las variables que se definieron según la bibliografía.
```py
df = df_educacion.merge(df_car_hogar, how='left', on='ID_Persona')
indx_otro = df[df['Clasificación']=='otro'].index
df = df.drop(indx_otro)

df = df.merge(df_serv_hogar, how='left', on='ID_Hogar')
df.drop(df[df.PERCAPITA.isna()].index, inplace=True)
df.drop(df[df.NIVEL_DE_EDUCACION.isna()].index, inplace=True)

df = df.merge(df_cond_hogar, how='left', on='ID_Hogar')
df.drop(['ID_Hogar', 'DIRECTORIO', 'SECUENCIA_P', 'P6081S1', 'P6083S1'], axis=1, inplace=True)

df.rename(columns={'P6020':'SEXO', 'P1897':'SALUD_AUTOPERCIBIDA', 'P5502':'ESTADO_CIVIL',
                   'P6080':'ETNIA', 'P1895':'SATISFACCION', 'P1896':'INGRESO_AUTOPERCIBIDO',
                   'P1899':'TRABAJO_AUTOPERCIBIDO', 'P1898':'SEGURIDAD_AUTOPERCIBIDA',
                   'P9030':'COND_VIDA_DEL_HOGAR'}, inplace=True)
```

# Exportar Bases de Datos a CSV
El objetivo de este procesamiento es obtener los datos necesarios para la construcción de los modelos, por ende se exporta cada uno de los dataframes a un formato CSV

```py
# Dataframe general  
df.to_csv(ruta_destino_datos + 'personas.csv', 
          sep=';', index=False)

# Dataframe salud
df_salud.to_csv(ruta_destino_datos + 'salud.csv', 
          sep=';', index=False)

# Dataframe educación
df_educacion.to_csv(ruta_destino_datos + 'educacion.csv', 
          sep=';', index=False)

# Dataframe de Características y Composición del hogar
df_car_hogar.to_csv(ruta_destino_datos + 'caracteristicas_composicion_del_hogar.csv', 
          sep=';', index=False)

# Dataframe de fuerza de trabajo
df_fuerza_trabajo.to_csv(ruta_destino_datos + 'fuerza_trabajo.csv', 
          sep=';', index=False)

# Dataframe de servicios del hogar
df_serv_hogar.to_csv(ruta_destino_datos + 'servicios_hogar.csv', 
          sep=';', index=False)

# Dataframe de condiciones de vida del hogar y tendencia de bienes.
df_cond_hogar.to_csv(ruta_destino_datos + 'condiciones_hogar.csv', 
          sep=';', index=False)

# Dataframe de datos vivienda
df_datos_vivienda.to_csv(ruta_destino_datos + 'datos_vivienda.csv', 
          sep=';', index=False)
```
