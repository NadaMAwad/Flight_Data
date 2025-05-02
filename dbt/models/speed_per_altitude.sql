WITH speed_data AS (
    SELECT
        icao24,
        time_position,
        baro_altitude,
        velocity
    FROM raw_flight_data
    WHERE baro_altitude IS NOT NULL AND velocity IS NOT NULL
)
SELECT
    icao24,
    time_position,
    baro_altitude,
    velocity,
    CASE
        WHEN baro_altitude > 0 THEN velocity / baro_altitude
        ELSE NULL
    END AS speed_per_altitude
FROM speed_data