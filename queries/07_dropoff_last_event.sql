SELECT 
  last_event,
  session_cnt,
  ROUND(session_cnt * 1.0 / SUM(session_cnt) OVER (), 4) AS pct
FROM (
  SELECT 
    last_event,
    COUNT(*) AS session_cnt
  FROM (
    SELECT 
      session_id,
      event_name AS last_event,
      MAX(event_time) OVER (PARTITION BY session_id) AS max_time,
      event_time
    FROM click_stream
    WHERE session_id NOT IN (SELECT DISTINCT session_id FROM transactions)
  )
  WHERE event_time = max_time
  GROUP BY last_event
)
ORDER BY session_cnt DESC;
