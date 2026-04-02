CREATE VIEW customer_metrics AS
SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(quantity * price) AS total_revenue,
    MAX(invoice_date) AS last_purchase_date,
    MIN(invoice_date) AS first_purchase_date
FROM retail_clean
GROUP BY customer_id;