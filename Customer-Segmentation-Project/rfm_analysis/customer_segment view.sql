CREATE VIEW rfm_segments AS
WITH rfm_scores AS (
    SELECT
        customer_id,

        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary) AS m_score,

        recency,
        frequency,
        monetary

    FROM rfm_base
)

SELECT
    customer_id,
    r_score,
    f_score,
    m_score,
    monetary,  -- ✅ now included

    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN f_score >= 4 AND m_score >= 4 THEN 'Loyal Customers'
        WHEN r_score >= 3 AND f_score >= 2 THEN 'Regular Customers'
        WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost Customers'
        ELSE 'At Risk'
    END AS customer_segment

FROM rfm_scores;