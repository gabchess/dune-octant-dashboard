-- Octant v2 - Days Streaming (Counter)
-- Days since StreamVote launch on Dec 12, 2025

SELECT DATE_DIFF('day', TIMESTAMP '2025-12-12', CURRENT_TIMESTAMP) as days_streaming
