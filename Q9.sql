USE mavenfuzzyfactory;

SELECT
	pageview_url,
    COUNT(DISTINCT website_pageview_id) AS sessions
FROM website_pageviews

WHERE created_at < '2012-06-09'
GROUP BY 1 
ORDER BY sessions DESC;