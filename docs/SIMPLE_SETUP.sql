-- Simple Database Setup for Expense Tracker App
-- This script creates essential data for the app to work

-- Insert default categories (without complex subcategories)
INSERT INTO categories (id, name, icon_name, color_hex, is_active, created_at, updated_at) VALUES
  ('550e8400-e29b-41d4-a716-446655440000', 'Food & Dining', 'restaurant', '#F59E0B', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440001', 'Transportation', 'directions_car', '#06B6D4', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440002', 'Entertainment', 'movie', '#8B5CF6', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440003', 'Shopping', 'shopping_bag', '#EC4899', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440004', 'Health', 'local_hospital', '#10B981', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440005', 'Salary', 'work', '#3B82F6', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440006', 'Freelance', 'laptop', '#6366F1', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440007', 'Investment', 'trending_up', '#F59E0B', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440008', 'Utilities', 'electric_bolt', '#64748B', true, NOW(), NOW()),
  ('550e8400-e29b-41d4-a716-446655440009', 'Education', 'school', '#3B82F6', true, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  icon_name = EXCLUDED.icon_name,
  color_hex = EXCLUDED.color_hex,
  updated_at = NOW();

-- Insert ONE default payment method (since it's optional but needed for DB constraint)
INSERT INTO payment_methods (id, name, icon_name, color_hex, is_active, created_at, updated_at) VALUES
  ('550e8400-e29b-41d4-a716-446655440010', 'Cash', 'payments', '#10B981', true, NOW(), NOW())
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  updated_at = NOW();

-- Verify setup
SELECT 'Categories available:' as info, COUNT(*) as count FROM categories WHERE is_active = true
UNION ALL
SELECT 'Payment methods available:' as info, COUNT(*) as count FROM payment_methods WHERE is_active = true;

-- Show all categories
SELECT 'CATEGORIES:' as title, '' as name, '' as icon, '' as color
UNION ALL
SELECT '', name, icon_name, color_hex FROM categories WHERE is_active = true ORDER BY name;
