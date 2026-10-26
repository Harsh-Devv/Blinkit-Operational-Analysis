SELECT *
FROM 'blinkit_cleaned.csv'
LIMIT 1;

-- Query 1: Top 5 higest number of Delayed Delivery areas.
SELECT
    area,
    COUNT(*) as total_delayed,
    ROUND(AVG(actual_delivery_in_mins - promised_delivery_in_mins), 2) AS avg_delay_mins,
FROM 'blinkit_cleaned.csv'
WHERE is_delayed = 1
GROUP BY area
ORDER BY total_delayed DESC
LIMIT 5;

-- Query 2: Average rating by customers based of Feedback Category
SELECT
    feedback_category,
    COUNT(feedback_category) AS total_feedbacks,
    ROUND(AVG(rating), 2) AS average_rating
FROM    
    "blinkit_cleaned.csv"
GROUP BY
    feedback_category
ORDER BY
    average_rating;

-- Query 3: Are the delayed or on time deliveries influenced by customer segment
SELECT  
    customer_segment,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END) AS total_on_time,
    SUM(CASE WHEN delivery_status <> 'On Time' THEN 1 ELSE 0 END) AS total_delayed,
    ROUND(AVG(actual_delivery_in_mins - promised_delivery_in_mins), 2) AS avg_delay_mins,
    ROUND(100.0 * SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END) / COUNT(*), 2) AS on_time_percentage
FROM 
    "blinkit_cleaned.csv"
GROUP BY
    customer_segment
ORDER BY
    on_time_percentage ASC;

-- Query 4: Are premium users placing more orders and expensive orders?
SELECT
    customer_segment,
    COUNT( DISTINCT customer_id) AS unique_customers,
    COUNT(order_id) AS Total_orders,
    SUM(order_total) AS Total_of_orders,
    ROUND(100.0 * COUNT(order_id) / SUM(COUNT(order_id)) OVER(), 2) AS percentage_of_total_orders,
    ROUND(AVG(order_total), 2) AS avg_order_total
FROM
    "./blinkit_cleaned.csv"
GROUP BY
    customer_segment
ORDER BY 
    Total_of_orders DESC;


-- SELECT
--     delivery_status,
--     is_delayed,
--     reasons_if_delayed
-- FROM
--     "blinkit_cleaned.csv"
-- LIMIT 20

-- SELECT
--     area,
--     COUNT(order_id) AS total_orders
-- FROM
--     "blinkit_cleaned.csv"
-- GROUP BY    
--     area
-- ORDER BY
--     total_orders DESC
-- LIMIT 10

-- SELECT 
--     rating,
--     feedback_category,