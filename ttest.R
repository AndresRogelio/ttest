# Dos variables cuantitativas
# Coeficiente de correlación
library(mosaic)
data(HELPrct)
head(HELPrct)
cor(cesd ~ mcs, data = HELPrct)

# Diagrama de dispersión con línea de regresión y suavizado
gf_point(cesd ~ mcs, data = HELPrct) %>%
gf_lm(linewidth = 1.5, linetype = "dashed") %>%
gf_smooth(color = "red")

# Regresión lineal simple
cesdmodel <- lm(cesd ~ mcs, data = HELPrct)
msummary(cesdmodel)
library(report)
report(cesdmodel)

# Predicción
lm_fun <- makeFun(cesdmodel)
lm_fun(mcs = 35)

# Extraer cantidades útiles
anova(cesdmodel) # Tabla de análisis de la varianza
coef(cesdmodel)  # Coeficientes
confint(cesdmodel) # Intervalos de confianza
rsquared(cesdmodel) # R cuadrado

# Diagnóstico; gráfico de residuos
gf_dhistogram(~resid(cesdmodel))
gf_qq(~resid(cesdmodel))

# Diagnóstico; gráfico de los residuos frente al ajuste
gf_point(resid(cesdmodel) ~ fitted(cesdmodel)) %>%
gf_lm(size = 2) -> p
p + labs(x= "Valores ajustados", y="Residuos")

#------------------------------------------------------------
# Predictor de dos niveles: prueba t de dos muestras
# Resúmenes numéricos
favstats(~length | sex, data = KidsFeet)

# Resúmenes gráficos
gf_qq(~ length | sex, data = KidsFeet) %>%
gf_qqline() %>%
gf_labs(x = "Cuantil normal", y = "Longitud (cm)")


# Prueba t de dos muestras e intervalo de confianza
t_test(length ~ sex, data = KidsFeet)  # ver resultados 
result <- t_test(length ~ sex, data = KidsFeet) # guardar resultados
report(result)
confint(result)
pval(result)

#--------------------------------------------------
favstats(age ~ sex, data = HELPrct)
gf_boxplot(age ~ sex, data = HELPrct)

t_test(~ age, groups = sex, data = HELPrct)
result <- t_test(~ age, groups = sex, data = HELPrct)
report(result)
# No rechazaríamos la Ho con un nivel de confianza del 95%.
confint(result)
pval(result)


# ----------------------------
library(datarium)
data("genderweight")
head(genderweight)
names(genderweight)
favstats(weight ~ group, data = genderweight)
gf_boxplot(weight ~ group, data = genderweight)

t_test(~ weight, groups = group, data = genderweight)
result <- t_test(weight ~ group, data = genderweight)
report(result)
report_table(result)
# Rechazaríamos la Ho con un nivel de confianza del 95%.
confint(result)
pval(result)

# Calcular la prueba de Shapiro wilk por grupos

genderweight %>%
  group_by(group) %>%
  shapiro.test(weight)

# Dibujar un gráfico qq por grupo
ggqqplot(genderweight, x = "weight", facet.by = "group")
#-------------------------
data(mice2)
head(mice2)
names(mice2)

t_test(mice2$before, mice2$after, paired=TRUE)
result <- t_test(mice2$before, mice2$after, paired=TRUE)
report(result)
report_table(result)
pval(result)
# Rechazaríamos la Ho con un nivel de confianza del 95%.
confint(result)



# Draw a qq plot by group
ggqqplot(genderweight, x = "weight", facet.by = "group")