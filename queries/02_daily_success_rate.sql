-- Calculate payment success rate at booking level rather than row level.
WITH booking_level AS (
    SELECT
        booking_id,
        customer_id,
        MIN(created_at) AS created_at,
        CASE
            WHEN SUM(CASE WHEN payment_status = 'Failed' THEN 1 ELSE 0 END) > 0
            THEN 'Failed'
            ELSE 'Success'
        END AS payment_status
    FROM transactions
    GROUP BY booking_id, customer_id
)
SELECT
    DATE(created_at) AS dt,
    COUNT(*) AS total_bookings,
    ROUND(
        SUM(CASE WHEN payment_status = 'Success' THEN 1 ELSE 0 END) * 1.0
        / NULLIF(COUNT(*), 0),
        4
    ) AS success_rate
FROM booking_level
GROUP BY DATE(created_at)
ORDER BY dt;
