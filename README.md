
# dna_dbt

# 🎯 GA4 Attribution Project

## 📌 Overview
This project implements **First-Click** and **Last-Click Attribution** modeling on **Google Analytics 4 (GA4) event data** using **BigQuery** and **dbt**.  
The results are visualized in **Looker Studio** to provide marketing and product teams with insights into user journeys and conversion touchpoints.  

---

## 🏗️ Architecture
1. **Data Source**  
   - GA4 event export dataset (`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` or your GA4 export).  

2. **Transformation Layer (dbt)**  
   - Source freshness & quality checks (not_null, unique, custom tests).  
   - Staging models for GA4 events.  
   - Intermediate models for user journey and ranking.  
   - Mart Attribution models for First-Click and Last-Click conversions.  

3. **Analytics Layer (Looker Studio)**  
   - Dashboard for attribution comparison:
     - Conversion counts(purchases) by channel.
     - Conversion counts(purchases) by Click(First and Last). 

---

## ⚙️ Setup Instructions

### 1. Clone Repository
```bash
git clone https://github.com/nareshganisetti/GA4-Attribution-Dashboard.git
cd GA4-Attribution-Dashboard
````

### 2. Configure dbt

Update your `profiles.yml` with BigQuery connection details:

```yaml
my_new_project:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: oauth
      project: <your-gcp-project>
      dataset: dbt_<your_user>
      location: US
      threads: 4
```

### 3. Install Dependencies

```bash
dbt deps
```

### 4. Run Models

```bash
dbt run
```

### 5. Run Tests

```bash
dbt test
```

---

## 📂 Project Structure

```
.
├── models/
│   ├── stg/                    # Staging model for User journeys,ranking
│   ├── mart/                   # Attribution logic (first-click, last-click)
│   ├── output/                 # Final output table (including streaming) 
│   └── sources.yml             # Sources,Tests and documentation
├── seeds/                      # Static reference data (if any)
├── tests/                      # Custom dbt tests
├── macros/                     # Helper macros for attribution logic
├── README.md                   # Project documentation
└── dbt_project.yml             # Project config
```

---

## 📊 Dashboard (Looker Studio)

* Connected to the **table in output folder**.
* Key visuals:

  * 📈 Conversion counts by attribution model.
  * 📊 Channel contribution comparison.

📊 Looker Studio Report [Dashboard Link](https://lookerstudio.google.com/embed/reporting/b59ec04d-4d87-42cb-99f5-dada4af4cbce/page/eP1XF)

This Looker Studio report provides an interactive attribution dashboard built on top of BigQuery and dbt models. The report is designed to help marketing and analytics teams understand user journeys and conversion credit allocation across different channels.

Key Features:

**Data Sources**

GA4 Public Dataset (exported to BigQuery)

Sample Streaming Data (ingested in real-time to BigQuery)

dbt-transformed models (staging, Mart and output layers)

**Dashboard Views**

Channel Performance Overview → Breakdown of conversions by channel across attribution models.

User Journey Insights → Comparison of first-click vs. last-click paths.

**Business Value**

Compare attribution models to understand marketing ROI.

Identify undervalued channels in last-click reporting by analyzing first-click contributions.

Enable data-driven budget allocation across campaigns.

---

## 🧪 Testing & Data Quality

* **Source tests** (`source.yml`):

  * not\_null, unique checks on keys like `user_pseudo_id`, `channel`.
* **Custom tests**: if required based on scenario

  * `string_not_empty` for categorical fields.
  * Incremental freshness tests.

---

## 🚀 Next Steps

* Add **multi-touch attribution** (linear, position-based).
* Automate dbt runs with **Airflow / dbt Cloud**.
* Extend dashboard with **ROI metrics** (cost vs revenue).

---

## 👨‍💻 Author

* **Naresh Ganisetti** (Data Engineer)
* Skills: BigQuery, dbt, SQL, Looker Studio, Python (for streaming)
[Linkedin](https://www.linkedin.com/in/naresh-g-20465a166)

