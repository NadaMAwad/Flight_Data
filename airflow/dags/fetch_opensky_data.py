from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
import requests
import psycopg2

default_args = {
    'owner': 'airflow',
    'retries': 2,
    'retry_delay': timedelta(minutes=5),
}

def fetch_and_store_data():
    response = requests.get("https://opensky-network.org/api/states/all")
    data = response.json()
    states = data.get("states", [])

    conn = psycopg2.connect(
        host="postgres",
        database="flights",
        user="airflow",
        password="airflow"
    )
    cur = conn.cursor()

    cur.execute("""
        CREATE TABLE IF NOT EXISTS flight_raw_data (
            icao24 TEXT,
            callsign TEXT,
            origin_country TEXT,
            time_position BIGINT,
            last_contact BIGINT,
            longitude FLOAT,
            latitude FLOAT,
            baro_altitude FLOAT,
            on_ground BOOLEAN,
            velocity FLOAT
        );
    """)

    for s in states:
        cur.execute("""
            INSERT INTO flight_raw_data (
                icao24, callsign, origin_country,
                time_position, last_contact,
                longitude, latitude, baro_altitude,
                on_ground, velocity
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, s[:10])

    conn.commit()
    cur.close()
    conn.close()

with DAG(
    dag_id='fetch_opensky_data',
    description='Fetch live flight data from OpenSky API and store it in PostgreSQL',
    start_date=datetime(2025, 5, 1),
    schedule_interval='@hourly',  # run every hour
    catchup=False,
    default_args=default_args,
    tags=["opensky"],
) as dag:
    
    fetch_task = PythonOperator(
        task_id='fetch_and_store',
        python_callable=fetch_and_store_data
    )
