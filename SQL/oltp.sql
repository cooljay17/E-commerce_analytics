-- DROP DATABASE IF EXISTS ecommerce_ai_dw;

CREATE DATABASE ecommerce_ai_dw
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- ============================================
-- CUSTOMER TABLE
-- ============================================

CREATE TABLE customer (
    customer_id      BIGSERIAL PRIMARY KEY,
    customer_name    VARCHAR(100) NOT NULL,
    email            VARCHAR(150) UNIQUE NOT NULL,
    city             VARCHAR(100)
);

-- ============================================
-- PRODUCTS TABLE
-- ============================================

CREATE TABLE products (
    product_id       BIGSERIAL PRIMARY KEY,
    product_name     VARCHAR(150) NOT NULL,
    category         VARCHAR(100),
    price            NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

-- ============================================
-- ORDERS TABLE
-- ============================================

CREATE TABLE orders (
    order_id         BIGSERIAL PRIMARY KEY,
    customer_id      BIGINT NOT NULL,
    order_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE
);

-- ============================================
-- ORDER_ITEMS TABLE
-- ============================================

CREATE TABLE order_items (
    order_id         BIGINT NOT NULL,
    product_id       BIGINT NOT NULL,
    quantity         INTEGER NOT NULL CHECK (quantity > 0),
    price            NUMERIC(10,2) NOT NULL CHECK (price >= 0),

    CONSTRAINT pk_order_items
        PRIMARY KEY (order_id, product_id),

    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_orderitems_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE RESTRICT
);

-- ============================================
-- INDEXES 
-- ============================================

CREATE INDEX idx_orders_customer_id
    ON orders(customer_id);

CREATE INDEX idx_orderitems_product_id
    ON order_items(product_id);

  
    