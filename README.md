# Análisis de la Relación entre Salud Mental y Dimensiones Corporales en niños utilizando el Conjunto de Datos `HELPrct` y `KidsFeet`.

Este repositorio contiene código en R que realiza un análisis estadístico utilizando el conjunto de datos `HELPrct`. Se exploran la correlación, regresión lineal y diagnósticos de modelo para examinar la relación entre las variables de salud mental y depresión.

## Contenidos

### 1. Análisis de Correlación
```r
library(mosaic)
data(HELPrct)
cor(cesd ~ mcs, data = HELPrct)
```
- Se carga el paquete `mosaic` y el conjunto de datos `HELPrct`.
- Se calcula el coeficiente de correlación entre las variables `cesd` (escala de depresión) y `mcs` (salud mental).

### 2. Gráfico de Dispersión con Línea de Regresión
```r
gf_point(cesd ~ mcs, data = HELPrct) %>%
gf_lm(linewidth = 1.5, linetype = "dashed") %>%
gf_smooth(color = "red")
```
- Se crea un gráfico de dispersión para visualizar la relación entre `cesd` y `mcs`.
- Se añade una línea de regresión y una línea de suavizado.

### 3. Regresión Lineal
```r
cesdmodel <- lm(cesd ~ mcs, data = HELPrct)
msummary(cesdmodel)
report(cesdmodel)
```
- Se ajusta un modelo de regresión lineal simple donde `cesd` es la variable dependiente y `mcs` la independiente.
- Se generan resúmenes del modelo para analizar los resultados.

### 4. Predicción
```r
lm_fun <- makeFun(cesdmodel)
lm_fun(mcs = 35)
```
- Se crea una función de predicción basada en el modelo ajustado, permitiendo predecir valores de `cesd` dados valores específicos de `mcs`.

### 5. Análisis del modelo
```r
anova(cesdmodel)
coef(cesdmodel)
confint(cesdmodel)
rsquared(cesdmodel)
```
- Se realiza un análisis de varianza para evaluar la significancia del modelo.
- Se extraen los coeficientes del modelo, los intervalos de confianza y el R cuadrado.

### 6. Diagnósticos del modelo
```r
gf_dhistogram(~resid(cesdmodel))
gf_qq(~resid(cesdmodel))
```
- Se evalúan los residuos del modelo mediante histogramas y gráficos Q-Q para verificar la normalidad.

### 7. Gráfico de Residuos vs. Valores Ajustados
```r
gf_point(resid(cesdmodel) ~ fitted(cesdmodel)) %>%
gf_lm(size = 2) -> p
p + labs(x= "Valores ajustados", y="Residuos")
```
- Se crea un gráfico que muestra los residuos en función de los valores ajustados para evaluar la homocedasticidad.

### 8. Prueba t de dos muestras
```r
t_test(length ~ sex, data = KidsFeet)
```
- Se compara la longitud entre grupos de sexo utilizando el conjunto de datos `KidsFeet`.

### 9. Análisis del Conjunto de Datos `genderweight`
```r
t_test(weight ~ group, data = genderweight)
```
- Se compara el peso entre grupos y se realizan pruebas de hipótesis.

### 10. Prueba de normalidad
```r
shapiro.test(weight)
```
- Se verifica la normalidad del peso utilizando la prueba de Shapiro-Wilk.

### 11. Prueba t para Datos Emparejados
```r
t_test(mice2$before, mice2$after, paired=TRUE)
```
- Se comparan medidas "antes" y "después" utilizando el conjunto de datos `mice2`.

## Requisitos
Asegúrate de tener instalados los siguientes paquetes en R:
- `mosaic`
- `report`
- `datarium`
- `ggplot2`

## Ejecución
Puedes ejecutar cada sección de código en tu entorno de R para reproducir los análisis y visualizaciones. Asegúrate de cargar los datos requeridos antes de ejecutar el análisis correspondiente.

## Contribuciones
Las contribuciones son bienvenidas. Si tienes sugerencias o mejoras, siéntete libre de abrir un issue o un pull request.

## Referencias

- **Conjunto de Datos `HELPrct`**: Este conjunto de datos proviene del paquete `mosaic`, que incluye información sobre la salud mental de adolescentes. Para más detalles, puedes consultar el documento original: [HELPrct Dataset Documentation](https://cran.r-project.org/web/packages/mosaic/mosaic.pdf#page=16).
- **Paquete `mosaic`**: [CRAN](https://cran.r-project.org/web/packages/mosaic/index.html)
- **Paquete `report`**: [CRAN](https://cran.r-project.org/web/packages/report/index.html)
- **Paquete `datarium`**: [CRAN](https://cran.r-project.org/web/packages/datarium/index.html)
- **Paquete `ggplot2`**: [CRAN](https://cran.r-project.org/web/packages/ggplot2/index.html)
