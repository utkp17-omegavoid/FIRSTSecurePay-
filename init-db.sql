-- FIRSTSecurePay - Initial Database Schema (Simplified for Demo)

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users
CREATE TABLE IF NOT EXISTS users (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email           VARCHAR(255) UNIQUE NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    full_name       VARCHAR(150) NOT NULL,
    phone           VARCHAR(20),
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- User Devices (for device binding)
CREATE TABLE IF NOT EXISTS user_devices (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    device_id       VARCHAR(255) NOT NULL,
    device_name     VARCHAR(150),
    is_trusted      BOOLEAN DEFAULT FALSE,
    last_used_at    TIMESTAMP WITH TIME ZONE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, device_id)
);

-- Refresh Tokens / Sessions
CREATE TABLE IF NOT EXISTS refresh_tokens (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token           VARCHAR(500) UNIQUE NOT NULL,
    device_id       VARCHAR(255),
    expires_at      TIMESTAMP WITH TIME ZONE NOT NULL,
    revoked         BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Accounts
CREATE TABLE IF NOT EXISTS accounts (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    account_number  VARCHAR(30) UNIQUE NOT NULL,
    account_type    VARCHAR(30) NOT NULL, -- SAVINGS, CURRENT, etc.
    balance         DECIMAL(15,2) DEFAULT 0.00,
    currency        VARCHAR(3) DEFAULT 'INR',
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Transactions
CREATE TABLE IF NOT EXISTS transactions (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    account_id      UUID NOT NULL REFERENCES accounts(id),
    amount          DECIMAL(15,2) NOT NULL,
    currency        VARCHAR(3) DEFAULT 'INR',
    type            VARCHAR(20) NOT NULL, -- CREDIT, DEBIT
    category        VARCHAR(50),
    description     TEXT,
    reference_id    VARCHAR(100),
    status          VARCHAR(20) DEFAULT 'SUCCESS',
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Payments
CREATE TABLE IF NOT EXISTS payments (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id),
    account_id      UUID NOT NULL REFERENCES accounts(id),
    amount          DECIMAL(15,2) NOT NULL,
    currency        VARCHAR(3) DEFAULT 'INR',
    payment_rail    VARCHAR(30) NOT NULL, -- UPI, CARD, NETBANKING, BILLPAY
    beneficiary_id  UUID,
    status          VARCHAR(30) DEFAULT 'INITIATED',
    idempotency_key VARCHAR(100) UNIQUE,
    external_ref    VARCHAR(150),
    failure_reason  TEXT,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Beneficiaries
CREATE TABLE IF NOT EXISTS beneficiaries (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name            VARCHAR(150) NOT NULL,
    account_number  VARCHAR(30),
    ifsc            VARCHAR(20),
    upi_id          VARCHAR(100),
    is_verified     BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Audit Logs
CREATE TABLE IF NOT EXISTS audit_logs (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID,
    action          VARCHAR(100) NOT NULL,
    resource        VARCHAR(100),
    ip_address      VARCHAR(45),
    user_agent      TEXT,
    details         JSONB,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_transactions_account_id ON transactions(account_id);
CREATE INDEX IF NOT EXISTS idx_transactions_created_at ON transactions(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_payments_user_id ON payments(user_id);
CREATE INDEX IF NOT EXISTS idx_payments_idempotency ON payments(idempotency_key);
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_user ON refresh_tokens(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_user ON audit_logs(user_id);
