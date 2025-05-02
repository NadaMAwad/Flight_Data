# ✈️ Flight_Data

A data engineering project for collecting, processing, and analyzing real-time flight data using the OpenSky API. This project leverages Docker, Apache Airflow, PostgreSQL, and dbt to orchestrate ETL workflows and perform analytics.

---

## 🚀 Project Overview

This project captures live flight data from the [OpenSky Network API](https://opensky-network.org/), stores it in a PostgreSQL database, and transforms it into analytical datasets using dbt. The entire pipeline is containerized using Docker.

---

## 🧱 Tech Stack

- **Python** – for the ETL logic in Airflow  
- **Apache Airflow** – for orchestrating data workflows  
- **PostgreSQL** – as the database  
- **dbt (Data Build Tool)** – for data modeling and transformation  
- **Docker** – for containerization and environment consistency  

---

## 🗂️ Project Structure
```
Flight_Data/
├── docker-compose.yml               # Docker setup for PostgreSQL, Airflow, and dbt
├── airflow/
│   └── dags/
│       └── fetch_opensky_data.py    # Airflow DAG to fetch data from OpenSky API
├── dbt/
│   ├── models/
│   │   ├── cleaned_data.sql         # Cleaned version of raw flight data
│   │   ├── on_ground_data.sql       # Data for flights on the ground
│   │   ├── speed_data.sql           # Calculates flight speeds
│   │   └── aggregated_data.sql      # Summary and aggregated insights
│   ├── macros/                      # (Optional) Custom Jinja macros
│   ├── seeds/                       # (Optional) Seed data for dbt
│   └── dbt_project.yml              # Main dbt configuration file
├── .gitignore
```

---

## ⚙️ How It Works

1. **Airflow DAG** (`fetch_opensky_data.py`) runs every hour:
   - Sends a GET request to the OpenSky API.
   - Stores the flight states into a PostgreSQL table `flight_raw_data`.

2. **dbt Models**:
   - `cleaned_data`: Cleans and prepares raw data.
   - `on_ground_data`: Filters aircraft currently on the ground.
   - `speed_data`: Calculates aircraft speeds.
   - `aggregated_data`: Generates summary analytics.

