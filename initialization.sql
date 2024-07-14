-- Create extension for PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create extension for UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create roles table
CREATE TABLE IF NOT EXISTS roles (
    role_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR
);

-- Create companies table
CREATE TABLE IF NOT EXISTS companies (
    company_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR,
    address VARCHAR,
    contact_person VARCHAR,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR UNIQUE,
    username VARCHAR UNIQUE,
    password VARCHAR,
    role_id UUID NOT NULL REFERENCES roles(role_id),
    company_id UUID NULL REFERENCES companies(company_id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Create blacklisttokens table
CREATE TABLE IF NOT EXISTS blacklisttokens (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    expire TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Create hazards table
CREATE TABLE IF NOT EXISTS hazards (
    hazard_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(user_id),
    hazard_type VARCHAR,
    subtype VARCHAR,
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    altitude DECIMAL(9, 6),
    geo_location GEOMETRY(POINTZ, 4326),
    description VARCHAR,
    speed DECIMAL(9, 6),
    title VARCHAR,
    temperature DECIMAL(9, 6),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Insert default roles
INSERT INTO roles(role_id, name) VALUES
    ('4766964f-e820-43b6-980e-6b7978a8e800', 'users'),
    ('feeb5696-9a63-495f-b55f-64a483db2e54', 'admins')
ON CONFLICT (role_id) DO NOTHING;

-- Insert default company
INSERT INTO companies(company_id, name, address, contact_person) VALUES
    ('834a47cf-0e1c-4ec9-9735-dbc5c48aa807', 'Offshoremintoring', '', '')
ON CONFLICT (company_id) DO NOTHING;

-- Insert default test user
INSERT INTO users(user_id, email, username, password, role_id, company_id) VALUES
    ('41c5a9c0-4c91-452f-ac84-fa55a28c5299', 'junaid_arif@hotmail.com', 'junaid_arif@hotmail.com', '$2b$12$ZikUONstFFG.zd1TgTdLb.yghWP1gNCgBha1U4ehokwkiyVJbtLKO', '4766964f-e820-43b6-980e-6b7978a8e800', '834a47cf-0e1c-4ec9-9735-dbc5c48aa807')
ON CONFLICT (user_id) DO NOTHING;
