-- Track customers with at least one successful booking by day.
-- This is not platform-wide DAU because it excludes visitors with no successful booking.
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
    COUNT(DISTINCT customer_id) AS daily_purchasing_customers
FROM booking_level
WHERE payment_status = 'Success'
GROUP BY DATE(created_at)
ORDER BY dt;
