DROP DATABASE IF EXISTS ecommerce_analysis;
CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

SELECT COUNT(*) FROM amazon_sales;
SELECT 
    COUNT(Order_ID) AS Total_Orders,
    SUM(Amount) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_sales
WHERE Status != 'Cancelled';

SELECT Category, COUNT(Order_ID) AS Total_Orders,
    SUM(Amount) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_sales
WHERE Status != 'Cancelled'
GROUP BY Category
ORDER BY Total_Revenue DESC;

SELECT State, COUNT(Order_ID) AS Total_Orders,
    SUM(Amount) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_sales
WHERE Status != 'Cancelled'
GROUP BY State
ORDER BY Total_Revenue DESC
LIMIT 10;


SELECT 
    MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS Month_Num,
    MONTHNAME(STR_TO_DATE(Date, '%d-%m-%Y')) AS Month_Name,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Amount) AS Total_Revenue
FROM amazon_sales
WHERE Status != 'Cancelled'
GROUP BY Month_Num, Month_Name
ORDER BY Month_Num;

SELECT CASE 
WHEN Status IN ('Shipped','Shipped - Delivered to Buyer',
	'Shipped - Picked Up') THEN 'Successful'
WHEN Status IN ('Cancelled','Shipped - Returned to Seller',
                        'Shipped - Rejected by Buyer','Shipped - Damaged',
                        'Shipped - Lost in Transit') THEN 'Problematic'
        ELSE 'In Progress'
    END AS Order_Category,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(COUNT(Order_ID) * 100.0 / (SELECT COUNT(*) FROM amazon_sales), 2) AS Percentage
FROM amazon_sales GROUP BY Order_Category ORDER BY Total_Orders DESC;

SELECT 
    City,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Amount) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value
FROM amazon_sales
WHERE Status != 'Cancelled'
GROUP BY City
ORDER BY Total_Revenue DESC
LIMIT 10;

SELECT 
    B2B,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Amount) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value,
    ROUND(COUNT(Order_ID) * 100.0 / (SELECT COUNT(*) FROM amazon_sales), 2) AS Percentage
FROM amazon_sales
WHERE Status != 'Cancelled'
GROUP BY B2B;

SELECT 
    Fulfilment,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Amount) AS Total_Revenue,
    ROUND(AVG(Amount), 2) AS Avg_Order_Value,
    ROUND(COUNT(Order_ID) * 100.0 / (SELECT COUNT(*) FROM amazon_sales), 2) AS Percentage
FROM amazon_sales
WHERE Status != 'Cancelled'
GROUP BY Fulfilment
ORDER BY Total_Revenue DESC;