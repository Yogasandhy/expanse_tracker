-- ============================================
-- SUPABASE DATABASE SETUP - COPY PASTE SCRIPT
-- ============================================
-- Jalankan script ini di Supabase SQL Editor
-- URL: https://thsupsxfhcrmfbpburdp.supabase.co

-- Step 1: Enable Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Step 2: Create Tables
-- Categories Table
CREATE TABLE IF NOT EXISTS public.categories (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    icon_name VARCHAR(100) NOT NULL,
    color_hex VARCHAR(7) NOT NULL,
    is_income_category BOOLEAN DEFAULT FALSE,
    subcategories JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Payment Methods Table
CREATE TABLE IF NOT EXISTS public.payment_methods (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    icon_name VARCHAR(100) NOT NULL,
    color_hex VARCHAR(7) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Transactions Table
CREATE TABLE IF NOT EXISTS public.transactions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    description VARCHAR(500) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    type VARCHAR(10) NOT NULL CHECK (type IN ('income', 'expense')),
    category_id UUID REFERENCES public.categories(id) ON DELETE CASCADE,
    subcategory_id VARCHAR(100),
    payment_method_id UUID REFERENCES public.payment_methods(id) ON DELETE CASCADE,
    date TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Step 3: Create Indexes
CREATE INDEX IF NOT EXISTS idx_transactions_date ON public.transactions(date);
CREATE INDEX IF NOT EXISTS idx_transactions_type ON public.transactions(type);
CREATE INDEX IF NOT EXISTS idx_transactions_category_id ON public.transactions(category_id);

-- Step 4: Enable RLS
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payment_methods ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;

-- Step 5: Create Policies (Allow all operations for now)
DROP POLICY IF EXISTS "Enable all operations for categories" ON public.categories;
DROP POLICY IF EXISTS "Enable all operations for payment_methods" ON public.payment_methods;
DROP POLICY IF EXISTS "Enable all operations for transactions" ON public.transactions;

CREATE POLICY "Enable all operations for categories" ON public.categories FOR ALL USING (true);
CREATE POLICY "Enable all operations for payment_methods" ON public.payment_methods FOR ALL USING (true);
CREATE POLICY "Enable all operations for transactions" ON public.transactions FOR ALL USING (true);

-- Step 6: Insert Initial Data
-- Clear existing data first
DELETE FROM public.transactions;
DELETE FROM public.categories;
DELETE FROM public.payment_methods;

-- Insert Payment Methods
INSERT INTO public.payment_methods (id, name, icon_name, color_hex) VALUES
    ('550e8400-e29b-41d4-a716-446655440001', 'Cash', 'moneyBill', '#4CAF50'),
    ('550e8400-e29b-41d4-a716-446655440002', 'E-Wallet', 'wallet', '#2196F3'),
    ('550e8400-e29b-41d4-a716-446655440003', 'Bank', 'buildingColumns', '#FF9800'),
    ('550e8400-e29b-41d4-a716-446655440004', 'Credit Card', 'creditCard', '#9C27B0');

-- Insert Categories (Expense)
INSERT INTO public.categories (id, name, icon_name, color_hex, is_income_category, subcategories) VALUES
    ('550e8400-e29b-41d4-a716-446655440011', 'Food', 'utensils', '#FF6B6B', false, '[
        {"id": "sub1", "name": "Coffee", "iconName": "mugHot", "categoryId": "550e8400-e29b-41d4-a716-446655440011"},
        {"id": "sub2", "name": "Restaurant", "iconName": "utensils", "categoryId": "550e8400-e29b-41d4-a716-446655440011"},
        {"id": "sub3", "name": "Groceries", "iconName": "cartShopping", "categoryId": "550e8400-e29b-41d4-a716-446655440011"}
    ]'::jsonb),
    ('550e8400-e29b-41d4-a716-446655440012', 'Transport', 'car', '#4ECDC4', false, '[
        {"id": "sub4", "name": "Fuel", "iconName": "gasPump", "categoryId": "550e8400-e29b-41d4-a716-446655440012"},
        {"id": "sub5", "name": "Public Transport", "iconName": "bus", "categoryId": "550e8400-e29b-41d4-a716-446655440012"},
        {"id": "sub6", "name": "Taxi", "iconName": "taxi", "categoryId": "550e8400-e29b-41d4-a716-446655440012"}
    ]'::jsonb),
    ('550e8400-e29b-41d4-a716-446655440013', 'Entertainment', 'gamepad', '#45B7D1', false, '[
        {"id": "sub7", "name": "Movie", "iconName": "film", "categoryId": "550e8400-e29b-41d4-a716-446655440013"},
        {"id": "sub8", "name": "Music", "iconName": "music", "categoryId": "550e8400-e29b-41d4-a716-446655440013"}
    ]'::jsonb),
    ('550e8400-e29b-41d4-a716-446655440014', 'Shopping', 'shoppingBag', '#96CEB4', false, '[
        {"id": "sub9", "name": "Clothes", "iconName": "shirt", "categoryId": "550e8400-e29b-41d4-a716-446655440014"},
        {"id": "sub10", "name": "Electronics", "iconName": "laptop", "categoryId": "550e8400-e29b-41d4-a716-446655440014"}
    ]'::jsonb),
    ('550e8400-e29b-41d4-a716-446655440015', 'Bills', 'fileInvoiceDollar', '#FECA57', false, '[
        {"id": "sub11", "name": "Electricity", "iconName": "bolt", "categoryId": "550e8400-e29b-41d4-a716-446655440015"},
        {"id": "sub12", "name": "Internet", "iconName": "wifi", "categoryId": "550e8400-e29b-41d4-a716-446655440015"}
    ]'::jsonb);

-- Insert Categories (Income)
INSERT INTO public.categories (id, name, icon_name, color_hex, is_income_category, subcategories) VALUES
    ('550e8400-e29b-41d4-a716-446655440021', 'Salary', 'moneyBillWave', '#4CAF50', true, '[
        {"id": "sub13", "name": "Basic Salary", "iconName": "moneyBillWave", "categoryId": "550e8400-e29b-41d4-a716-446655440021"},
        {"id": "sub14", "name": "Bonus", "iconName": "gift", "categoryId": "550e8400-e29b-41d4-a716-446655440021"}
    ]'::jsonb),
    ('550e8400-e29b-41d4-a716-446655440022', 'Investment', 'chartLine', '#2196F3', true, '[
        {"id": "sub15", "name": "Dividend", "iconName": "chartLine", "categoryId": "550e8400-e29b-41d4-a716-446655440022"},
        {"id": "sub16", "name": "Interest", "iconName": "percent", "categoryId": "550e8400-e29b-41d4-a716-446655440022"}
    ]'::jsonb),
    ('550e8400-e29b-41d4-a716-446655440023', 'Freelance', 'laptop', '#3498DB', true, '[
        {"id": "sub17", "name": "Projects", "iconName": "code", "categoryId": "550e8400-e29b-41d4-a716-446655440023"},
        {"id": "sub18", "name": "Consulting", "iconName": "handshake", "categoryId": "550e8400-e29b-41d4-a716-446655440023"}
    ]'::jsonb);

-- Insert Sample Transactions
INSERT INTO public.transactions (id, description, amount, type, category_id, subcategory_id, payment_method_id, date) VALUES
    ('550e8400-e29b-41d4-a716-446655440101', 'Coffee at Starbucks', 4.50, 'expense', '550e8400-e29b-41d4-a716-446655440011', 'sub1', '550e8400-e29b-41d4-a716-446655440001', '2025-08-20 08:00:00+00'),
    ('550e8400-e29b-41d4-a716-446655440102', 'Monthly Salary', 5000.00, 'income', '550e8400-e29b-41d4-a716-446655440021', 'sub13', '550e8400-e29b-41d4-a716-446655440003', '2025-08-01 09:00:00+00'),
    ('550e8400-e29b-41d4-a716-446655440103', 'Grocery Shopping at Supermarket', 85.30, 'expense', '550e8400-e29b-41d4-a716-446655440011', 'sub3', '550e8400-e29b-41d4-a716-446655440004', '2025-08-19 18:30:00+00'),
    ('550e8400-e29b-41d4-a716-446655440104', 'Gas Station Fill Up', 45.00, 'expense', '550e8400-e29b-41d4-a716-446655440012', 'sub4', '550e8400-e29b-41d4-a716-446655440001', '2025-08-18 16:45:00+00'),
    ('550e8400-e29b-41d4-a716-446655440105', 'Movie Tickets - Avengers', 25.00, 'expense', '550e8400-e29b-41d4-a716-446655440013', 'sub7', '550e8400-e29b-41d4-a716-446655440004', '2025-08-17 20:15:00+00'),
    ('550e8400-e29b-41d4-a716-446655440106', 'Freelance Web Development', 1200.00, 'income', '550e8400-e29b-41d4-a716-446655440023', 'sub17', '550e8400-e29b-41d4-a716-446655440003', '2025-08-15 14:30:00+00'),
    ('550e8400-e29b-41d4-a716-446655440107', 'Online Shopping - Clothes', 67.80, 'expense', '550e8400-e29b-41d4-a716-446655440014', 'sub9', '550e8400-e29b-41d4-a716-446655440002', '2025-08-16 11:20:00+00'),
    ('550e8400-e29b-41d4-a716-446655440108', 'Electricity Bill Payment', 120.50, 'expense', '550e8400-e29b-41d4-a716-446655440015', 'sub11', '550e8400-e29b-41d4-a716-446655440003', '2025-08-05 10:00:00+00'),
    ('550e8400-e29b-41d4-a716-446655440109', 'Investment Dividend', 150.00, 'income', '550e8400-e29b-41d4-a716-446655440022', 'sub15', '550e8400-e29b-41d4-a716-446655440003', '2025-08-10 12:00:00+00'),
    ('550e8400-e29b-41d4-a716-446655440110', 'Restaurant Dinner Date', 89.50, 'expense', '550e8400-e29b-41d4-a716-446655440011', 'sub2', '550e8400-e29b-41d4-a716-446655440004', '2025-08-14 19:30:00+00');

-- Verify the setup
SELECT 'Database setup complete!' as status;
SELECT 'Payment Methods:' as info, COUNT(*) as count FROM public.payment_methods;
SELECT 'Categories:' as info, COUNT(*) as count FROM public.categories;
SELECT 'Transactions:' as info, COUNT(*) as count FROM public.transactions;
