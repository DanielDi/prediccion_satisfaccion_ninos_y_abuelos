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

# Clasificar personas de la tercera edad (mayores a 60 años)
df_car_hogar['Clasificación'] = df_car_hogar['P6040'].apply(lambda edad: 
                                                    '3ra_edad' if edad >= 60 
                                                    else ('niño' if edad <= 12 
                                                                else 'otro'))

# Generar un ID Persona
df_car_hogar = crear_id_persona(df_car_hogar)

# Generar un ID Hogar para conoces a qué hogar pertenece cada persona
df_car_hogar = crear_id_hogar(df_car_hogar)

# Eliminar los datos que contengan un SECUENCIA_ENCUESTA >= 10 por cuestiones de
# practicidad en lo que sigue
df_car_hogar.drop(df_car_hogar[df_car_hogar['SECUENCIA_ENCUESTA']>=10].index, inplace=True)

# Sacar las variables que se van a usar posteriormente
df_car_hogar = df_car_hogar[['DIRECTORIO', 'SECUENCIA_P', 'ID_Persona', 'ID_Hogar', 
                       'P6020', 'P1897', 'P5502', 'P6080', 'Clasificación', 
                       'P1896', 'P1898', 'P1899', 'P1895', 'P6081S1', 
                       'P6083S1']]
    
# Cantidad de abuelos
df_car_hogar['Clasificación'].value_counts()
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
```

## Salud
```py
df_salud = pd.read_csv(ruta_datos + 'Salud.csv', sep=';')

df_salud = df_salud.replace(' ',np.nan) # Reemplazar espacios por null

df_salud = crear_id_persona(df_salud)

df_salud = df_salud[['ID_Persona', 'P6090', 'P8551', 'P6181', 'P6115']]
```

## Fuerza de trabajo
```py
df_fuerza_trabajo = pd.read_csv(ruta_datos + 'Fuerza de trabajo.csv', sep=';')

df_fuerza_trabajo = df_fuerza_trabajo.replace(' ',np.nan)

df_fuerza_trabajo = crear_id_persona(df_fuerza_trabajo)

df_fuerza_trabajo = df_fuerza_trabajo[['ID_Persona', 'P6435', 'P6440', 'P6460', 
                                       'P8624', 'P415']]
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
df_cond_hogar = pd.read_csv(ruta_datos + 'Condiciones de vida del hogar y tenencia de bienes.csv', sep=';')

df_cond_hogar = df_cond_hogar.replace(' ',np.nan)

df_cond_hogar = crear_id_hogar(df_cond_hogar)
                             
df_cond_hogar = df_cond_hogar[['ID_Hogar','P9030', 'P9010']]
```

## Datos de la vivienda

```py
df_datos_vivienda = pd.read_csv(ruta_datos + 'Datos de la vivienda.csv', sep=';')

df_datos_vivienda = df_datos_vivienda.replace(' ',np.nan)

df_datos_vivienda = df_datos_vivienda[['DIRECTORIO', 'P8520S1A1']]
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
