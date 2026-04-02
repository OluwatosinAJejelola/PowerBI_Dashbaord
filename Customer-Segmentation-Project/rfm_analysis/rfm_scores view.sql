CREATE OR REPLACE VIEW rfm_scores AS
WITH scored AS (
    SELECT
        customer_id,
        recency,
        frequency,
        monetary,

        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,

        NTILE(5) OVER (ORDER BY frequency) AS f_score,

        NTILE(5) OVER (ORDER BY monetary) AS m_score

    FROM rfm_base
)

SELECT *
FROM scored;

SELECT *
FROM rfm_scores
LIMIT 10;