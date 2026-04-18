WITH booking_level AS (
    SELECT
        booking_id,
        customer_id,
        MIN(created_at) AS created_at,
        MAX(payment_method) AS payment_method,
        CASE 
            WHEN SUM(CASE WHEN payment_status = 'Failed' THEN 1 ELSE 0 END) > 0 
            THEN 'Failed' 
            ELSE 'Success' 
        END AS payment_status
    FROM transactions
    GROUP BY booking_id, customer_id
)
SELECT *
FROM booking_level;
