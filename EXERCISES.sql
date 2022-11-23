USE mavenfuzzyfactory;

SELECT * FROM website_sessions
;
SELECT
	utm_source,
    utm_campaign,
    http_referer,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-04-12'
GROUP BY 1,2,3
ORDER BY sessions DESC;

SELECT *FROM orders;
SELECT *FROM website_sessions;

SELECT 
	COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
	COUNT(DISTINCT orders.website_session_id) AS orders,
    COUNT(DISTINCT orders.website_session_id) / COUNT(DISTINCT website_sessions.website_session_id) AS CVR
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2012-04-14'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand';

SELECT *FROM website_sessions;

SELECT 
	YEAR(created_at) AS YEAR,
    WEEK(created_at) AS WEEK,
    MIN(DATE(created_at)) AS DATE,
	COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-05-10'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 
	YEAR, WEEK;

SELECT *FROM website_sessions;

SELECT
	device_type,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.website_session_id) AS orders,
	COUNT(DISTINCT orders.website_session_id) / COUNT(DISTINCT website_sessions.website_session_id) AS CVR
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2012-05-11'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 1;

--

SELECT *FROM website_sessions;
SELECT 
	YEAR(created_at) AS year,
    WEEK(created_at) AS week,
	MIN(DATE(created_at)) AS week_start_date,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_session_id ELSE NULL END) AS dtop_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) AS mobile_sessions
FROM website_sessions
WHERE created_at < '2012-06-09' AND created_at > '2012-04-15'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 1,2;
        
SELECT *FROM website_pageviews;
SELECT 
	pageview_url,
    COUNT(DISTINCT website_pageview_id) AS pageviews
FROM website_pageviews
WHERE created_at < '2012-06-09'
GROUP BY 1
ORDER BY pageviews DESC;

DROP TABLE first_pageview;
CREATE TEMPORARY TABLE first_pageview
SELECT
	website_session_id,
    MIN(website_pageview_id) AS min_pv_id
FROM website_pageviews
WHERE created_at < '2012-06-12'
GROUP BY 1
;

SELECT * FROM website_pageviews;
SELECT * FROM first_pageview;
SELECT 
	-- first_pageview.website_session_id,
	website_pageviews.pageview_url AS landing_page,
    COUNT(DISTINCT first_pageview.website_session_id) AS sessions_hitting_this_lander
FROM first_pageview 
	LEFT JOIN website_pageviews
		ON first_pageview.min_pv_id = website_pageviews.website_pageview_id
GROUP BY landing_page;
		
--
SELECT *FROM website_pageviews;

CREATE TEMPORARY TABLE first_page
SELECT 
	website_session_id,
    website_pageview_id AS pv_id
FROM website_pageviews
WHERE created_at < '2012-06-12'
GROUP BY 1;

/*
SELECT 
	website_session_id,
    MIN(website_pageview_id) AS pv_id
FROM website_pageviews
WHERE created_at < '2012-06-12'
GROUP BY 1; */
SELECT *FROM website_pageviews;
SELECT *FROM first_page;

SELECT
	-- first_page.website_session_id,
	website_pageviews.pageview_url AS entry_page,
    COUNT(DISTINCT first_page.website_session_id) AS session_hitting_page
FROM first_page 
	LEFT JOIN website_pageviews
		ON first_page.pv_id = website_pageviews.website_pageview_id
WHERE created_at < '2012-06-12'
GROUP BY entry_page;

