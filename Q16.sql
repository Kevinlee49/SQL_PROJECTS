USE mavenfuzzyfactory;

-- STEP 1: select all pageviews for relevant sessions
-- STEP 2: figure out which pageview urls to look for
-- STEP 3: pull all pageviews and identify the funnel steps
-- STEP 4: create the session-level conversion funnel view
-- STEP 5: aggregate the data to assess funnel performance 
CREATE TEMPORARY TABLE sessions_seeing_product_pages
SELECT
	website_session_id,
    website_pageview_id,
    pageview_url AS product_page_seen
FROM website_pageviews
WHERE created_at < '2013-04-10'
	AND created_at > '2013-01-06'
	AND pageview_url IN ('/the-original-mr-fuzzy', '/the-forever-love-bear');

SELECT *FROM sessions_seeing_product_pages;

-- finding the right pageview_urls to build the funnels

SELECT DISTINCT
	website_pageviews.pageview_url
FROM sessions_seeing_product_pages
	LEFT JOIN website_pageviews
		ON sessions_seeing_product_pages.website_session_id = website_pageviews.website_session_id
        AND sessions_seeing_product_pages.website_pageview_id < website_pageviews.website_pageview_id
;

