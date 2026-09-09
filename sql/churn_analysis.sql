-- Customer Churn & Retention Analytics
-- PostgreSQL / MySQL 8+ with minor date-function adjustments

SELECT COUNT(*) AS customers,
 SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
 ROUND(100.0*SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate_pct,
 ROUND(AVG(monthly_charges),2) AS avg_monthly_charges
FROM customer_churn;

SELECT contract_type, COUNT(*) customers,
 ROUND(100.0*SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) churn_rate_pct
FROM customer_churn GROUP BY contract_type ORDER BY churn_rate_pct DESC;

SELECT plan, COUNT(*) customers,
 ROUND(100.0*SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) churn_rate_pct,
 ROUND(AVG(monthly_charges),2) avg_monthly_charges
FROM customer_churn GROUP BY plan ORDER BY churn_rate_pct DESC;

SELECT region, COUNT(*) customers,
 ROUND(100.0*SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) churn_rate_pct
FROM customer_churn GROUP BY region ORDER BY churn_rate_pct DESC;

SELECT satisfaction_score, COUNT(*) customers,
 ROUND(100.0*SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) churn_rate_pct
FROM customer_churn GROUP BY satisfaction_score ORDER BY satisfaction_score;

SELECT CASE WHEN support_tickets>=4 THEN '4+ tickets' ELSE '0-3 tickets' END ticket_group,
 COUNT(*) customers,
 ROUND(100.0*SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) churn_rate_pct
FROM customer_churn GROUP BY 1;

SELECT auto_pay, COUNT(*) customers,
 ROUND(100.0*SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) churn_rate_pct
FROM customer_churn GROUP BY auto_pay;

SELECT customer_id, plan, contract_type, monthly_charges, total_charges,
 support_tickets, satisfaction_score
FROM customer_churn WHERE churn='Yes'
ORDER BY monthly_charges DESC LIMIT 20;

SELECT CASE WHEN tenure_months<6 THEN '0-5 months'
 WHEN tenure_months<13 THEN '6-12 months'
 WHEN tenure_months<25 THEN '13-24 months'
 ELSE '25+ months' END tenure_band,
 COUNT(*) customers,
 ROUND(100.0*SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) churn_rate_pct
FROM customer_churn GROUP BY 1;

SELECT ROUND(SUM(monthly_charges),2) AS monthly_revenue_at_risk,
 ROUND(SUM(monthly_charges)*12,2) AS annualized_revenue_at_risk
FROM customer_churn WHERE churn='Yes';
