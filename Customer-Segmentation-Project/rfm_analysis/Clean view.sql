CREATE VIEW retail_clean AS
SELECT
    invoice_no,
    stock_code,
    description,
    quantity,
    invoice_date,
    price,
    customer_id,
    country,
    quantity * price AS revenue
FROM online_retail
WHERE
    quantity > 0
    AND price > 0
    AND customer_id IS NOT NULL
    AND invoice_no NOT LIKE 'C%';