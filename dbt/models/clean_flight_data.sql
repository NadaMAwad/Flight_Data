WITH cleaned_data AS (
    SELECT
        icao24,
        callsign,
        origin_country,
        time_position,
        last_contact,
        longitude,
        latitude,
        baro_altitude,
        on_ground,
        velocity
    FROM raw_flight_data
    WHERE icao24 IS NOT NULL
    AND longitude IS NOT NULL
    AND latitude IS NOT NULL
)
SELECT * FROM cleaned_data
