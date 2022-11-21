USE mavenfuzzyfactory;

/* 
SELECT 
	pageview_url,
    COUNT(DISTINCT website_pageview_id) AS pvs
FROM website_pageviews
WHERE website_pageview_id < 1000 -- arbitrary
GROUP BY 1
ORDER BY pvs DESC;
*/

CREATE TEMPORARY TABLE first_pageview
SELECT 
	website_session_id,
    MIN(website_session_id) AS min_pv_idwebsite_session_id
FROM website_pageviews
WHERE website_pageview_id < 1000 -- arbitrary
GROUP BY 1;

SELECT 
	pageview_url,
    COUNT(DISTINCT website_pageview_id) AS pvs
FROM website_pageviews
WHERE created_at < '2012-06-09' 
GROUP BY 1
ORDER BY pvs DESC;




