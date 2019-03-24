### Meta
Este archivo está disponible en 3 versiones:
 - [jupyter notebook original](readme.ipynb) (avanzado)
 - [html distribuible](../../raw/master/readme.html) (intermedio: click derecho descargar archivo )
 - mark down online (simplificado: es este archivo)
___
# Lenguaje de programación y testeo estadístico: el caso de Ventanas
## Una comparativa entre la zona crítica y resto de Chile
### Introducción
Mediante programación en phyton es posible estandarizar en forma sencilla los registros de defunciones oficiales, que tienen una serie de variaciones año a año. Una vez construida una [unificación de los registros de defunciones en Chile, entre el año 1998 y 2016](https://github.com/verasativa/defunciones-decoder), surge la pregunta general: ¿Se podrán observar en éste, rasgos distintos en una zona crítica al resto de Chile? Con el mismo lenguaje de programación podría testearse esa hipótesis.
### Comparación de diagnósticos primarios
Apalancándose en la integración jerárquica, de los códigos de diagnóstico CIE-10 en el dataset. Una comparación de éstos, se presenta como la opción más evidente y atractiva, pero con algunas consideraciones.
### Limitaciones
Dado que este dataset solo incluye las defunciones, y no contiene información sobre la población general, no es posible hacer un análisis respecto a tasas de ocurrencia, sin tener que argumentar con otros datos como censos. Además la ruralidad de la zona, conjugada con la migración campo-ciudad, produce una población envejecida. Tampoco podemos hacer un análisis sobre la distribución etaria de la mortalidad, ni la distribución de diagnósticos primarios en la población general, sin normalizar primero con datos adicionales.
### Pregunta de investigación
Con esas limitaciones en mente, podemos plantear una pregunta sencilla, pero contestable:

__¿Como se comparan los diagnósticos primarios de defunciones, en la zona de interés con respecto al resto del país, en menores de 16 años?__

__Algunos datos sobre los grupos:__

<pre>
Total defunciones en el grupo de control: 57785
Total defunciones en los 10 principales diagnósticos primarios del grupo de control: 56422
Fracción del total: 0.976
</pre>

<pre>
Total defunciones en el grupo de control: 57785
Total defunciones en los 10 principales diagnósticos primarios del grupo de control: 56422
Fracción del total: 0.976
</pre>

<img src="assets/10diagnosticos.png">

## Observaciones
Al comparar estos gráficos, inmediatamente notamos que el diagnostico primario "Malformaciones congénitas, deformidades y anomalías cromosómicas" (CIE-10: Q00-Q99), es considerablemente más alto en el grupo de interés, por sobre el grupo de control (34.8% por sobre 27.2%).
## Validación
Para validar esta observación, realizaremos una prueba de permutación:

Tomamos 1.000.000 de muestras del mismo tamaño que el grupo de interés (326) desde el grupo de control, y observaremos la distribución del diagnostico primario de interés en estas muestras, a fin de responder:

__¿Qué tan probable es observar la incidencia (34.8%) que se da nuestro grupo de interés, en cualquier otro grupo del mismo tamaño muestreado al azar desde el grupo de control?__ (azar en contraste con casos seleccionados por zona geográfica de interés)

## Distribución del diagnostico de interés en las permutaciones
A continuación graficamos la distribución (fraccional) del diagnóstico primario en las 10.000 permutaciones. Y trazamos una línea vertical en el valor encontrado en la zona de interés, a fin de ilustrar la posibilidad de obtener este resultado al azar.

<img src="assets/distribucion.png">

## Otros valores de interés
El gráfico anterior, muestra que es extremadamente improbable obtener la incidencia del diagnostico primario de interés (malformaciones congénitas, deformidades y anomalías cromosómicas), que se observa la zona de interés, desde muestras del mismo tamaño tomadas al azar desde el resto de Chile.

A continuación cuantificamos la observación anterior con los siguientes números:
 - Probabilidad de obtener este resultado o más al azar (P-Value)
 - Incidencia promedio en muestras al azar desde el grupo de control
 - Desviación standard de muestras al azar desde el grupo de control
 - Cuantificación en desviaciones standards de cuanto se aleja la observación de interés desde el promedio de los 10.000 re-muestreos
 
 
<pre>
P-value: 0.0011
Promedio de las muestras: 0.2709
Desviación standard de las muestras: 0.0247
Distancia entre el promedio de las muestras y el grupo de interés en desviaciones standard: 3.12
</pre>
## Variaciones en el P-value
A razón de haber observado variaciones en el primer dígito no-cero del P-value en las primeras ejecuciones de 10.000 re-muestreos, se aumento la cantidad de re-muestreos en 2 ordenes de magnitud. Y para entender como se comporta este P-value respecto a la cantidad de re-muestreos, se toman sub-muestras del millón de muestras en incrementos de 500. Al graficar, el P-value en estas distintas cantidades de re-muestreos, se observa que con el n inicial de 10.000 se lograba estabilizar en su orden de magnitud (~0.01%), con un millón se logran estabilizar los primeros dos dígitos que no son cero (0.011%).

<img src="assets/variacion-p-values.png">

## Conclusiones
Con una posibilidad de 0.11% de encontrar el nivel de incidencia del diagnóstico _malformaciones congénitas, deformidades y anomalías cromosómicas_ (CIE-10: Q00-Q99) que se presenta en la zona de interés (34.8%) o mayor, podemos asumir que la incidencia mayor observada no es producto del azar. Correspondería a los expertos del área (salud, bioquímica, ecología, etc.) plantear rutas específicas que llevan al incremento de las defunciones bajo este diagnóstico primario. Y por otra parte a los gobernantes hacer la prueba de campo, descartando las causales en sospecha, para poder observar en algunas décadas, la evolución de la incidencia de este diagnóstico primario en las defunciones de la zona.

### Potencial futuro de la metodología
La técnica particular puede ser escalada para buscar este tipo de fenómenos a nivel nacional sin especificar una zona en particular, lo que podría revelar problemas de salud pública fuera del "radar" de los investigadores. Para esto se requeriría construir un graph con comunas como nodos, y sus colindacias geográficas como vértices (tal vez con [estos vectores](https://www.bcn.cl/siit/mapas_vectoriales/index_html)), e iterar sobre grupos de comunas colindantes con un mínimo de registros totales. De realizarse, se sugiere el nombre: _Perico_ para tal script que _treparía por Chile_
#### Contacto
Vera Sativa  
hola@verasativa.com

# Bibliografía
http://haghish.com/resources/materials/Statistical_Methods_for_Research_Workers.pdf

## Publicaciones sobre la zona:
[Spatial gradient of human health risk from exposure to trace elements and radioactive pollutants in soils at the Puchuncaví-Ventanas industrial complex, Chile.](https://www.sciencedirect.com/science/article/pii/S0269749116305693)  
_S. Salmani Ghabeshi, M.R. Palomo Marin, E. Bernalte, F. Rueda Holgado, C. Miro Rodriguez, F. Cereceda Balic, X. Fadic, V. Vidal, M. Funes, E. Pinilla Gil_  
2016, Environmental Pollution

[Representaciones sociales acerca del impacto medioambiental de las empresas termoeléctricas en la bahía de Quintero-Puchuncaví](https://summapsicologica.cl/index.php/summa/article/view/188)  
_Claudia Carrasco Aguilar, Pamela Morales Bierschwale, Jenniffer Salazar Fuentes_  
2015, Summa Psicológica

[Spatial distribution of copper and pH in soils affected by intensive industrial activities in Puchuncaví and Quintero, central Chile](http://jsspn.ufro.cl/index.php?option=com_docman&task=doc_download&gid=451&Itemid=6)  
_I. Gonzalez, A. Neaman, P. Rubio, A. Cortes_  
2014, Journal of soil science and plant nutrition

Fractionation of trace elements in total atmospheric deposition by filtrating-bulk passive sampling.  
_F. Rueda Holgado, M.R. Palomo Marin, L. Calvo Blazquez, F. Cereceda Balic, E. Pinilla Gil_  
2014, Talanta
 
Selenium and its redox speciation in rainwater from sites of Valparaiso region in Chile, impacted by mining activities of copper ores.  
_Gregori Ida De, Maria G. Lobos, Hugo Pinochet_  
2002, Water research
 
Hypo-interventions: Intimate activism in toxic environments.  
_Manuel Tironi_  
2018, Social studies of science

Proposed modification to avoidance test with Eisenia fetida to assess metal toxicity in agricultural soils affected by mining activities.  
_Victor Delgadillo, Jose Verdejo, Pedro Mondaca, Gabriela Verdugo, Hernan Gaete, Mark E. Hodson, Alexander Neaman_  
2017, Ecotoxicology and Environmental Safety
 
Distribution of trace elements in particle size fractions for contaminated soils by a copper smelting from different zones of the Puchuncaví Valley (Chile).  
_Sonnia Parra, Manuel A. Bravo, Waldo Quiroz, Teresa Moreno, Angeliki Karanasiou, Oriol Font, Victor Vidal, Francisco Cereceda_  
2014, Chemosphere
 
Effects of lime and compost on earthworm (Eisenia fetida) reproduction in copper and arsenic contaminated soils from the Puchuncaví Valley, Chile.  
_Alexander Neaman, Soledad Huerta, Sebastien Sauve_  
2012, Ecotoxicology and Environmental Safety
 
Long-term assessment of ecological risk from deposition of elemental pollutants in the vicinity of the industrial area of Puchuncaví-Ventanas, central Chile.  
_Soroush Salmanighabeshi, M. Rosario Palomo Marin, Elena Bernalte, Fernando Rueda Holgado, Conrado Miro Rodriguez, Ximena Fadic Ruiz, Victor Vidal Cortez, Francisco Cereceda Balic, Eduardo Pinilla Gil_  
2015, The Science of the total environment
 
Simultaneous immobilization of metals and arsenic in acidic polluted soils near a copper smelter in central Chile.  
_Valeska Carcamo, Elena Bustamante, Elizabeth Trangolao, Luz Maria De La Fuente, Michel Mench, Alexander Neaman, Rosanna Ginocchio_  
2012, Environmental Science and Pollution Research
 
Copper mobility in contaminated soils of the Puchuncaví valley, central Chile  
_Alexander Neaman, Luis Reyes, Fabienne Trolard, Guilhem Bourrie, Sebastien Sauve_  
2009, Geoderma
 
Conflicto ambiental en Ventanas: Análisis desde una perspectiva de la Doctrina Social de la Iglesia  
_Kay Bergamini Ladron De Guevara, Ricardo Irarrazabal Sanchez, Piroska Angel Hernandez_  
2018, Revista de Historia y Geografía
 
Temporal and spatial variation of trace elements in atmospheric deposition around the industrial area of Puchuncaví-Ventanas (Chile) and its influence on exceedances of lead and cadmium critical loads in soils.  
_F. Rueda Holgado, L. Calvo Blazquez, F. Cereceda Balic, E. Pinilla Gil_  
2016, Chemosphere
 
Amendments promote the development of Lolium perenne in soils affected by historical copper smelting operations.  
_Paul Goecke, Rosanna Ginocchio, Michel Mench, Alexander Neaman_  
2011, International Journal of Phytoremediation
 
Acumulación de cobre en una comunidad vegetal afectada por contaminación minera en el valle de Puchuncaví, Chile central  
_Isabel Gonzalez, Victoria Muena, Mauricio Cisternas, Alexander Neaman_  
2008, Revista chilena de historia natural
 
MODELACIÓN DE LA DISPERSIÓN DE ANHÍDRIDO SULFUROSO EN LA COMUNA DE LA COMUNA DE PUCHUNCAVÍ UTILIZANDO EL PROGRAMA ISC3  
_Pamela Lazo, Michel Cure, Hernan Gaete_  
2006, Ingeniare Revista chilena de ingeniería
 
Monitoring of copper, arsenic and antimony levels in agricultural soils impacted and non-impacted by mining activities, from three regions in Chile.  
_Ida De Gregori, Edwar Fuentes, Mariela Rojas, Hugo Pinochet, Martine Potin Gautier_  
2003, Journal of Environmental Monitoring
 
Effects of a copper smelter on a grassland community in the Puchuncaví Valley, Chile.  
_R. Ginocchio_  
2000, Chemosphere
 
Comparative Study of Copper and Selenium Pollution in Agricultural Ecosystems from Valparaiso Region, Chile  
_I. De Gregori, G. Lobos, S. Lobos, H. Pinochet, M. Potin Gautier, M. Astruc_  
2000, Environmental Technology
 
Acute effects of the breathing of industrial waste and of sulfur dioxide on the respiratory health of children living in the industrial area of Puchuncaví, Chile.  
_J. Sanchez, I. Romieu, S. Ruiz, P. Pino, M. Gutierrez_  
1999, Revista Panamericana de Salud Pública
 
Efectos agudos de las partículas respirables y del dióxido de azufre sobre la salud respiratoria en niños del área industrial de Puchuncaví, Chile  
_Juan Sanchez, Isabelle Romieu, Silvia Ruiz, Paulina Pino, Monica Gutierrez_  
1999, Revista Panamericana de Salud Pública