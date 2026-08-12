-- Normalize transaction-line records to one row per booking.
-- This prevents multi-item bookings from being counted more than once.
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
    booking_id,
    customer_id,
    created_at,
    payment_status
FROM booking_level;
