-- Quantify how much the clickstream sample overlaps with sessions in transactions.
-- A high overlap indicates that the clickstream data is weighted toward
-- sessions that generated a transaction record.
WITH click_sessions AS (
    SELECT DISTINCT session_id
    FROM click_stream
    WHERE session_id IS NOT NULL
),
transaction_sessions AS (
    SELECT DISTINCT session_id
    FROM transactions
    WHERE session_id IS NOT NULL
)
SELECT
    (SELECT COUNT(*) FROM click_sessions) AS clickstream_sessions,
    (SELECT COUNT(*) FROM transaction_sessions) AS transaction_sessions,
    COUNT(t.session_id) AS overlapping_sessions,
    ROUND(
        COUNT(t.session_id) * 1.0
        / NULLIF((SELECT COUNT(*) FROM click_sessions), 0),
        4
    ) AS clickstream_overlap_rate
FROM click_sessions AS c
LEFT JOIN transaction_sessions AS t
    ON c.session_id = t.session_id;
