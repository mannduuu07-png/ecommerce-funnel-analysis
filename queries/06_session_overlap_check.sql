-- Session coverage and linkage validation

-- ------------------------------------------------------------
-- 1. Clickstream-to-transaction session overlap
-- ------------------------------------------------------------
-- Quantify how much the clickstream sample overlaps with
-- sessions appearing in transactions.
-- A high overlap indicates that the clickstream data is weighted
-- toward sessions that generated a transaction record.

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

-- Result:
-- Approximately 95.2% of clickstream sessions also appear
-- in the transactions data.


-- ------------------------------------------------------------
-- 2. Transaction session grain validation
-- ------------------------------------------------------------
-- Confirm that transaction rows and distinct transaction
-- sessions are aligned before validating reverse linkage.

SELECT
    COUNT(*) AS transaction_rows,
    COUNT(DISTINCT session_id) AS transaction_sessions
FROM transactions
WHERE session_id IS NOT NULL;

-- Result:
-- transaction_rows     = 852,584
-- transaction_sessions = 852,584


-- ------------------------------------------------------------
-- 3. Transaction-to-clickstream linkage validation
-- ------------------------------------------------------------
-- Identify transaction sessions that have no corresponding
-- records anywhere in the clickstream data.

WITH click_sessions AS (
    SELECT DISTINCT session_id
    FROM click_stream
    WHERE session_id IS NOT NULL
),
unmatched_transactions AS (
    SELECT
        t.session_id,
        t.customer_id
    FROM transactions AS t
    LEFT JOIN click_sessions AS c
        ON t.session_id = c.session_id
    WHERE t.session_id IS NOT NULL
      AND c.session_id IS NULL
)
SELECT
    COUNT(*) AS unmatched_transaction_sessions,
    COUNT(DISTINCT customer_id) AS unmatched_customers
FROM unmatched_transactions;

-- Result:
-- unmatched_transaction_sessions = 2
-- unmatched_customers             = 1
-- 852,582 of 852,584 transaction sessions therefore have
-- corresponding clickstream records.
