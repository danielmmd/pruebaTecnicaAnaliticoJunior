# Proyecto: Prueba Técnica SQL y Machine Learning

# Autor: Daniel Jesus Marrugo Mulford

Este proyecto contiene la resolución de una prueba técnica dividida en dos actividades principales:

---

## Actividad 1 - Consultas SQL

Ubicación: `./Actividad-1`

Esta sección incluye una serie de consultas SQL elaboradas sobre un modelo relacional proporcionado en imagen. Las consultas están diseñadas para ejecutarse sobre un motor **Impala** e incluyen el uso de **CTEs** (`WITH`) para facilitar la legibilidad.

**Contenido:**

* Consultas para unir todas las tablas y calcular totales.
* Análisis de ventas por producto, categoría y vendedor.
* Identificación de productos con mayores ventas.
* Buenas prácticas para optimización de consultas SQL.

---

## Actividad 2 - Modelo Predictivo de Gasto

Ubicación: `./Actividad-2`

Esta sección contiene un notebook (`Ejercicio2.ipynb`) para cargar, explorar y modelar un dataset de transacciones financieras con el objetivo de **predecir los gastos por categoría** de los clientes.

**Dataset utilizado:**

> Financial Transactions Dataset: Analytics - [https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets)

**Tecnologías utilizadas:**

* Python 3
* pandas, numpy, scikit-learn, kagglehub, matplotlib
* Jupyter Notebook

**Pasos desarrollados en el notebook:**

¡Por supuesto! Basado en lo que realmente hiciste en tu notebook y el flujo de trabajo que seguiste, aquí tienes una versión actualizada y más precisa de la sección:

---

### ✅ **Pasos desarrollados en el notebook:**

1. **Descarga del dataset** utilizando `kagglehub` desde Kaggle.
2. **Carga de datos** desde el archivo `transactions_data.csv` a un DataFrame de pandas.
3. **Análisis exploratorio (EDA)** inicial del tamaño del dataset, tipos de datos y valores nulos.
4. **Limpieza de datos:**

   * Conversión de `amount` a tipo numérico (`float64`)
   * Conversión de `client_id` y `mcc` a tipo `str`
   * Eliminación de filas con valores nulos en columnas clave
5. **Transformación de datos:**

   * Agrupación por `client_id` y `mcc` para calcular el gasto total por categoría
   * Creación de una matriz cliente vs categoría (`pivot table`)
6. **Preparación para modelado:**

   * Separación en variables predictoras (`X`) y variables objetivo (`y`)
   * División en conjuntos de entrenamiento y prueba (80/20)
7. **Entrenamiento del modelo:**

   * Utilización de `RandomForestRegressor` dentro de `MultiOutputRegressor` para predecir múltiples categorías simultáneamente
8. **Evaluación del modelo:**

   * Cálculo de métricas como `RMSE` y `R²` promedio por categoría
   * Visualización de resultados e interpretación de desempeño

---

## Instalación del entorno

> Se recomienda utilizar un entorno virtual para mantener las dependencias aisladas.

### 1. Crear entorno virtual

```bash
python -m venv venv
```

### 2. Activar el entorno

* En Windows:

```bash
venv\Scripts\activate
```

* En macOS/Linux:

```bash
source venv/bin/activate
```

### 3. Instalar dependencias

```bash
pip install -r requirements.txt
```

---

## Estructura del proyecto

```
├── Actividad-1
│   └── sentencias_sql_impala.sql
├── Actividad-2
│   └── Ejercicio2.ipynb
├   └── gastos_por_cliente_categoria.csv (archivo generado por el modelo despues de compilar)
├   └── modelo_gastos_multisalida.pkl (archivo generado por el modelo despues de compilar)
├── requirements.txt
├── .gitignore
└── README.md
```

---

## Notas finales

* Asegúrate de tener instalada la extensión de Jupyter si trabajas en VS Code.
* El entorno virtual `venv/` está excluido del repositorio mediante `.gitignore`.
* Si deseas replicar el entorno, recuerda usar el archivo `requirements.txt`.

---


