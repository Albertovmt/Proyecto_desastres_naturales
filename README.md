# 📘 README — Análisis de Desastres Naturales (1900–2026)

## 📌 Descripción del proyecto

Este proyecto realiza un análisis integral de desastres naturales a nivel global desde **1900 hasta 2026**. Los datos proceden de dos fuentes principales:

### **EM-DAT (The International Disasters Database)**
- Utilizada para obtener información completa sobre desastres naturales, muertes y personas afectadas.

### **Dataset adicional de terremotos (Kaggle)**
- Contiene información detallada sobre magnitud, severidad y frecuencia de eventos sísmicos.

Ambos datasets fueron **unificados, estandarizados y enriquecidos mediante geolocalización**.  
A partir de ellos se construyó una base de datos SQL para realizar análisis avanzados y generar visualizaciones.

---

## 📂 Estructura general del proyecto

```
proyecto-desastres/
│
├── data_raw/           # Datos originales de EM-DAT y Kaggle
├── sql/                # Consultas SQL utilizadas
├── notebooks/          # Procesamiento, API geolocation, limpieza
└── README.md           # Este documento
```

---

## 🧭 Flujo de trabajo del proyecto

### **1. Obtención de los datasets**
- Descarga del dataset principal de desastres desde EM-DAT.  
- Descarga del dataset de terremotos desde Kaggle.  
- Revisión preliminar, formatos y estructura.

### **2. Integración de ambos datasets**
Los datasets se integraron mediante:
- Normalización de columnas.
- Conversión de fechas.
- Unificación de categorías.
- Limpieza de duplicados.

Resultado: un dataset único con información global enriquecida.

### **3. Enriquecimiento geográfico mediante API**
Para cada registro (latitud / longitud):
- Se consultó una API de georreferenciación.
- Se añadieron automáticamente:
  - **País**
  - **Continente**

### **4. Carga del dataset en SQL**
Se creó la base de datos:

**`NaturalDisastersDB`**

Con una tabla principal:

**`Natural_disasters`**

### **5. Consultas SQL**
Generaron:

- Frecuencia total de desastres por región  
- Desastre más mortal por región  
- Evolución por década  
- Mortalidad relativa de terremotos según magnitud  
- Personas afectadas por región  
- Desastre más incidente por región  

Usando:
- Funciones ventana
- Agregaciones
- JOINs
- Agrupaciones avanzadas

---

## 📊 Visualizaciones generadas

- Total de desastres por región  
- Desastres más mortales por región  
- Frecuencia por década  
- Mortalidad sísmica por magnitud  
- Personas afectadas por desastre dominante  
- Desastre de mayor incidencia por región  

Estilo:
- Tema claro  
- Tipografías limpias  
- Formato profesional  

---

## 📈 Indicadores clave (KPIs)

- Total de desastres por región  
- Porcentaje de muertes por desastre dominante  
- Tendencia por décadas  
- Ratio de mortalidad sísmica  
- Personas afectadas por región  
- Porcentaje del desastre dominante  

---

## 🔍 Hallazgos principales

- Asia registra más desastres.
- Las epidemias/sequías son altamente mortales pese a baja frecuencia.
- Aumento muy marcado de desastres post-2000.
- África altamente afectada por sequías.
- Cada región tiene un desastre dominante muy claro.

---

## 📜 Conclusión

Este proyecto integra datos de dos grandes fuentes internacionales, los enriquece con geolocalización y aplica un análisis profundo mediante SQL y visualizaciones.  
Ofrece un marco robusto para estudiar la evolución e impacto de desastres naturales durante más de un siglo.

## 🚀 Cómo ejecutar este proyecto

1. **Clona el repositorio:** git clone [https://github.com/Albertovmt/Desastres_naturales.git]
   
2. **Instala dependencias:** pip install pandas sqlalchemy pymysql cryptography request os dotenv

3. **Configura tus credenciales en el archivo config.py.**

4. **Ejecuta el notebook de Jupyter para iniciar el proceso ETL.**

5. **Abre tu gestor SQL preferido y carga las queries de la carpeta /queries.**

6. **link presentación:** [https://canva.link/9wy4xh4v45zj2rz]