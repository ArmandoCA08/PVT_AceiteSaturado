# Correlaciones PVT | Aceite Saturado

![Estado](https://img.shields.io/badge/Estado-Terminado-brightgreen)
![MATLAB](https://img.shields.io/badge/MATLAB-App%20Designer-orange)
![Área](https://img.shields.io/badge/%C3%81rea-Ingenier%C3%ADa%20Petrolera-darkgreen)
![PVT](https://img.shields.io/badge/PVT-Aceite%20Saturado-blue)
![Correlaciones](https://img.shields.io/badge/Correlaciones-Pb%20%7C%20Rs%20%7C%20Bo-lightgrey)

Este repositorio contiene una aplicación desarrollada en **MATLAB App Designer** para calcular propiedades PVT de **aceite saturado** mediante correlaciones empíricas. La app permite estimar la **presión de burbuja (Pb)**, la **relación gas disuelto-aceite (Rs)** y el **factor de volumen del aceite (Bo)** a partir de datos de laboratorio y condiciones de presión y temperatura.

El archivo principal del repositorio es:

```text
PVT_AceiteSaturado.mlapp
```

## Vista previa de la aplicación

### Ejemplo de cálculo de presión de burbuja, Pb

![Captura de app PVT aceite saturado con ejemplo Pb](Im%C3%A1genes/Captura%20de%20app%20PVT%20aceite%20saturado%20con%20ejemplo%20Pb.png)

## Modelos incluidos

La aplicación incluye correlaciones empíricas para el cálculo de propiedades PVT de aceite saturado. Actualmente se consideran los siguientes modelos:

- M. B. Standing
- Vázquez-Beggs
- Glaso
- J. A. Lasater
- TOTAL
- Al-Marhoun
- Kartoatmodjo y Schmidt
- Petrosky-Farshad
- Dokla-Osman
- De Ghetto, Paone y Villa

El usuario puede seleccionar una correlación específica o elegir la opción **Todas**, con la cual la app ejecuta todas las correlaciones disponibles y muestra los resultados comparativos en tabla y gráficas.

## Ejecución del programa

Para ejecutar la aplicación, abra el archivo principal en MATLAB App Designer:

```text
PVT_AceiteSaturado.mlapp
```

Después, ingrese los datos solicitados, seleccione la correlación deseada y presione el botón **Calcular**. La aplicación mostrará los resultados en una tabla y generará gráficas independientes para **Pb**, **Rs** y **Bo**.

También se incluye un archivo de apoyo en MATLAB:

```text
PVT_AceiteSaturado.m
```

Este script contiene datos de ejemplo y permite ejecutar los cálculos directamente desde MATLAB para generar las tres gráficas principales sin abrir la app.

## Datos de entrada solicitados por la app

| Variable | Nombre del dato | Unidad |
|---|---|---|
| Tsep | Temperatura del separador | °F |
| Psep | Presión del separador | psia |
| Bofb | Factor de volumen del aceite a la presión de burbuja | bl @ c.b. / bl @ c.s. |
| Rsfb | Relación gas disuelto-aceite a la presión de burbuja | pies³/bl |
| Pb | Presión de burbuja experimental | psia |
| Tb | Temperatura a la presión de burbuja | °F |
| p | Presión de evaluación o presión del sistema | lb/pg² abs |
| T | Temperatura de evaluación o temperatura del yacimiento | °F |
| API | Gravedad API del aceite | °API |
| γg | Densidad relativa del gas | adimensional |
| Mo | Peso molecular del aceite muerto | lb/lbmol |
| γo | Densidad relativa del aceite muerto a 60 °F | adimensional |

## Interfaz de captura de datos

![Captura de app PVT aceite saturado](Im%C3%A1genes/Captura%20de%20app%20PVT%20aceite%20saturado.png)

## Ecuaciones empleadas

Las ecuaciones utilizadas por cada correlación se documentan en `Ecuaciones.md` dentro de este repositorio.

## Referencias

- Standing, M. B. (1947). *A pressure-volume-temperature correlation for mixtures of California oils and gases*. Drilling and Production Practice, API.
- Vázquez, M., & Beggs, H. D. (1980). *Correlations for fluid physical property prediction*. Journal of Petroleum Technology.
- Glaso, O. (1980). *Generalized pressure-volume-temperature correlations*. Journal of Petroleum Technology.
- Lasater, J. A. (1958). *Bubble point pressure correlation*. Journal of Petroleum Technology.
- Al-Marhoun, M. A. (1988). *PVT correlations for Middle East crude oils*. Journal of Petroleum Technology.
- Kartoatmodjo, T., & Schmidt, Z. (1994). *Large data bank improves crude physical property correlations*. Oil & Gas Journal.
- Petrosky, G. E., & Farshad, F. F. (1993). *Pressure-volume-temperature correlations for Gulf of Mexico crude oils*. SPE Annual Technical Conference and Exhibition.
- Dokla, M. E., & Osman, M. E. (1992). *Correlation of PVT properties for UAE crudes*. SPE Formation Evaluation.
- De Ghetto, G., Paone, F., & Villa, M. (1995). *Reliability analysis on PVT correlations*. European Petroleum Conference.
