-- ============================================================
-- SCRIPT PARA LIMPIAR TODA LA BASE DE DATOS
-- Base de datos: prueba2
-- Descripción: Elimina todos los registros respetando foreign keys
-- ============================================================

BEGIN;

-- Deshabilitar triggers temporalmente para evitar problemas
SET session_replication_role = 'replica';

-- ============================================================
-- ELIMINAR EN ORDEN INVERSO (de hijos a padres)
-- ============================================================

-- 1. Tablas con relaciones más profundas
TRUNCATE TABLE invoice_item CASCADE;
TRUNCATE TABLE sales_order_item CASCADE;
TRUNCATE TABLE quote_item CASCADE;

-- 2. Tablas de transacciones
TRUNCATE TABLE invoice CASCADE;
TRUNCATE TABLE sales_order CASCADE;
TRUNCATE TABLE quotation_line CASCADE;
TRUNCATE TABLE quote CASCADE;

-- 3. Inventario y productos
TRUNCATE TABLE inventory_item CASCADE;

-- 4. Marcas y categorías
TRUNCATE TABLE brand CASCADE;
TRUNCATE TABLE item_category CASCADE;

-- 5. Relaciones many-to-many
TRUNCATE TABLE role_permission CASCADE;

-- 6. Asignaciones y empleados
TRUNCATE TABLE assignment CASCADE;
TRUNCATE TABLE employee CASCADE;

-- 7. Usuarios y seguridad
TRUNCATE TABLE users CASCADE;
TRUNCATE TABLE permission CASCADE;
TRUNCATE TABLE role CASCADE;

-- 8. Personas
TRUNCATE TABLE person CASCADE;

-- 9. Sucursales
TRUNCATE TABLE branch CASCADE;

-- 10. Organizaciones
TRUNCATE TABLE organization CASCADE;

-- 11. Ciudades y estados
TRUNCATE TABLE city CASCADE;
TRUNCATE TABLE state CASCADE;

-- 12. Logs y auditoría (si existen)
TRUNCATE TABLE activity_log CASCADE;
TRUNCATE TABLE sales_goal CASCADE;

-- Rehabilitar triggers
SET session_replication_role = 'origin';

COMMIT;

-- ============================================================
-- REINICIAR SECUENCIAS (AUTO_INCREMENT)
-- ============================================================
ALTER SEQUENCE IF EXISTS state_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS city_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS organization_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS branch_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS person_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS role_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS permission_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS users_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS employee_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS assignment_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS brand_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS item_category_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS inventory_item_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS quotation_line_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS quote_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS quote_item_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS sales_order_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS sales_order_item_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS invoice_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS invoice_item_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS activity_log_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS sales_goal_id_seq RESTART WITH 1;

-- ============================================================
-- VERIFICACIÓN
-- ============================================================
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

SELECT 'Base de datos limpiada exitosamente!' AS resultado;
