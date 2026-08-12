-- Measure progression through three major purchase milestones.
-- MIN(event_time) captures the first occurrence of each event within a session.
WITH funnel_events AS (
    SELECT
        session_id,
        MIN(CASE WHEN event_name = 'HOMEPAGE' THEN event_time END) AS homepage_time,
        MIN(CASE WHEN event_name = 'ADD_TO_CART' THEN event_time END) AS cart_time,
        MIN(CASE WHEN event_name = 'BOOKING' THEN event_time END) AS booking_time
    FROM click_stream
    GROUP BY session_id
),
ordered_funnel AS (
    SELECT
        session_id,
        CASE
            WHEN homepage_time IS NOT NULL THEN 1 ELSE 0
        END AS reached_homepage,
        CASE
            WHEN homepage_time IS NOT NULL
                AND cart_time IS NOT NULL
                AND cart_time >= homepage_time
            THEN 1 ELSE 0
        END AS reached_cart,
        CASE
            WHEN homepage_time IS NOT NULL
                AND cart_time IS NOT NULL
                AND booking_time IS NOT NULL
                AND cart_time >= homepage_time
                AND booking_time >= cart_time
            THEN 1 ELSE 0
        END AS reached_booking
    FROM funnel_events
)
SELECT
    SUM(reached_homepage) AS homepage_sessions,
    SUM(reached_cart) AS cart_sessions,
    SUM(reached_booking) AS booking_sessions,
    ROUND(
        SUM(reached_cart) * 1.0
        / NULLIF(SUM(reached_homepage), 0),
        4
    ) AS homepage_to_cart_rate,
    ROUND(
        SUM(reached_booking) * 1.0
        / NULLIF(SUM(reached_cart), 0),
        4
    ) AS cart_to_booking_rate
FROM ordered_funnel;
