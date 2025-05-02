WITH on_ground_data AS (
    SELECT
        icao24,
        callsign,
        origin_country,
        time_position,
        last_contact,
        longitude,
        latitude,
        baro_altitude,
        on_ground
    FROM raw_flight_data
    WHERE on_ground = TRUE
)
SELECT * FROM on_ground_data