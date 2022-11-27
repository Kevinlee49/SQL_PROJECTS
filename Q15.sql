USE mavenfuzzyfactory;
/* Product Pathing Analysis
STEP 1: find the relevant /products pageviews with website_session_id
STEP 2: find the next pageview id that occurs AFTER the product pageview
STEP 3: find the pageview_url associated with any applicable next pageview id
STEP 4: summarize the data and analyze the pre vs post periods
*/

-- STEP 1: find the relevant /products pageviews with website_session_id
CREATE TEMPORARY TABLE products_pageviews
SELECT
	website_session_id,
    website_pageview_id,
    created_at,
    CASE 
		WHEN created_at < '2013-01-06' THEN 'A. Pre_Product_2'
        WHEN created_at >= '2013-01-06' THEN 'B. Post_Product_2'
        ELSE 'hmm.. check logic'
	END AS time_period
FROM website_pageviews
WHERE created_at < '2013-04-06'
AND created_at > '2012-10-06'
AND pageview_url = '/products';

SELECT *FROM products_pageviews;

-- STEP 2: find the next pageview id that occurs AFTER the product pageview
DROP TABLE sessions_with_next_pageview_id;
CREATE TEMPORARY TABLE sessions_with_next_pageview_id 
SELECT
	products_pageviews.time_period,
    products_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS min_next_pageview_id
FROM products_pageviews
	LEFT JOIN website_pageviews
		ON products_pageviews.website_session_id = website_pageviews.website_session_id 
        AND website_pageviews.website_pageview_id > products_pageviews.website_pageview_id # only join after the product pageview
GROUP BY 1,2;

SELECT *FROM sessions_with_next_pageview_id;

-- STEP 3: find the pageview_url associated with any applicable next pageview id
DROP TABLE sessions_with_next_pageview_url;
CREATE TEMPORARY TABLE sessions_with_next_pageview_url
SELECT
	sessions_with_next_pageview_id.time_period,
    sessions_with_next_pageview_id.website_session_id,
    website_pageviews.pageview_url AS next_pageview_url
FROM sessions_with_next_pageview_id
LEFT JOIN website_pageviews
ON sessions_with_next_pageview_id.min_next_pageview_id = website_pageviews.website_pageview_id;

SELECT *FROM sessions_with_next_pageview_url;
-- STEP 4: summarize the data and analyze the pre vs post periods
-- 
SELECT
	time_period,
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN next_pageview_url IS NOT NULL THEN website_session_id ELSE NULL END) AS w_next_pg,
    COUNT(DISTINCT CASE WHEN next_pageview_url IS NOT NULL THEN website_session_id ELSE NULL END) / COUNT(DISTINCT website_session_id) AS pct_w_next_pg,
	COUNT(DISTINCT CASE WHEN next_pageview_url = '/the-original-mr-fuzzy' THEN website_session_id ELSE NULL END) AS to_mrfuzzy,
    COUNT(DISTINCT CASE WHEN next_pageview_url = '/the-original-mr-fuzzy' THEN website_session_id ELSE NULL END) /
     COUNT(DISTINCT website_session_id) AS pct_to_mrfuzzy,
	COUNT(DISTINCT CASE WHEN next_pageview_url = '/the-forever-love-bear' THEN website_session_id ELSE NULL END) AS to_lovebear, 
    COUNT(DISTINCT CASE WHEN next_pageview_url = '/the-forever-love-bear' THEN website_session_id ELSE NULL END) /
     COUNT(DISTINCT website_session_id) AS pct_to_lovebear
FROM sessions_with_next_pageview_url
GROUP BY time_period;


