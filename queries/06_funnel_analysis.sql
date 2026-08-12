WITH funnel AS (
  SELECT
    session_id,
    MIN(CASE WHEN event_name = 'HOMEPAGE' THEN event_time END) AS t1,
    MIN(CASE WHEN event_name = 'ADD_TO_CART' THEN event_time END) AS t2,
    MIN(CASE WHEN event_name = 'BOOKING' THEN event_time END) AS t3
  FROM click_stream
  GROUP BY session_id
),
ordered_funnel AS (
  SELECT
    session_id,
    CASE WHEN t1 IS NOT NULL THEN 1 ELSE 0 END AS step1_homepage,
    CASE WHEN t1 IS NOT NULL AND t2 IS NOT NULL AND t2 >= t1 THEN 1 ELSE 0 END AS step2_add_to_cart,
    CASE WHEN t1 IS NOT NULL AND t2 IS NOT NULL AND t3 IS NOT NULL
              AND t2 >= t1 AND t3 >= t2 THEN 1 ELSE 0 END AS step3_booking
  FROM funnel
)
SELECT
  SUM(step1_homepage) AS homepage,
  SUM(step2_add_to_cart) AS add_to_cart,
  SUM(step3_booking) AS booking,
  ROUND(SUM(step2_add_to_cart) * 1.0 / NULLIF(SUM(step1_homepage), 0), 4) AS rate_1_to_2,
  ROUND(SUM(step3_booking) * 1.0 / NULLIF(SUM(step2_add_to_cart), 0), 4) AS rate_2_to_3
FROM ordered_funnel;
