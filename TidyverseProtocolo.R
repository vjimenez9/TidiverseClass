
#La ciencia de datos es una disciplina emocionante que  permite convertir los datos sin procesar en conocimiento. 

#En esta sesión daremos una mirada a Tidyverse, y específicamente a dplyr para ordenar y trabajar con datos con miras a analizarlos. 

#Indice
# * Introducción
#- Modelo de Herramientas necesarias
# * Paquete dplyr
#  - filter()
#  - Select()
#  - Mutate()
#  - summarize()
#  - group_by()
# * Uso de pipes
#  - alternativas para el uso de pipes
#  - cuando no usar pipes
#  - Tpipes. 

## Modelo de Herramientas necesarias

#"La exploración de los datos es el arte de mirar en tus datos, generar hipotesis, probar o desechar dichas hipotesis y volver a repetir..."

#Fuente: http://r4ds.had.co.nz/introduction.html 

#* La información ordenada es importante porque la estructura coherente nos permite centrar el esfuerzo en las preguntas sobre los datos, no luchando para obtener los datos en la forma correcta para las diferentes funciones...
#* Por ejemplo considere un formato Genebank como fuente de nuestra información de entrada:
#* El primer esfuerzo será ordenar la información de manera que en cada renglon tengamos la descripción de un objeto y en cada columna los atributos para describir los objetos:

#############
# Transformaciones

# * La transformación incluye resumir las observaciones de interés (como todas las personas en una ciudad, o todos los datos del último año), crear nuevas variables que son funciones de variables existentes (como calculo de la velocidad, a partir de la distancia y tiempo) y calcular un summary estadístico.
# * Las transformaciones permiten seleccionar variables importantes, filtrar obsevaciones, crear nuevas variables y generar resumenes. 


##########
# Visualizaciones

# * La visualización es una actividad fundamentalmente humana. 
# * Una buena visualización muestra cosas que no esperabas, o plantea nuevas preguntas sobre los datos. Te debe ayudar a entender tus datos
# * Una buena visualización también podría indicar que estas haciendo la pregunta incorrecta, o necesita recolectar datos diferentes.
# * Las visualizaciones pueden sorprenderte, pero no escalan particularmente bien porque requieren un ser humano para interpretarlas.
########
#  Modelado

# * Los modelos son herramientas complementarias para la visualización. 

# * Una vez que hayas hecho las preguntas lo suficientemente precisas, puedes usar un modelo para responderlas.

# * Los modelos son una herramienta fundamentalmente matemática o computacional, por lo que generalmente se escalan bien.

# * Incluso cuando no lo hacen, generalmente es más barato comprar más computadoras que comprar más cerebros

###############
#  Comunicacion

# * No importa qué tan bien tus modelos y visualización te hayan llevado a comprender los datos a menos que también puedas comunicar tus resultados a otros.

# * No necesitas ser un programador experto para ser un científico de datos, peroooo... aprender más acerca de la programación vale la pena porque convertirse en un mejor programador te permite automatizar tareas comunes y resolver nuevos problemas con mayor facilidad.

###########
# Tidyverse

############
#  Prerequisitos

# * Primero debemos tener instalado el tidyverse:
install.packages('tidyverse')
library(tidyverse)
###########
#  dplyr

# * dplyr  es un poderoso paquete de R  para transformar y sumarizar datos tabulares en R

# * Tiene un conjunto de funciones (o verbos) que realizan las operaciones mas comunes en el análisis de  datos como son :

 #   - Filtrar por renglones
 
 #   - Seleccionar columnas especificas
 
 #   - Reordenar renglones
 
 #   - Adicionar nuevas columnas
 
 #   - Sumarizar datos

# * Casi todas las funciones que utilizará en este libro producen tibbles, ya que los tibbles son una de las características unificadoras del tidyverse. La mayoría de los otros paquetes R usan dataframes(), por lo que es posible que  forzemos la conversion de un dataframe a un tibble. Puedes hacer eso con as_tibble ().

# * tibble () reciclará automáticamente las entradas de longitud 1, y le permite consultar las variables que acaba de crear, como se muestra a continuación.

####################
# Data:  msleep_ggplot2.csv

# Para esta sesión trabajaremos con esta tabla que contiene los tiempos de sueño y peso de un conjunto de 83 mamíferos, descritos con las siguientes 11 columnas
# * name    common name

# * genus    taxonomic rank

# * vore    carnivore, omnivore or herbivore?

# * order    taxonomic rank

# * conservation    the conservation status of the mammal

# * sleep_total    total amount of sleep, in hours

# * sleep_rem    rem sleep, in hours (rem=rapid eye movement)

# * sleep_cycle    length of sleep cycle, in hours

# * awake    amount of time spent awake, in hours

# * brainwt    brain weight in kilograms

# * bodywt    body weight in kilograms

# Primero, verificaremos donde estamos parados:

getwd()


#Definimos donde queremos estar:
setwd("Dropbox/cursos/RLadies/Data")

# Leemos la tabla en formato csv
msleep <- read.csv("msleep_ggplot2.csv")
head(msleep)

#transformamos el data.frame a tibble
tmsleep<-as_tibble(msleep)

# Existen 5 funciones claves para transformar datos con dplyr que permiten resolver la mayoría de los retos en el proceso de manipulación de datos:

# * Elegir las observaciones por sus valores (filter())

# * Reordenar los renglones (arrange())

# * Elegir las variables por sus nombres (select())

# * Crear nuevas variables con funciones sobre las variables existentes (mutate())

# *Colapsar muchos valores en un resumen de los mismos (summarise())

# Estas funciones pueden ser usadas en conjunción con group_by()  la cual cambia el ámbito de cada función para operar sobre el conjunto completo de datos u operando solo grupo por grupo. 

################
# GroupBy

# dplyr puede ser vista como una gramatica de manipulación de datos, donde cada función es un verbo y cada verbo trabaja de manera similar:

# 1. El primer argumento es el nombre del data.frame o tibbies

# 2. Los siguiente argumentos describen que se hace con el data.frame usando los nombres de variables.

# 3. El resultado es un nuevo data.frame o tibbies

#######################
# Filtrando elementos con filter()

#Filter() permite filtrar observaciones a partir de sus valores. El primer argumento es el nombre de data frame.  El segundo y los siguientes argumentos son las expresiones de filtro. Por ejemplo: Filtremos a todos los mamíferos carnívoros que duerman mas de 10 horas
filter(tmsleep,vore=='carni',sleep_total>10)

# *dplyr nunca modifica sus entradas, así que si quieres guardar el resultado necesitas usar el operador <-  

# * R imprime los resultados o los salva en una variable. Si quieres hacer ambos debes hacer la asignación entre paréntesis:

(Carnivoros<-filter(tmsleep,vore=='carni',sleep_total>10))

# Para usar el filtro efectivamente, debes conocer como seleccionar los objetos que deseas usando los operadores de comparación:

#         >  ,   <  ,   >=  ,  <   ,  <=  ,  !=  , ==

# Es muy común el error de instanciar == con =

(Carnivoros<-filter(tmsleep,vore='carni',sleep_total>10))

# * Otro error común es hacer comparaciones de igualdad con puntos flotantes. Los siguientes resultados pueden ser sorpresivos para ti
sqrt(2) ^ 2 == 2
#[1] FALSE
1 / 49 * 49 == 1
#[1] FALSE

###################
# Operadores Logicos

# * Múltiples argumentos de filter() son combinados con “and” : todas las condiciones deben ser verdaderas para incluir el renglón en la salida

# * Se pueden usar los siguientes operadores booleanos:  & es “and”, “|” es “or”, y ! es “not”.


# <img src="images/DiagramasVenn.png"/>

# * El siguiente código encuentra todos los animales del orden taxonómico del Perissodactyla o Primates 
(suborder<- filter(tmsleep, 
   order=="Perissodactyla" | order=="Primates"))


# Un forma util de hacer preguntas de mas de un valor para la misma variables es usando x %in% y

(suborder<- filter(tmsleep, 
   order %in% c("Perissodactyla","Primates")))

# Algunas veces se pueden simplificar la generación de subconjuntos complicados por recordar la ley de morgan:

  #           !(x & y) es  lo mismo que !x | !y

   #          !(x | y) es lo mismo que !x & !y

# Por ejemplo: 

# obtener todos los mamiferos que no duermen menos 10 horas ni tienen periodos de movimiento ocular rápido (rem) menores a 1 hora 

(subsleep<- filter(tmsleep,
                    !(sleep_total < 10), !(sleep_rem < 1 )))
(subsleep<- filter(tmsleep,
                    !(sleep_total < 10 | sleep_rem < 1 )))


# Ordenando renglones con arrange()

# * Arrange()  trabaja similar a filter() excepto que en lugar de seleccionar renglones, cambia su orden. 

# * Ordena los renglones de un data.frame a partir de un conjunto de columnas especificadas (o una expresión mas complicada) 

# * Si seleccionas mas de una columna, cada columna adicional será ordenada en dependencia de los valores de la columna anterior

# Ordenamos en función del peso del cerebro, el peso del cuerpo, el total de horas que se duerme y el tiempo de rem:

arrange(tmsleep, brainwt, bodywt, sleep_total,sleep_rem)


#Los valores perdidos siempre se ordenan al final

df <- tibble(x = c(1, 10,NA, 3))
arrange(df, x)
arrange(df, desc(x)) 


# Seleccionando columnas con select()

# * No es poco común tener conjuntos de datos con miles o varios cientos de variables.  En este caso, lo primero que queremos cambiar es enfocarnos en las variables en las que estamos interesados en este momento.  

# * Select()  nos permite hacer un “zoom” en un subconjunto usando operaciones sobre los nombres de las variables

# Seleccionemos solo el nombre, el peso del cerebro, el peso del cuerpo y el total de horas que se duerme...

select(tmsleep, name, brainwt,bodywt,sleep_total)


# Seleccionemos del nombre a la conservación:

select(tmsleep, name:conservation)

# Seleccionemos todas excepto de genero a nombre a la conservación:

select(tmsleep, -(genus:conservation))

# Existen un grupo de funciones útiles que pueden usarse dentro de select():

# * starts_with("abc"): nombres que empiezan con “abc”.

# * ends_with("xyz"): nombres que terminan con “xyz”.

# * contains("ijk"): nombres que contienen “ijk”.

# * matches("(.)\\1"): selecciona variables que hacen match con una expresión regular. 

# * num_range("x", 1:3): hace match con x1, x2 y x3.

# Ver ?select para mas detalles

################
# Agregando nuevas variables con  mutate()

# * Además de seleccionar conjuntos de columnas existentes, es frecuentemente util adicionar nuevas columnas que son funciones de las columnas existentes.  Ese es el trabajo de mutate()

# * mutate()  permite adicionar nuevas columnas al final de tu dataset asi que empezaremos creando un conjunto de datos mas estrecho para que podamos ver las nuevas variables

# * Recuerda que en R Studio la manera mas facil de ver todas las columnas es con View()

# Generemos una nueva tabla con el nombre, todas las columnas que inicen con sleep, y la columna awake

(sleep_sml<-select(tmsleep, name,starts_with("sleep"),awake))


# Y agreguemos dos columnas:
mutate(sleep_sml, total= sleep_total+awake, prop=sleep_rem/sleep_total)

mutate(sleep_sml,prop=sleep_rem/sleep_total, porcent=prop*100)

###############
#transmute()

# Si solo quieres conservar las variables que acabas de crear, usa transmute()

transmute(sleep_sml,prop=sleep_rem/sleep_total, porcent=prop*100)

# Resumenes Agrupados
#El ultimo verbo es summarize(). Colapsa un data.frame a un simple renglón:

summarize(sleep_sml, sleep=mean(sleep_total),brain=mean(sleep_rem))

# Para evitar el NA:

summarize(sleep_sml, sle=mean(sleep_total),br=mean(sleep_rem,na.rm=TRUE))

# summarise() es mucho mas util cuando se usa a la par de group_by.  Esto cambia la unidad de análisis del grupo completo de datos a grupos individuales. 

vore<-group_by(msleep,vore)
summarize(vore,mean(sleep_total),mean(sleep_rem,na.rm=TRUE))

#Y eso es todo...

veronica.jimenez@ibt.unam.mx


