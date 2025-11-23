-- Script para poblar solo los 5 NUEVOS modelos en la base de datos
-- Ejecutar manualmente en PostgreSQL después de que las tablas se hayan creado

-- VERIFICAR QUE LAS TABLAS NUEVAS EXISTAN
SELECT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE table_name IN ('assignment', 'quote', 'quotation_line', 'quote_item', 'sales_goal')
);

-- 1. ASIGNACIONES DE ITEMS A EMPLEADOS
-- Primero verificar si ya existen datos
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM assignment LIMIT 1) THEN
        INSERT INTO assignment (employee_id, item_id, quantity, assigned_date, status, return_date, condition, notes, creation_date, update_date) VALUES
        -- Asignaciones activas
        (1, 3, 1, '2024-09-01', 'ACTIVE', NULL, NULL, 'MacBook Pro para gerente de tienda', NOW(), NULL),
        (2, 2, 1, '2024-09-15', 'ACTIVE', NULL, NULL, 'iPhone 14 Pro para vendedor senior', NOW(), NULL),
        (4, 11, 1, '2024-08-20', 'ACTIVE', NULL, NULL, 'Dell XPS para gerente regional', NOW(), NULL),
        (6, 6, 1, '2024-10-01', 'ACTIVE', NULL, NULL, 'iPad Air para demostración en tienda', NOW(), NULL),
        -- Asignaciones devueltas
        (3, 13, 1, '2024-07-10', 'RETURNED', '2024-09-30', 'Buen estado', 'Devolución por cambio de equipo', NOW(), NOW()),
        (5, 4, 1, '2024-06-15', 'RETURNED', '2024-10-15', 'Excelente estado', 'Actualización de equipo', NOW(), NOW()),
        -- Asignación perdida
        (7, 10, 1, '2024-08-01', 'LOST', NULL, NULL, 'Reportado como extraviado - en investigación', NOW(), NOW());
        
        RAISE NOTICE 'Se insertaron 7 asignaciones';
    ELSE
        RAISE NOTICE 'La tabla assignment ya tiene datos, se omite la inserción';
    END IF;
END $$;

-- 2. COTIZACIONES
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM quote LIMIT 1) THEN
        INSERT INTO quote (customer_name, date, total, employee_id) VALUES
        ('Empresa ABC S.A.S', '2024-10-20', 45000000.00, 1),
        ('Colegio San José', '2024-10-22', 12500000.00, 2),
        ('Universidad Nacional', '2024-10-25', 89970000.00, 4),
        ('Hotel Estelar', '2024-10-28', 23000000.00, 6),
        ('Clínica del Norte', '2024-10-30', 15500000.00, 3),
        ('Gobierno Municipal', '2024-11-01', 67500000.00, 5);
        
        RAISE NOTICE 'Se insertaron 6 cotizaciones';
    ELSE
        RAISE NOTICE 'La tabla quote ya tiene datos, se omite la inserción';
    END IF;
END $$;

-- 3. LÍNEAS DE COTIZACIÓN (Detalladas)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM quotation_line LIMIT 1) THEN
        INSERT INTO quotation_line (quote_id, description, quantity, price, item_id) VALUES
        -- Cotización 1: Empresa ABC
        (1, 'MacBook Pro 14" - Equipo para ejecutivos', 5, 8999000.00, 3),
        -- Cotización 2: Colegio
        (2, 'iPad Air - Tablets para aula digital', 5, 2899000.00, 6),
        (2, 'HP Pavilion 15 - Laptops para profesores', 5, 2499000.00, 4),
        -- Cotización 3: Universidad
        (3, 'Dell XPS 13 - Equipos para laboratorio', 10, 5499000.00, 11),
        (3, 'Lenovo ThinkPad X1 - Equipos para administrativos', 5, 6299000.00, 12),
        (3, 'LG OLED 55" - Pantallas para auditorios', 2, 4599000.00, 7),
        -- Cotización 4: Hotel
        (4, 'Samsung Galaxy S23 - Smartphones para recepción', 7, 3299000.00, 1),
        -- Cotización 5: Clínica
        (5, 'Tablets Samsung Galaxy Tab S8 - Registro de pacientes', 5, 2199000.00, 5),
        (5, 'Dell XPS 13 - Equipos para consultorios', 1, 5499000.00, 11),
        -- Cotización 6: Gobierno
        (6, 'Lenovo ThinkPad X1 - Equipos para funcionarios', 10, 6299000.00, 12),
        (6, 'HP Pavilion 15 - Equipos para oficinas', 3, 2499000.00, 4);
        
        RAISE NOTICE 'Se insertaron 12 líneas de cotización';
    ELSE
        RAISE NOTICE 'La tabla quotation_line ya tiene datos, se omite la inserción';
    END IF;
END $$;

-- 4. ITEMS DE COTIZACIÓN (Simple - Alternativo)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM quote_item LIMIT 1) THEN
        INSERT INTO quote_item (quote_id, item_id, quantity) VALUES
        -- Cotización 1
        (1, 3, 5),   -- MacBook Pro
        (1, 14, 5),  -- Apple Watch
        -- Cotización 2
        (2, 6, 5),   -- iPad Air
        (2, 4, 5),   -- HP Pavilion
        -- Cotización 3
        (3, 11, 10), -- Dell XPS
        (3, 12, 5),  -- Lenovo ThinkPad
        (3, 7, 2),   -- LG OLED
        -- Cotización 4
        (4, 1, 7),   -- Samsung Galaxy S23
        -- Cotización 5
        (5, 5, 5),   -- Galaxy Tab S8
        (5, 11, 1),  -- Dell XPS
        -- Cotización 6
        (6, 12, 10), -- Lenovo ThinkPad
        (6, 4, 3);   -- HP Pavilion
        
        RAISE NOTICE 'Se insertaron 12 items de cotización';
    ELSE
        RAISE NOTICE 'La tabla quote_item ya tiene datos, se omite la inserción';
    END IF;
END $$;

-- 5. METAS DE VENTAS
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM sales_goal LIMIT 1) THEN
        INSERT INTO sales_goal (employee_id, branch_id, period_type, start_date, end_date, target_amount, creation_date, created_by_user_id) VALUES
        -- Metas mensuales por empleado
        (1, NULL, 'MONTHLY', '2024-11-01', '2024-11-30', 50000000.00, NOW(), 1),
        (2, NULL, 'MONTHLY', '2024-11-01', '2024-11-30', 45000000.00, NOW(), 1),
        (3, NULL, 'MONTHLY', '2024-11-01', '2024-11-30', 40000000.00, NOW(), 1),
        (5, NULL, 'MONTHLY', '2024-11-01', '2024-11-30', 38000000.00, NOW(), 1),
        (6, NULL, 'MONTHLY', '2024-11-01', '2024-11-30', 48000000.00, NOW(), 1),
        -- Metas trimestrales por sucursal
        (NULL, 1, 'QUARTERLY', '2024-10-01', '2024-12-31', 180000000.00, NOW(), 1),
        (NULL, 2, 'QUARTERLY', '2024-10-01', '2024-12-31', 200000000.00, NOW(), 1),
        (NULL, 3, 'QUARTERLY', '2024-10-01', '2024-12-31', 150000000.00, NOW(), 1),
        (NULL, 5, 'QUARTERLY', '2024-10-01', '2024-12-31', 175000000.00, NOW(), 1),
        -- Metas anuales por sucursal
        (NULL, 1, 'YEARLY', '2024-01-01', '2024-12-31', 650000000.00, NOW(), 1),
        (NULL, 2, 'YEARLY', '2024-01-01', '2024-12-31', 750000000.00, NOW(), 1),
        (NULL, 3, 'YEARLY', '2024-01-01', '2024-12-31', 550000000.00, NOW(), 1),
        -- Meta anual por empleado (vendedor estrella)
        (2, NULL, 'YEARLY', '2024-01-01', '2024-12-31', 550000000.00, NOW(), 1);
        
        RAISE NOTICE 'Se insertaron 13 metas de ventas';
    ELSE
        RAISE NOTICE 'La tabla sales_goal ya tiene datos, se omite la inserción';
    END IF;
END $$;

-- Verificar cantidad de registros insertados en los nuevos modelos
SELECT 'Asignaciones' as tabla, COUNT(*) as registros FROM assignment
UNION ALL SELECT 'Cotizaciones', COUNT(*) FROM quote
UNION ALL SELECT 'Líneas de Cotización', COUNT(*) FROM quotation_line
UNION ALL SELECT 'Items de Cotización', COUNT(*) FROM quote_item
UNION ALL SELECT 'Metas de Ventas', COUNT(*) FROM sales_goal
ORDER BY tabla;
