# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises.
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

### Alternativas para video en Linux y `gstreamer >=1`

Distribuciones recientes de Linux que emplean `gstreamer >=1`, requieren alguna de las siguientes librerías de video:

1. [Beta oficial](https://github.com/processing/processing-video/releases).
2. [Gohai port](https://github.com/gohai/processing-video/releases/tag/v1.0.2).

Descompriman el archivo `*.zip` en la caperta de `libraries` de su sketchbook (e.g., `$HOME/sketchbook/libraries`) para instalarla y prueben cual de las dos les funciona.

## Integrantes

Complete la tabla:

| Integrante      | github nick |
|-----------------|-------------|
|Juan Castelblanco | jscastelblancoh |
|Nicolas Ricardo | nicolasenciso |
|Camilo Rodriguez | UNhcrodriguezl |

## Discusión

El trabajo se divide en tres carpetas de la siguiente forma:
punto1_3_4: Correspondiente a la implementación de la escala de grises, el histograma con la segmentación interactiva reflejada en la imágen
punto2: La aplicación de las máscaras desenfoque, enfoque, bordes, realce.
punto5: La medición de los fps para 4 videos simultaneos con dos de las máscaras mencionadas anteriormente y la escala de grises.

## Entrega

* Hacer [fork](https://help.github.com/articles/fork-a-repo/) de la plantilla. Plazo: ~~28/4/19~~ 5/5/19 a las 24h.
* (todos los integrantes) Presentar el trabajo presencialmente en la siguiente sesión de taller.
