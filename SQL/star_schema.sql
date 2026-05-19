-- ============================================
-- DIM_CUSTOMER TABLE
-- ============================================

CREATE TABLE dim_customer (
    customer_id        BIGINT PRIMARY KEY,
    customer_name      VARCHAR(100) NOT NULL,
    city               VARCHAR(100)
);

-- ============================================
-- DIM_PRODUCTS TABLE
-- ============================================

CREATE TABLE dim_products (
    product_id         BIGINT PRIMARY KEY,
    product_name       VARCHAR(150) NOT NULL,
    category           VARCHAR(100)
);

-- ============================================
-- DIM_DATE TABLE
-- ============================================

CREATE TABLE dim_date (
    date_id            INTEGER PRIMARY KEY,
    full_date          DATE NOT NULL UNIQUE,
    month              INTEGER NOT NULL CHECK (month BETWEEN 1 AND 12),
    year               INTEGER NOT NULL,
    quarter            INTEGER NOT NULL CHECK (quarter BETWEEN 1 AND 4)
);

-- ============================================
-- FACT_SALES TABLE
-- ============================================

CREATE TABLE fact_sales (
    customer_id        BIGINT NOT NULL,
    product_id         BIGINT NOT NULL,
    date_id            INTEGER NOT NULL,

    quantity           INTEGER NOT NULL CHECK (quantity > 0),
    total_amount       NUMERIC(12,2) NOT NULL CHECK (total_amount >= 0),

    CONSTRAINT fk_factsales_customer
        FOREIGN KEY (customer_id)
        REFERENCES dim_customer(customer_id),

    CONSTRAINT fk_factsales_product
        FOREIGN KEY (product_id)
        REFERENCES dim_products(product_id),

    CONSTRAINT fk_factsales_date
        FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id)
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

CREATE INDEX idx_fact_sales_customer
    ON fact_sales(customer_id);

CREATE INDEX idx_fact_sales_product
    ON fact_sales(product_id);

CREATE INDEX idx_fact_sales_date
    ON fact_sales(date_id);

CREATE INDEX idx_dim_date_year_month
    ON dim_date(year, month);