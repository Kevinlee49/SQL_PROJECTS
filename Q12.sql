
-- STEP 1: find out when the new page /lander launched
-- STEP 2: finding the first website_pageview_id for relevant sessions
-- STEP 3: identifying the landing page of each sessions
-- STEP 4: counting pageviews for each session, to identify "bounces"
-- STEP 5: summarizing total sessions and bounced sessions, by LP

USE mavenfuzzyfactory;

SELECT
	MIN(created_at) AS first_created_at,
    MIN(website_pageview_id) AS first_pageview_id
FROM website_pageviews
WHERE pageview_url = '/lander-1'
AND created_at IS NOT NULL;

--
SELECT *FROM website_pageviews;

CREATE TEMPORARY TABLE first_test_pageviews
SELECT 
	website_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS min_pageview_id
FROM website_pageviews	
INNER JOIN website_sessions
ON website_pageviews.website_session_id = website_sessions.website_session_id
AND website_sessions.created_at < '2012-07-28'
AND website_pageviews.website_pageview_id > 23504
AND utm_source = 'gsearch'
AND utm_campaign = 'nonbrand'
GROUP BY 1;

SELECT *FROM first_test_pageviews;
SELECT *FROM website_pageviews;

CREATE TEMPORARY TABLE nonbrand_test_sessions_with_landing_page
SELECT 
	first_test_pageviews.website_session_id,
    website_pageviews.pageview_url AS landing_page
FROM first_test_pageviews
	LEFT JOIN website_pageviews
		ON first_test_pageviews.min_pageview_id = website_pageviews.website_pageview_id
WHERE website_pageviews.pageview_url IN ('/home','/lander-1');


SELECT *FROM nonbrand_test_sessions_with_landing_page;

-- then a table to have count of pageviews per session
	-- then limit it to just bounced_sessions

CREATE TEMPORARY TABLE nonbrand_test_bounced_sessions
SELECT
	nonbrand_test_sessions_with_landing_page.website_session_id,
    nonbrand_test_sessions_with_landing_page.landing_page,
    COUNT(website_pageviews.website_pageview_id) AS count_of_pages_viewed
FROM nonbrand_test_sessions_with_landing_page
LEFT JOIN website_pageviews
ON nonbrand_test_sessions_with_landing_page.website_session_id = website_pageviews.website_session_id
GROUP BY 1,2
HAVING count_of_pages_viewed = 1;

SELECT *FROM nonbrand_test_bounced_sessions; -- QA only

SELECT 
FROM
