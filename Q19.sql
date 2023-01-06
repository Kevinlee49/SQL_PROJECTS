# analyzing repeat behavior
# understand the minimum, maximum, and average time between the first and second session for customers who do come back?

# STEP 1: Identify the relevant new sessions
# STEP 2: User the user_id values form step 1 to find any repeat sessions those users had
# STEP 3: Find the created_at times for first and second sessions
# STEP 4: Find the differences between first and second sessions at a user level
# STEP 5: Aggregate the user level data to find the average, min, max

USE mavenfuzzyfactory;

SELECT 
	user_id,
    website_session_id,
    created_at
	FROM website_sessions
WHERE created_at < '2014-11-03'
	AND created_at >= '2014-01-01'
	AND is_repeat_session = 0;

CREATE TEMPORARY TABLE sessions_w_repeats_for_time_diff
SELECT
	new_sessions.user_id,
    new_sessions.website_session_id AS new_session_id,
    new_sessions.created_at AS new_session_created_at,
    website_sessions.website_session_id AS repeat_session_id,
    website_sessions.created_at AS repeat_session_created_at
FROM
(
SELECT 
	user_id,
    website_session_id,
    created_at
	FROM website_sessions
WHERE created_at < '2014-11-03'
	AND created_at >= '2014-01-01'
	AND is_repeat_session = 0 -- new sessions only
) AS new_sessions
	LEFT JOIN website_sessions
		ON new_sessions.user_id = website_sessions.user_id  
			AND website_sessions.is_repeat_session = 1 -- was a repeat session (rebundant, but good to explain)
			AND website_sessions.website_session_id > new_sessions.website_session_id -- session was later than new session
			AND website_sessions.created_at < '2014-11-01'
			AND website_sessions.created_at >= '2014-01-01';
   
SELECT *FROM sessions_w_repeats_for_time_diff;

# STEP 3: Find the created_at times for first and second sessions
SELECT
	user_id,
    new_session_id,
    new_session_created_at,
    MIN(repeat_session_id) AS second_session_id,
    MIN(repeat_session_created_at) AS second_session_created_at 
FROM sessions_w_repeats_for_time_diff
WHERE repeat_session_id IS NOT NULL
GROUP BY 1,2,3;

###################################
# STEP 4: Find the differences between first and second sessions at a user level
CREATE TEMPORARY TABLE users_first_to_second_session
SELECT
	user_id,
    DATEDIFF(second_session_created_at, new_session_created_at) AS days_first_to_second_session
FROM
(
SELECT
	user_id,
    new_session_id,
    new_session_created_at,
    MIN(repeat_session_id) AS second_session_id,
    MIN(repeat_session_created_at) AS second_session_created_at 
FROM sessions_w_repeats_for_time_diff
WHERE repeat_session_id IS NOT NULL
GROUP BY 1,2,3
) AS first_second;

SELECT *FROM users_first_to_second_session;

# STEP 5: Aggregate the user level data to find the average, min, max

SELECT
	AVG(days_first_to_second_session) AS avg_days_first_to_second,
    MIN(days_first_to_second_session) AS min_days_first_to_second,
    MAX(days_first_to_second_session) AS max_days_first_to_second
FROM users_first_to_second_session;