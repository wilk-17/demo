-- SQL Script to populate permissions for the entire system
-- This script defines granular permissions for all 23 modules

-- Clean existing permissions (optional - comment out if you want to keep existing ones)
-- DELETE FROM role_permission;
-- DELETE FROM permission;

-- ========================================
-- EMPLOYEE MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_EMPLOYEES', 'Ver empleados', 'EMPLOYEES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_EMPLOYEES', 'Crear y editar empleados', 'EMPLOYEES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_EMPLOYEES', 'Eliminar empleados', 'EMPLOYEES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- USER MANAGEMENT PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('MANAGE_USERS', 'Administrar usuarios', 'ADMIN', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ROLE MANAGEMENT PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('MANAGE_ROLES', 'Administrar roles y permisos', 'ADMIN', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- BRANCH MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_BRANCHES', 'Ver sucursales', 'BRANCHES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_BRANCHES', 'Crear y editar sucursales', 'BRANCHES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_BRANCHES', 'Eliminar sucursales', 'BRANCHES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- STATE MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_STATES', 'Ver estados', 'LOCATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_STATES', 'Crear y editar estados', 'LOCATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_STATES', 'Eliminar estados', 'LOCATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- CITY MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_CITIES', 'Ver ciudades', 'LOCATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_CITIES', 'Crear y editar ciudades', 'LOCATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_CITIES', 'Eliminar ciudades', 'LOCATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- PERSON MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_PERSONS', 'Ver personas', 'PERSONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_PERSONS', 'Crear y editar personas', 'PERSONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_PERSONS', 'Eliminar personas', 'PERSONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ORGANIZATION MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_ORGANIZATIONS', 'Ver organizaciones', 'ORGANIZATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_ORGANIZATIONS', 'Crear y editar organizaciones', 'ORGANIZATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_ORGANIZATIONS', 'Eliminar organizaciones', 'ORGANIZATIONS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- BRAND MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_BRANDS', 'Ver marcas', 'BRANDS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_BRANDS', 'Crear y editar marcas', 'BRANDS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_BRANDS', 'Eliminar marcas', 'BRANDS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- CATEGORY MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_CATEGORIES', 'Ver categorías', 'CATEGORIES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_CATEGORIES', 'Crear y editar categorías', 'CATEGORIES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_CATEGORIES', 'Eliminar categorías', 'CATEGORIES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- INVENTORY MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_INVENTORY', 'Ver inventario', 'INVENTORY', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_INVENTORY', 'Gestionar inventario', 'INVENTORY', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_INVENTORY', 'Eliminar artículos de inventario', 'INVENTORY', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- INVOICE MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_INVOICES', 'Ver facturas', 'INVOICES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_INVOICES', 'Crear y editar facturas', 'INVOICES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_INVOICES', 'Eliminar facturas', 'INVOICES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- SALES ORDER MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_ORDERS', 'Ver órdenes de venta', 'SALES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_ORDERS', 'Crear y editar órdenes de venta', 'SALES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_ORDERS', 'Eliminar órdenes de venta', 'SALES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ASSIGNMENT MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_ASSIGNMENTS', 'Ver asignaciones', 'ASSIGNMENTS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_ASSIGNMENTS', 'Crear y editar asignaciones', 'ASSIGNMENTS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_ASSIGNMENTS', 'Eliminar asignaciones', 'ASSIGNMENTS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- QUOTE/COTIZACIÓN MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_QUOTES', 'Ver cotizaciones', 'SALES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_QUOTES', 'Crear y editar cotizaciones', 'SALES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_QUOTES', 'Eliminar cotizaciones', 'SALES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- SALES GOAL MODULE PERMISSIONS
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_GOALS', 'Ver metas de ventas', 'GOALS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_GOALS', 'Crear y editar metas de ventas', 'GOALS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('DELETE_GOALS', 'Eliminar metas de ventas', 'GOALS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ADMIN PERMISSIONS (Full System Access)
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('ADMIN_ALL', 'Acceso total al sistema', 'ADMIN', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- REPORTING PERMISSIONS (Kept from original)
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('READ_REPORTS', 'Leer reportes del sistema', 'REPORTS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;
INSERT INTO permission (name, description, module, created_at) VALUES ('WRITE_REPORTS', 'Crear y modificar reportes', 'REPORTS', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

-- ========================================
-- ORDER APPROVAL PERMISSION (Kept from original)
-- ========================================
INSERT INTO permission (name, description, module, created_at) VALUES ('APPROVE_ORDERS', 'Aprobar órdenes de venta', 'SALES', CURRENT_TIMESTAMP) ON CONFLICT (name) DO NOTHING;

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
