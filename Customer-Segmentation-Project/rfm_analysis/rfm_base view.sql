CREATE OR REPLACE VIEW rfm_base AS
WITH customer_rfm AS (
    SELECT
        customer_id,
        MAX(invoice_date) AS last_purchase,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(revenue) AS monetary
    FROM retail_clean
    GROUP BY customer_id
)

SELECT
    customer_id,

    DATE '2011-12-04' - last_purchase::date AS recency,

    frequency,

    monetary

FROM customer_rfm;


--validation
SELECT *
FROM rfm_base
ORDER BY monetary DESC
LIMIT 15;

SELECT
MIN(recency),
MAX(recency)
FROM rfm_base;

SELECT
MIN(frequency),
MAX(frequency)
FROM rfm_base;

SELECT
MIN(monetary),
MAX(monetary)
FROM rfm_base;