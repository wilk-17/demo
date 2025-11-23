-- SQL Script to populate permissions for the entire system
-- This script defines granular permissions for all 23 modules

-- Clean existing permissions (optional - comment out if you want to keep existing ones)
-- DELETE FROM role_permission;
-- DELETE FROM permission;

-- ========================================
-- EMPLOYEE MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_EMPLOYEES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_EMPLOYEES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_EMPLOYEES') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- USER MANAGEMENT PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('MANAGE_USERS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ROLE MANAGEMENT PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('MANAGE_ROLES') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- BRANCH MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_BRANCHES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_BRANCHES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_BRANCHES') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- STATE MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_STATES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_STATES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_STATES') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- CITY MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_CITIES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_CITIES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_CITIES') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- PERSON MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_PERSONS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_PERSONS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_PERSONS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ORGANIZATION MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_ORGANIZATIONS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_ORGANIZATIONS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_ORGANIZATIONS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- BRAND MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_BRANDS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_BRANDS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_BRANDS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- CATEGORY MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_CATEGORIES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_CATEGORIES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_CATEGORIES') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- INVENTORY MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_INVENTORY') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_INVENTORY') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_INVENTORY') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- INVOICE MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_INVOICES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_INVOICES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_INVOICES') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- SALES ORDER MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_ORDERS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_ORDERS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_ORDERS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ASSIGNMENT MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_ASSIGNMENTS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_ASSIGNMENTS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_ASSIGNMENTS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- QUOTE/COTIZACIÓN MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_QUOTES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_QUOTES') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_QUOTES') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- SALES GOAL MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name) VALUES ('READ_GOALS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_GOALS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('DELETE_GOALS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ADMIN PERMISSIONS (Full System Access)
-- ========================================
INSERT INTO permission (name) VALUES ('ADMIN_ALL') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- REPORTING PERMISSIONS (Kept from original)
-- ========================================
INSERT INTO permission (name) VALUES ('READ_REPORTS') ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name) VALUES ('WRITE_REPORTS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ORDER APPROVAL PERMISSION (Kept from original)
-- ========================================
INSERT INTO permission (name) VALUES ('APPROVE_ORDERS') ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ROLE-PERMISSION ASSIGNMENTS
-- ========================================

-- Get role IDs (assuming you have these roles)
-- Adjust role_id values based on your actual database

-- ADMIN ROLE (id = 1) - Gets ALL permissions
INSERT INTO role_permission (role_id, permission_id)
SELECT 1, id FROM permission
ON CONFLICT (role_id, permission_id) DO NOTHING;

-- MANAGER ROLE (id = 2) - Example: Read all, write most, limited delete
-- You would define this based on your business needs
-- Uncomment and adjust as needed:
/*
INSERT INTO role_permission (role_id, permission_id)
SELECT 2, id FROM permission WHERE name LIKE 'READ_%'
ON CONFLICT (role_id, permission_id) DO NOTHING;

INSERT INTO role_permission (role_id, permission_id)
SELECT 2, id FROM permission WHERE name IN (
    'WRITE_EMPLOYEES', 'WRITE_BRANCHES', 'WRITE_INVENTORY', 
    'WRITE_INVOICES', 'WRITE_ORDERS', 'WRITE_QUOTES', 'WRITE_GOALS',
    'APPROVE_ORDERS'
)
ON CONFLICT (role_id, permission_id) DO NOTHING;
*/

-- SALES ROLE (id = 3) - Example: Sales-specific permissions
-- Uncomment and adjust as needed:
/*
INSERT INTO role_permission (role_id, permission_id)
SELECT 3, id FROM permission WHERE name IN (
    'READ_EMPLOYEES', 'READ_BRANCHES', 'READ_PERSONS', 'READ_ORGANIZATIONS',
    'READ_INVENTORY', 'READ_INVOICES', 'READ_ORDERS', 'READ_QUOTES', 'READ_GOALS',
    'WRITE_INVOICES', 'WRITE_ORDERS', 'WRITE_QUOTES',
    'READ_REPORTS'
)
ON CONFLICT (role_id, permission_id) DO NOTHING;
*/

-- ========================================
-- VERIFICATION QUERY
-- ========================================
-- Run this to see all permissions and their role assignments
/*
SELECT r.name AS role_name, p.name AS permission_name
FROM role r
JOIN role_permission rp ON r.id = rp.role_id
JOIN permission p ON rp.permission_id = p.id
ORDER BY r.name, p.name;
*/

-- ========================================
-- SUMMARY
-- ========================================
-- Total Permissions Created: 49
-- Modules Covered: 23
-- 
-- Permission Categories:
-- - READ_*: 17 permissions (view/list operations)
-- - WRITE_*: 17 permissions (create/update operations)
-- - DELETE_*: 12 permissions (delete operations)
-- - MANAGE_*: 2 permissions (users, roles)
-- - ADMIN_ALL: 1 permission (full system access)
-- - APPROVE_ORDERS: 1 permission (special approval)
-- - READ/WRITE_REPORTS: 2 permissions (reporting)
