CREATE OR REPLACE VIEW sales_summary AS
SELECT
    DATE_TRUNC('month', transaction_date) AS month,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    SUM(quantity * unit_price) AS total_sales
FROM transaction_data
GROUP BY DATE_TRUNC('month', transaction_date)
ORDER BY month;

CREATE MATERIALIZED VIEW sales_summary_mv AS
SELECT
    DATE_TRUNC('month', transaction_date) AS month,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    SUM(quantity * unit_price) AS total_sales
FROM transaction_data
GROUP BY DATE_TRUNC('month', transaction_date)
ORDER BY month;


DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'reporting_team') THEN
        CREATE ROLE reporting_team LOGIN PASSWORD 'Report@123';
    END IF;
END $$;

-- REVOKE all access to the base table for safety
REVOKE ALL ON transaction_data FROM reporting_team;

-- GRANT access to only the views (read-only)
GRANT CONNECT ON DATABASE current_database() TO reporting_team;
GRANT USAGE ON SCHEMA techmart TO reporting_team;
GRANT SELECT ON sales_summary TO reporting_team;
GRANT SELECT ON sales_summary_mv TO reporting_team;
