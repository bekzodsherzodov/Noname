CREATE TABLE IF NOT EXISTS users (
 id uuid PRIMARY KEY,
 username varchar(40) UNIQUE NOT NULL,
 password_hash text NOT NULL,
 role varchar(20) NOT NULL DEFAULT 'user',
 trial_until timestamptz NOT NULL,
 subscription_until timestamptz NOT NULL DEFAULT to_timestamp(0),
 plan varchar(30) NOT NULL DEFAULT 'free',
 profile jsonb NOT NULL DEFAULT '{}'::jsonb,
 state jsonb NOT NULL DEFAULT '{"entries":[],"shops":[]}'::jsonb,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS sessions (
 id text PRIMARY KEY,
 user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 expires_at timestamptz NOT NULL,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS sessions_user_idx ON sessions(user_id);
CREATE TABLE IF NOT EXISTS shops (
 id uuid PRIMARY KEY,
 user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 name varchar(120) NOT NULL,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS products (
 id uuid PRIMARY KEY,
 user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 shop_id uuid REFERENCES shops(id) ON DELETE SET NULL,
 name varchar(180) NOT NULL,
 sku varchar(80),
 sale_price numeric(14,2) NOT NULL DEFAULT 0,
 cost_price numeric(14,2) NOT NULL DEFAULT 0,
 stock_qty numeric(14,3) NOT NULL DEFAULT 0,
 min_stock numeric(14,3) NOT NULL DEFAULT 0,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS products_user_idx ON products(user_id);
CREATE TABLE IF NOT EXISTS customers (
 id uuid PRIMARY KEY,
 user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 name varchar(180) NOT NULL,
 phone varchar(40),
 balance numeric(14,2) NOT NULL DEFAULT 0,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS customers_user_idx ON customers(user_id);
CREATE TABLE IF NOT EXISTS sales (
 id uuid PRIMARY KEY,
 user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 shop_id uuid REFERENCES shops(id) ON DELETE SET NULL,
 customer_id uuid REFERENCES customers(id) ON DELETE SET NULL,
 total numeric(14,2) NOT NULL,
 payment_method varchar(20) NOT NULL,
 items jsonb NOT NULL,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS sales_user_date_idx ON sales(user_id, created_at);
CREATE TABLE IF NOT EXISTS payment_requests (
 id uuid PRIMARY KEY,
 user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 plan varchar(30) NOT NULL,
 amount numeric(14,2) NOT NULL,
 proof_key text,
 status varchar(20) NOT NULL DEFAULT 'pending',
 reviewed_by uuid REFERENCES users(id) ON DELETE SET NULL,
 reviewed_at timestamptz,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS payments_status_idx ON payment_requests(status, created_at);
CREATE TABLE IF NOT EXISTS audit_logs (
 id bigserial PRIMARY KEY,
 user_id uuid REFERENCES users(id) ON DELETE SET NULL,
 action varchar(80) NOT NULL,
 meta jsonb NOT NULL DEFAULT '{}'::jsonb,
 created_at timestamptz NOT NULL DEFAULT now()
);
