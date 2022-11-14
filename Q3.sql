USE mavenfuzzyfactory;

/* SELECT 
	website_session_id,
    created_at,
    MONTH(created_at),
    WEEK(created_at),
    YEAR(created_at)
    
FROM website_sessions
WHERE website_session_id BETWEEN 10000 AND 115000 -- arbitrary
*/ 

SELECT 
	YEAR(created_at),
    WEEK(created_at),
    MIN(DATE(created_at)) AS week_start,
    COUNT(DISTINCT website_session_id) AS sessions
    
FROM website_sessions
WHERE website_session_id BETWEEN 10000 AND 115000 
GROUP BY 1,2