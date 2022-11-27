USE mavenfuzzyfactory;

-- STEP 1: find a total homepage sessions
-- STEP 2: define a bounced sessions 
-- STEP 3: calculate bounce rate

SELECT *FROM website_sessions;
SELECT *FROM website_pageviews;
--
DROP TABLE first_page;
CREATE TEMPORARY TABLE first_page
SELECT 
	website_session_id,
    MIN(website_pageview_id) AS min_pageview_id
FROM website_pageviews
WHERE created_at < '2012-06-14' 
GROUP BY 1;
--
SELECT *FROM first_page;
SELECT *FROM website_sessions;
SELECT *FROM website_pageviews;
--

CREATE TEMPORARY TABLE sessions
SELECT
	-- first_page.website_session_id,
    website_pageviews.pageview_url AS entry_page,
    COUNT(DISTINCT first_page.website_session_id) AS sessions
FROM first_page
	LEFT JOIN website_pageviews
		ON first_page.website_pageview_id = website_pageviews.website_pageview_id
WHERE created_at < '2012-06-14'
GROUP BY 1 ;

--
SELECT *FROM sessions;
SELECT *FROM first_page;

CREATE TEMPORARY TABLE sessions_with_home_landing_page
SELECT 
	first_page.website_session_id,
    website_pageviews.pageview_url AS landing_page
FROM first_page
	LEFT JOIN website_pageviews
		ON first_page.min_pageview_id = website_pageviews.website_pageview_id
WHERE website_pageviews.pageview_url = '/home';

SELECT *FROM sessions_with_home_landing_page;

CREATE TEMPORARY TABLE bounced_sessions_for_request
SELECT
	sessions_with_home_landing_page.website_session_id,
    sessions_with_home_landing_page.landing_page,
    COUNT(website_pageviews.website_pageview_id) AS count_of_pages_viewed
FROM sessions_with_home_landing_page
	LEFT JOIN website_pageviews
		ON sessions_with_home_landing_page.website_session_id = website_pageviews.website_session_id 
GROUP BY 1,2
HAVING count_of_pages_viewed = 1;

SELECT *FROM bounced_sessions_for_request;

SELECT
	sessions_with_home_landing_page.website_session_id,
    bounced_sessions_for_request.website_session_id AS bounced_website_session_id
FROM sessions_with_home_landing_page
LEFT JOIN bounced_sessions_for_request
ON sessions_with_home_landing_page.website_session_id = bounced_sessions_for_request.website_session_id
ORDER BY 1;

SELECT
	COUNT(DISTINCT sessions_with_home_landing_page.website_session_id) AS total_sessions,
    COUNT(DISTINCT bounced_sessions_for_request.website_session_id) AS bounced_sessions,
    COUNT(DISTINCT bounced_sessions_for_request.website_session_id) / COUNT(DISTINCT sessions_with_home_landing_page.website_session_id) 
	AS bounce_rate
FROM sessions_with_home_landing_page
	LEFT JOIN bounced_sessions_for_request
		ON sessions_with_home_landing_page.website_session_id = bounced_sessions_for_request.website_session_id
