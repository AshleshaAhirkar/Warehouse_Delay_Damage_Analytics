# 🚚 Warehouse Delay & Damage Analytics

An end-to-end Supply Chain & Logistics Analytics project that analyzes warehouse delivery performance using *Python, AWS (S3 & RDS), SQL, and Power BI* to identify delivery delays, shipment damage, SLA breaches, and operational cost losses.

---

## 📌 Project Overview

Warehouse operations play a critical role in ensuring timely deliveries and maintaining customer satisfaction. Delays, damaged shipments, and operational inefficiencies directly impact business costs, SLA compliance, and customer experience.

This project builds an end-to-end analytics pipeline — from raw data cleaning in Python, to cloud storage and database hosting on AWS, to business analysis in SQL, to interactive Power BI dashboards — to help business stakeholders monitor warehouse performance, identify bottlenecks, and reduce operational losses.

The project is designed around business scenarios similar to Amazon, Flipkart, Blinkit, Zomato, Swiggy, Delhivery, Blue Dart, and DHL.

---

## ❗ Business Problem

Modern logistics companies face several recurring operational challenges that impact profitability and customer trust:

- Frequent shipment delays across warehouses and regions.
- Damaged products during transportation, leading to financial losses.
- SLA breaches affecting customer trust and business reliability.
- High operational costs due to inefficient processes.
- Inconsistent warehouse performance across locations.
- Poor visibility into delivery partner performance.

Business teams needed an analytics solution that provides real-time operational visibility and helps identify the root causes behind these issues, so that delays, damages, and cost leakages can be addressed proactively rather than reactively.

---

## 🎯 Business Objectives

- Monitor warehouse performance.
- Track shipment delays and root causes.
- Analyze damaged shipments and financial loss.
- Measure SLA compliance across warehouses, regions, and delivery partners.
- Identify operational bottlenecks.
- Improve logistics efficiency and reduce operational costs.
- Build interactive dashboards for business users.
- Support data-driven operational decision-making.

---

## 📂 Dataset Information

- *Dataset:* Delivery Logistics Dataset (India, Multi-Partner)
- *Dataset Link:* <https://www.kaggle.com/datasets/kundanbedmutha/delivery-logistics-dataset-india-multi-partner>

The original Kaggle dataset was enhanced with additional business columns and feature-engineered fields to build the *Warehouse Delay & Damage Analytics Dataset*, containing:

- Delivery ID
- Delivery Partner
- Package Type
- Vehicle Type
- Delivery Mode
- Region
- Weather Condition
- Distance (km) & Package Weight (kg)
- Delivery Time vs Expected Time
- Delivery Status & Delivery Rating
- Delivery Cost
- Warehouse ID / Warehouse Name / Shift
- Damage Status & Damage Cost
- Delay Reason
- SLA Status *(feature engineered using Python)*

---

## 📊 Project Scale

- 📦 Shipments Analyzed: *25,000+*
- 🏭 Warehouses Covered: *7*
- 🚚 Delivery Partners Compared: *5*
- 🌍 Regions Analyzed: *5*
- 📊 Interactive Dashboards: *3*
- 📈 KPIs Developed: *10+*
- 🗄️ SQL Business Questions Solved: *35+*

---

## 📈 Business Metrics

| Metric                    | Value      |
| ------------------------- | ---------- |
| 📦 Total Shipments Received | *25,000*   |
| ✅ Delivery Success %       | *63.51%*   |
| 📋 SLA Compliance %         | *61.02%*   |
| ⏱️ Delay %                  | *22.73%*   |
| 💥 Damage %                 | *24.00%*   |
| 💸 Total Damage Cost        | *₹1.57M*   |
| 💰 Average Delivery Cost    | *₹491.77*  |
| ⏳ Average Delivery Time    | *8.07 hrs* |
| ⚠️ Average Delay Time       | *2.59 hrs* |
| 🏆 Operational Health Score | *68/100*   |

---

## 🛠️ Tools & Technologies

- Python (Pandas)
- MySQL (SQL)
- AWS S3
- AWS RDS
- Power BI
- DAX
- Power Query
- Star Schema Data Modeling
- GitHub

---

## 🔄 Project Workflow

- 📂 Raw Dataset (Kaggle)
↓
- 🧹 Python Data Cleaning & Feature Engineering
↓
- ☁️ AWS S3 Upload (Raw & Processed Data)
↓
- 🗄️ AWS RDS (MySQL Database)
↓
- 🔍 SQL Business Analysis
↓
- 📊 Power BI Data Modeling & DAX Measures
↓
- 📈 Dashboard Development
↓
- 💡 Business Insights
↓
- ✅ Business Recommendations

---

## 🏗️ Data Modeling — Star Schema

- *Fact Table:* Fact_Delivery
- *Dimension Tables:* Dim_Warehouse, Dim_Region, Dim_Vehicle, Dim_Package, Dim_DeliveryPartner, Dim_Date
- *Relationships:* One-to-Many

---

# 📈 Dashboard Preview

## Dashboard 1 – Executive Overview

![Executive Overview Dashboard](readme_assets/1.Executive_Overview.png)

### Dashboard Highlights

- Operational Health Score
- Delivery Success % & SLA Compliance %
- Delay % & Damage %
- Total Shipments Received, Delivered, Delayed, Failed
- Warehouses by Delivery Success %
- Failed Deliveries by Region

---

## Dashboard 2 – Operational Insights

![Operational Insights Dashboard](readme_assets/2.Operational_Insights.png)

### Dashboard Highlights

- Average Delivery Time & Average Delay Time
- Slowest Delivery Mode & Highest Delay Region
- Root Cause Analysis (Pareto — Delay Reasons)
- Weather Impact on Delayed Shipments
- Average Delivery Time by Delivery Mode
- Delay Severity Distribution

---

## Dashboard 3 – Cost & Performance

![Cost & Performance Dashboard](readme_assets/3.Cost_Performance.png)

### Dashboard Highlights

- Total Damage Cost & Damage Cost %
- Average Delivery Cost
- Highest Damage Warehouse & Highest Damage Package
- Warehouse Scorecard (Success %, SLA %, Rating, Cost)
- Top 5 Delivery Partners by Delivery Success
- Damage Cost by Warehouse
- Total Shipments by Delivery Status

---

# 📊 Key KPIs

| KPI                   | Description                                       |
| --------------------- | -------------------------------------------------- |
| Delivery Success %    | Percentage of shipments delivered successfully      |
| SLA Compliance %      | Percentage of deliveries completed within promised time |
| Delay %               | Percentage of shipments delivered late              |
| Damage %              | Percentage of shipments damaged in transit          |
| Total Damage Cost     | Financial loss caused by damaged shipments          |
| Average Delivery Cost | Average cost incurred per delivery                  |
| Average Delivery Time | Average time taken to complete a delivery           |

---

# 🔍 SQL Analysis

SQL was used to answer 35+ business questions across the following areas:

- Delay Analysis (warehouse, region & partner-wise delays, delay %)
- Damage Analysis (damage %, cost, high-risk warehouses, shift-wise damage)
- SLA Analysis (compliance %, breach %, warehouse/partner/region performance)
- Operational Analysis (weather impact, vehicle & delivery mode performance, shift performance)
- Cost Analysis (cost by region, vehicle, distance, package weight, delivery mode)
- Warehouse Performance Analysis
- Delivery Partner Analysis
- Customer Experience Analysis (ratings)
- Failure & Root Cause Analysis

---

# 💡 Key Business Insights

- Chennai Warehouse recorded the highest delay percentage at *24.95%*, followed by Mumbai at *24.44%*.
- The *North region* had the highest delayed deliveries (*1,391*) and the lowest SLA compliance (*50.05%*).
- Overall shipment damage rate stood at *24%*, costing the business *₹1.57M* in damage losses.
- *Delhi Warehouse* recorded the highest damage rate at *37.10%* and the highest damage cost among all warehouses.
- The *Night shift* recorded significantly more damaged shipments (*2,978*) than Morning or Evening shifts.
- Overall SLA compliance was *61.02%*, meaning nearly *39%* of shipments breached committed delivery timelines.
- *Blue Dart* consistently outperformed other delivery partners in SLA compliance and delivery success, while *Ecom Express* lagged behind.
- Weather conditions such as *Rainy, Stormy, and Foggy* were among the leading contributors to delayed shipments.

---

# ✅ Business Recommendations

- Conduct a detailed operational review of Chennai and Delhi Warehouses for bottlenecks and packaging issues.
- Strengthen supervision and quality checks during Night shift operations to reduce damage rates.
- Implement additional operational planning for the North region, especially during adverse weather conditions.
- Introduce partner-level SLA and delay KPIs to monitor and improve delivery partner performance (especially Ecom Express).
- Set up delay alerts for shipments exceeding expected delivery time to enable faster intervention.
- Strengthen preventive packaging standards for high-risk and fragile package types.

---

# 🚀 Business Impact

This project enables businesses to:

- Identify *₹1.57M* worth of damage losses through root-cause analysis.
- Detect high-risk warehouses and shifts contributing to delays and damages.
- Monitor SLA compliance of *61.02%* across warehouses, regions, and delivery partners.
- Benchmark delivery partner performance to guide contract and operational decisions.
- Centralize business KPIs into *three interactive Power BI dashboards* for faster, data-driven decisions.

---

# 🌐 Live Dashboard

🔗 *Power BI Dashboard*

<ADD_YOUR_LIVE_DASHBOARD_LINK_HERE>

---

## ☁️ Cloud & Data Engineering

- *AWS S3* was used for cloud storage of raw and processed datasets.
- *AWS RDS (MySQL)* was used to host the cleaned warehouse analytics data for SQL-based analysis.
- *Python (Pandas)* handled data cleaning, missing value treatment, duplicate removal, and feature engineering (including the `sla_status` field derived from delivery time vs expected time).

---

## 📄 Project Documentation

For a detailed explanation of the project, including the business problem, data cleaning process, AWS setup, SQL analysis, dashboard development, business insights, and recommendations, please refer to the *Project_Documentation* available in this repository.

---

# 👩‍💻 Author

*Ashlesha Ahirkar*
