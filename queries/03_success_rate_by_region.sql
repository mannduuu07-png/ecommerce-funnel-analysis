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
    c.home_location,
    COUNT(*) AS total_bookings,
    ROUND(
        SUM(CASE WHEN b.payment_status = 'Success' THEN 1 ELSE 0 END) * 1.0
        / COUNT(*),
        4
    ) AS success_rate
FROM booking_level b
JOIN customer c
    ON b.customer_id = c.customer_id
GROUP BY c.home_location
ORDER BY total_bookings DESC;
