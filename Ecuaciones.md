# Ecuaciones | Correlaciones PVT para Aceite Saturado

Este documento resume las ecuaciones empleadas en la aplicación **PVT_AceiteSaturado.mlapp** para estimar propiedades PVT de aceite saturado.

Las propiedades calculadas son:

| Símbolo | Propiedad | Unidad |
|---|---|---|
| Pb | Presión de burbuja | psia |
| Rs | Relación gas disuelto-aceite | pies³/bl |
| Bo | Factor de volumen del aceite | bl/bl |

## Variables principales

| Símbolo | Descripción |
|---|---|
| Tsep | Temperatura del separador, °F |
| Psep | Presión del separador, psia |
| Rsfb | Relación gas disuelto-aceite a Pb, pies³/bl |
| p | Presión de evaluación, psia |
| T | Temperatura de evaluación, °F |
| API | Gravedad API del aceite, °API |
| γg | Densidad relativa del gas |
| γo | Densidad relativa del aceite muerto |
| Mo | Peso molecular del aceite muerto, lb/lbmol |

La densidad relativa del aceite muerto se calcula como:

```math
\gamma_o = \frac{141.5}{131.5 + API}
```

La temperatura en Rankine se calcula como:

```math
T_R = T + 459.67
```

---

## 1. M. B. Standing

```math
A = 0.0125API - 0.00091T
```

```math
P_b = 18.2\left(\frac{R_{sfb}}{\gamma_g}\right)^{0.83}10^{(0.00091T - 0.0125API)}
```

```math
R_s = \gamma_g\left[\left(\frac{p}{18.2}+1.4\right)10^A\right]^{1.2048}
```

```math
B_o = 0.9759 + 0.00012\left[R_s\left(\frac{\gamma_g}{\gamma_o}\right)^{0.5}+1.25T\right]^{1.2}
```

---

## 2. Vázquez-Beggs

Corrección de densidad relativa del gas:

```math
\gamma_{gs}=\gamma_g\left[1+5.912\times10^{-5}API(T_{sep,R}-460)\log_{10}\left(\frac{P_{sep}}{114.7}\right)\right]
```

Para `API ≤ 30`:

```math
C_1=0.0362,\quad C_2=1.0937,\quad C_3=25.724
```

Para `API > 30`:

```math
C_1=0.0178,\quad C_2=1.187,\quad C_3=23.931
```

```math
P_b = \left[\frac{R_{sfb}}{C_1\gamma_{gs}\exp\left(\frac{C_3API}{T+459.67}\right)}\right]^{1/C_2}
```

```math
R_s = C_1\gamma_{gs}p^{C_2}\exp\left(\frac{C_3API}{T+459.67}\right)
```

```math
B_o = 1 + C_4R_s + C_5(T-60)\left(\frac{API}{\gamma_{gs}}\right)+C_6R_s(T-60)\left(\frac{API}{\gamma_{gs}}\right)
```

---

## 3. Glaso

```math
A=\left(\frac{R_{sfb}}{\gamma_g}\right)^{0.816}\left(\frac{T^{0.172}}{API^{0.989}}\right)
```

```math
P_b = 10^{\left[1.7669 + 1.7447\log_{10}(A)-0.30218(\log_{10}(A))^2\right]}
```

```math
X = 2.8869 - \sqrt{14.1811 - 3.3093\log_{10}(p)}
```

```math
R_s = \gamma_g\left[\left(\frac{API^{0.989}}{T^{0.172}}\right)10^X\right]^{1.2255}
```

```math
F_o = R_s\left(\frac{\gamma_g}{0.8761}\right)^{0.526}+0.968T
```

```math
A_{bo}=-6.58511+2.91329\log_{10}(F_o)-0.27683(\log_{10}(F_o))^2
```

```math
B_o = 1+10^{A_{bo}}
```

---

## 4. J. A. Lasater

```math
M_o = 725.321 - 16.0333API + 0.09524API^2
```

```math
Y_g = \frac{R_{sfb}/379.5}{(R_{sfb}/350)+(350/M_o)}
```

```math
P_f = 0.3841 - 1.2008Y_g + 9.648Y_g^2
```

```math
P_b = \frac{P_f(T+459.67)}{Y_g}
```

```math
R_s = \frac{\gamma_o(132775)Y_g}{M_o(1-Y_g)}
```

Esta implementación no calcula `Bo` directamente para Lasater.

---

## 5. TOTAL

La correlación TOTAL usa coeficientes diferentes según el rango de gravedad API.

```math
P_b = C_1\left(\frac{R_{sfb}}{\gamma_g}\right)^{C_2}10^{(C_3T-C_4API)}
```

```math
R_s = \gamma_g\left[\left(\frac{p}{C_1}\right)10^{(C_2API-C_3T)}\right]^{C_4}
```

```math
B_o = 1.022 + 4.857\times10^{-4}R_s - 2.009\times10^{-6}(T-60)\left(\frac{API}{\gamma_g}\right) + 17.569\times10^{-9}R_s(T-60)\left(\frac{API}{\gamma_g}\right)
```

---

## 6. Al-Marhoun

```math
P_b = 5.38088\times10^{-3}R_{sfb}^{0.715082}\gamma_g^{-1.87784}\gamma_o^{3.1437}(T+459.67)^{1.32657}
```

```math
R_s = \left[185.84321p\gamma_g^{1.87784}\gamma_o^{-3.1437}(T+459.67)^{-1.32657}\right]^{1.3984}
```

```math
F = R_s^{0.74239}\gamma_g^{0.323294}\gamma_o^{-1.20204}
```

```math
B_o = 0.497069 + 0.862963\times10^{-3}T + 0.182594\times10^{-2}F + 0.318099\times10^{-5}F^2
```

---

## 7. Kartoatmodjo y Schmidt

```math
\gamma_{gc}=\gamma_g\left[1+0.1595API^{0.4078}T_{sep}^{-0.2466}\log_{10}\left(\frac{P_{sep}}{114.7}\right)\right]
```

```math
P_b = \left[\frac{R_{sfb}}{C_1\gamma_{gc}^{C_2}10^{\left(\frac{C_3API}{T+459.67}\right)}}\right]^{C_4}
```

```math
R_s = C_1\gamma_{gc}^{C_2}p^{1/C_4}10^{\left(\frac{C_3API}{T+459.67}\right)}
```

```math
F = R_s^{0.755}\gamma_{gc}^{0.25}(0.87)^{-1.5}+0.45T
```

```math
B_o = 0.98496 + 10^{-4}F^{1.5}
```

---

## 8. Petrosky-Farshad

```math
x = 7.916\times10^{-4}API^{1.5410} - 4.561\times10^{-5}T_F^{1.3911}
```

```math
P_b = \frac{112.727R_{sfb}^{0.577421}}{\gamma_g^{0.8439}10^x}-1391.051
```

```math
R_s = \left[\frac{(p+1391.051)\gamma_g^{0.8439}10^x}{112.727}\right]^{1/0.577421}
```

```math
F = R_s^{0.3738}\left(\frac{\gamma_g^{0.2914}}{\gamma_o^{0.6265}}\right)+0.24626T_F^{0.5371}
```

```math
B_o = 1.0113 + 7.2046\times10^{-5}F^{3.0936}
```

---

## 9. Dokla-Osman

```math
P_b = a_1\gamma_g^{a_2}\gamma_o^{a_3}R_{sfb}^{a_4}T_R^{a_5}
```

Donde:

```math
a_1=8363.86,\quad a_2=-1.01049,\quad a_3=0.107991,\quad a_4=0.724047,\quad a_5=-0.952584
```

```math
R_s = \left[\frac{p}{a_1\gamma_g^{a_2}\gamma_o^{a_3}T_R^{a_5}}\right]^{1/a_4}
```

```math
X = R_s^{0.773572}\gamma_g^{0.404020}\gamma_o^{-0.882607}
```

```math
B_o = 0.0431935 + 0.00156667T_R + 0.00139775X - 3.80525\times10^{-6}X^2
```

---

## 10. De Ghetto, Paone y Villa

```math
P_b = 21.7429\left(\frac{R_{sfb}}{\gamma_g}\right)^{0.7646}10^{(0.00119T-0.0101API)}
```

```math
R_s = \gamma_g\left[\frac{p}{21.7429\cdot10^{(0.00119T-0.0101API)}}\right]^{1/0.7646}
```

Para `Bo`, esta implementación usa la forma de Vázquez-Beggs:

```math
B_o = 1 + C_4R_s + C_5(T-60)\left(\frac{API}{\gamma_{gs}}\right)+C_6R_s(T-60)\left(\frac{API}{\gamma_{gs}}\right)
```

---

## Nota

Las correlaciones son empíricas y su aplicación debe considerar el rango de validez de cada modelo. Los resultados se deben interpretar como estimaciones cuando no se dispone de un análisis PVT experimental completo.
