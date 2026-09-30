# Evaluación 1: Análisis reproducible de deflexión en viga

**Alumno:** Jeffry Aburto

Este repositorio contiene el flujo de trabajo para el cálculo y verificación de la deflexión de una viga rectangular simplemente apoyada, contrastando datos experimentales con la teoría de Euler-Bernoulli.

## Estructura del Proyecto
* `data/`: Contiene los datos originales del problema (`datos_viga.csv`, `parametros_viga.xlsx`, `esquema_viga.png`).
* `analysis/`: Contiene el script automatizado en MATLAB (`analisis_viga.m`).
* `figures/`: Almacena el gráfico de resultados generado por el script.
* `report/`: Contiene la nota técnica final en formato PDF.

## Instrucciones de Reproducción
1. Descargar o clonar este repositorio.
2. Abrir MATLAB y establecer la carpeta `analysis/` como el directorio de trabajo (Current Folder).
3. Ejecutar el script `analisis_viga.m`.
4. El script calculará automáticamente los errores relativos y exportará la gráfica.
