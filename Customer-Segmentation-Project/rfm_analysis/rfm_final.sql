CREATE OR REPLACE VIEW rfm_final AS
WITH ranked_customers AS (
    SELECT
        *,
        NTILE(10) OVER (ORDER BY monetary DESC) AS decile
    FROM rfm_segments
)

SELECT *
FROM ranked_customers;

--Recreating rfm_final to include 'frequency' for analysis
DROP VIEW IF EXISTS rfm_final;

CREATE VIEW rfm_final AS
SELECT
    s.customer_id,

    -- Raw metrics
    b.recency,
    b.frequency,
    b.monetary,

    -- Scores
    s.r_score,
    s.f_score,
    s.m_score,
    s.customer_segment

FROM rfm_segments s
JOIN rfm_base b
    ON s.customer_id = b.customer_id;
SELECT *
FROM rfm_segments
LIMIT 10;

