USE mavenfuzzyfactory;

-- STEP 0: find out when the new page /lander launched
-- STEP 1: finding the first website_pageview_id for relevant sessions
-- STEP 2: identifying the landing page of each sessions
-- STEP 3: counting pageviews for each session, to identify "bounces"
-- STEP 4: summarzing total sessions and bounced sessions, by LP


CREATE TEMPORARY TABLE first_pageviews
SELECT
	website_session_id,
    MIN(website_pageview_id) AS min_pageview_id
FROM website_pageviews
WHERE created_at < '2012-07-28'
	AND utm_source = 'gsearch'
	AND utm_campaign = 'nonbrand'

GROUP BY
	1;