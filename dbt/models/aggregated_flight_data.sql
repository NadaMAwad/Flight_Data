WITH aggregated_data AS (
    SELECT
        icao24,
        COUNT(*) AS flight_count,
        AVG(velocity) AS avg_velocity,
        MAX(velocity) AS max_velocity,
        MIN(velocity) AS min_velocity,
        AVG(baro_altitude) AS avg_altitude
    FROM raw_flight_data
    WHERE velocity IS NOT NULL AND baro_altitude IS NOT NULL
    GROUP BY icao24
)
SELECT * FROM aggregated_data
