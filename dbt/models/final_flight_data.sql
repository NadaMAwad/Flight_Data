WITH cleaned AS (
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
),
aggregated AS (
    SELECT
        icao24,
        COUNT(*) AS flight_count,
        AVG(velocity) AS avg_velocity,
        MAX(velocity) AS max_velocity,
        MIN(velocity) AS min_velocity,
        AVG(baro_altitude) AS avg_altitude
    FROM cleaned
    GROUP BY icao24
)
SELECT
    c.*,
    a.flight_count,
    a.avg_velocity,
    a.max_velocity,
    a.min_velocity,
    a.avg_altitude
FROM cleaned c
JOIN aggregated a
    ON c.icao24 = a.icao24
