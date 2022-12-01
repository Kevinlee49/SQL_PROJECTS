# identifying repeat visitors
# if customers have repeat sessions, they may be more valuable than I thought.
# In this case, I might be able to spend a bit more to acquire them.
# Pull data on how many of website visitors come back for another session?

# STEP 1: Identify the relevant new sessions
# STEP 2: User the user_id values form step 1 to find any repeat sessions those users had
# STEP 3: Analyze the data at the user level (how many sessions did each user have?)
# STEP 4: Aggregate the user-level analysis to generate your behaviour analysis

USE mavenfuzzyfactory;
SELECT *FROM website_sessions;

CREATE TEMPORARY TABLE sessions_with_repeats
SELECT
	new_sessions.user_id,
    new_sessions.website_session_id AS new_session_id,
    website_sessions.website_session_id AS repeat_session_id
FROM
(
SELECT
	user_id,
    website_session_id
FROM website_sessions
WHERE created_at < '2014-11-01'
	AND created_at >= '2014-01-01'
    AND is_repeat_session = 0
) AS new_sessions
	LEFT JOIN website_sessions
		ON new_sessions.user_id = website_sessions.user_id
        AND website_sessions.is_repeat_session = 1 -- was a repeat session (rebundant, but good to explain)
        AND website_sessions.website_session_id > new_sessions.website_session_id -- session was later than new session
        AND website_sessions.created_at < '2014-11-01'
        AND website_sessions.created_at >= '2014-01-01';
        
SELECT *FROM sessions_with_repeats;

SELECT
	user_id,
    COUNT(DISTINCT new_session_id) AS new_sessions,
    COUNT(DISTINCT repeat_session_id) AS repeat_sessions
FROM sessions_with_repeats
GROUP BY 1
ORDER BY 3 DESC;

SELECT
	repeat_sessions,
    COUNT(DISTINCT user_id) AS users
FROM
(
SELECT
	user_id,
    COUNT(DISTINCT new_session_id) AS new_sessions,
    COUNT(DISTINCT repeat_session_id) AS repeat_sessions
FROM sessions_with_repeats
GROUP BY 1
ORDER BY 3 DESC
) AS user_level

GROUP BY 1;
    