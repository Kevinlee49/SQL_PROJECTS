USE mavenfuzzyfactory;

SELECT 
	CASE 
		WHEN http_referer IS NULL THEN 'direct_type_in'
		WHEN http_referer = 'https://www.gsearch.com' AND utm_source IS NULL THEN 'gsearch_organic'
		WHEN http_referer = 'https://www.bsearch.com' AND utm_source IS NULL THEN 'bsearch_organic'
		ELSE 'other'
	END,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions

WHERE website_session_id BETWEEN 100000 AND 115000
	-- AND utm_source IS NULL
GROUP BY 1
ORDER BY 2 DESC;
SELECT *FROM orders;
SELECT
	YEAR(website_sessions.created_at) AS yr,
    MONTH(website_sessions.created_at) AS mo,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate,
    SUM(orders.price_usd) / COUNT(DISTINCT website_sessions.website_session_id) AS revenue_per_session,
    COUNT(DISTINCT CASE WHEN primary_product_id = 1 THEN order_id ELSE NULL END) AS product_one_orders,
    COUNT(DISTINCT CASE WHEN primary_product_id = 2 THEN order_id ELSE NULL END) AS product_two_orders,
    COUNT(DISTINCT CASE WHEN primary_product_id = 3 THEN order_id ELSE NULL END) AS product_three_orders,
    COUNT(DISTINCT CASE WHEN primary_product_id = 4 THEN order_id ELSE NULL END) AS product_four_orders
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2013-04-30'
	AND website_sessions.created_at > '2012-04-01'
GROUP BY 1,2;
