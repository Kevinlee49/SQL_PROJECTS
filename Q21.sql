# NEW vs REPEAT performance
# compare conversion rates and revenue per session for repeat sessions vs new sessions

USE mavenfuzzyfactory;
SELECT 
	is_repeat_session,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    SUM(price_usd) AS total_revenue,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate,
    SUM(price_usd) / COUNT(DISTINCT website_sessions.website_session_id) AS rev_per_session
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2014-11-08'
	AND website_sessions.created_at >= '2014-01-01'
GROUP BY 1;