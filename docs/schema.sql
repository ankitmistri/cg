CREATE TABLE roles (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30) UNIQUE NOT NULL CHECK (name IN ('AGENT','TEAM_LEADER','MANAGER'))
);

CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(160) UNIQUE NOT NULL,
  phone VARCHAR(30),
  password_hash TEXT NOT NULL,
  role_id INT NOT NULL REFERENCES roles(id),
  active BOOLEAN DEFAULT TRUE,
  manager_id BIGINT REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE product_types (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  active BOOLEAN DEFAULT TRUE,
  created_by BIGINT REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE product_variants (
  id BIGSERIAL PRIMARY KEY,
  product_type_id BIGINT NOT NULL REFERENCES product_types(id),
  name VARCHAR(100) NOT NULL,
  active BOOLEAN DEFAULT TRUE,
  UNIQUE(product_type_id, name)
);

CREATE TABLE product_features (
  id BIGSERIAL PRIMARY KEY,
  product_variant_id BIGINT NOT NULL REFERENCES product_variants(id),
  name VARCHAR(120) NOT NULL,
  active BOOLEAN DEFAULT TRUE,
  UNIQUE(product_variant_id, name)
);

CREATE TABLE entry_categories (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(30) UNIQUE NOT NULL CHECK (name IN ('ISSUE','BUG','GUIDANCE','REQUIREMENT'))
);

CREATE TABLE interaction_entries (
  id BIGSERIAL PRIMARY KEY,
  customer_name VARCHAR(120) NOT NULL,
  contact_number VARCHAR(30) NOT NULL,
  company_name VARCHAR(120),
  product_type_id BIGINT NOT NULL REFERENCES product_types(id),
  product_variant_id BIGINT NOT NULL REFERENCES product_variants(id),
  product_feature_id BIGINT REFERENCES product_features(id),
  category_id BIGINT NOT NULL REFERENCES entry_categories(id),
  description TEXT NOT NULL,
  resolution_notes TEXT,
  internal_remarks TEXT,
  status VARCHAR(40) DEFAULT 'OPEN',
  attachment_url TEXT,
  created_by BIGINT NOT NULL REFERENCES users(id),
  updated_by BIGINT REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE audit_logs (
  id BIGSERIAL PRIMARY KEY,
  actor_user_id BIGINT REFERENCES users(id),
  action VARCHAR(60) NOT NULL,
  entity_type VARCHAR(60) NOT NULL,
  entity_id BIGINT,
  before_data JSONB,
  after_data JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_entries_created_at ON interaction_entries(created_at);
CREATE INDEX idx_entries_agent ON interaction_entries(created_by);
CREATE INDEX idx_entries_category ON interaction_entries(category_id);
