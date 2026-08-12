-- Identify the final recorded event for sessions with no transaction record.
-- ROW_NUMBER ensures that each session contributes exactly one last event.
WITH ranked_non_transaction_events AS (
    SELECT
        c.session_id,
        c.event_name,
        c.event_time,
        ROW_NUMBER() OVER (
            PARTITION BY c.session_id
            ORDER BY c.event_time DESC, c.event_name DESC
        ) AS event_rank
    FROM click_stream AS c
    WHERE NOT EXISTS (
        SELECT 1
        FROM transactions AS t
        WHERE t.session_id = c.session_id
    )
),
last_event_counts AS (
    SELECT
        event_name AS last_event,
        COUNT(*) AS session_count
    FROM ranked_non_transaction_events
    WHERE event_rank = 1
    GROUP BY event_name
)
SELECT
    last_event,
    session_count,
    ROUND(
        session_count * 1.0 / NULLIF(SUM(session_count) OVER (), 0),
        4
    ) AS session_share
FROM last_event_counts
ORDER BY session_count DESC;
