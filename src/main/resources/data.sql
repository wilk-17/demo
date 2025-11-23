-- Script para poblar la base de datos con datos de prueba
-- Ejecutar en PostgreSQL

-- Limpiar datos existentes (opcional)
-- TRUNCATE TABLE invoice_item, sales_order_item, invoice, sales_order, employee, inventory_item, branch, person, city, state, brand, item_category, users, role, organization CASCADE;

-- 1. ROLES
INSERT INTO role (name) VALUES 
('Administrador'),
('Gerente'),
('Vendedor'),
('Cajero'),
('Almacenero');

-- 2. USUARIOS
INSERT INTO users (username, password, role_id) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhCy', 1), -- password: admin123
('gerente1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhCy', 2), -- password: admin123
('vendedor1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhCy', 3),
('vendedor2', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhCy', 3),
('cajero1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhCy', 4),
('almacenero1', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhCy', 5);

-- 3. ESTADOS (DEPARTAMENTOS)
INSERT INTO state (description, code) VALUES
('Antioquia', 'ANT'),
('Cundinamarca', 'CUN'),
('Valle del Cauca', 'VAC'),
('Atlántico', 'ATL'),
('Santander', 'SAN'),
('Bolívar', 'BOL'),
('Quindío', 'QUI'),
('Risaralda', 'RIS');

-- 4. CIUDADES
INSERT INTO city (description, code, state_id) VALUES
-- Antioquia
('Medellín', 'MED', 1),
('Envigado', 'ENV', 1),
('Bello', 'BEL', 1),
-- Cundinamarca
('Bogotá', 'BOG', 2),
('Soacha', 'SOA', 2),
('Chía', 'CHI', 2),
-- Valle del Cauca
('Cali', 'CAL', 3),
('Palmira', 'PAL', 3),
('Buenaventura', 'BUE', 3),
-- Atlántico
('Barranquilla', 'BAQ', 4),
('Soledad', 'SOL', 4),
-- Santander
('Bucaramanga', 'BUC', 5),
('Floridablanca', 'FLO', 5),
-- Bolívar
('Cartagena', 'CTG', 6),
-- Quindío
('Armenia', 'ARM', 7),
-- Risaralda
('Pereira', 'PER', 8);

-- 5. ORGANIZACIONES
INSERT INTO organization (historical_name, current_name) VALUES
('TechStore S.A.', 'TechStore Colombia'),
('ElectroMundo Ltda', 'ElectroMundo'),
('Digital House', 'Digital House Colombia');

-- 6. SUCURSALES
INSERT INTO branch (organization_id, city_id) VALUES
-- TechStore
(1, 1),  -- Medellín
(1, 4),  -- Bogotá
(1, 7),  -- Cali
(1, 10), -- Barranquilla
-- ElectroMundo
(2, 4),  -- Bogotá
(2, 1),  -- Medellín
(2, 12), -- Bucaramanga
-- Digital House
(3, 4),  -- Bogotá
(3, 7);  -- Cali

-- 7. PERSONAS
INSERT INTO person (dni, first_name, last_name, address, phone, city_id) VALUES
('1234567890', 'Juan', 'Pérez García', 'Calle 50 #30-20', '3001234567', 1),
('0987654321', 'María', 'Rodríguez López', 'Carrera 15 #80-45', '3109876543', 4),
('1122334455', 'Carlos', 'Martínez Silva', 'Avenida 6 #25-10', '3201122334', 7),
('5544332211', 'Ana', 'González Ramírez', 'Calle 72 #10-34', '3145544332', 4),
('6677889900', 'Luis', 'Hernández Castro', 'Carrera 43A #12-56', '3176677889', 1),
('9988776655', 'Laura', 'Díaz Morales', 'Calle 100 #15-23', '3009988776', 4),
('1231231234', 'Pedro', 'López Vargas', 'Carrera 7 #45-67', '3121231234', 12),
('4564564567', 'Sofia', 'Torres Mejía', 'Calle 85 #20-30', '3154564567', 7);

-- 8. EMPLEADOS
INSERT INTO employee (first_name, last_name, email, phone, position, hire_date, salary, branch_id, status, creation_date, update_date) VALUES
('Juan', 'Pérez García', 'juan.perez@techstore.com', '3001234567', 'Gerente de Tienda', '2023-01-15', 4500000.00, 1, 'active', NOW(), NOW()),
('María', 'Rodríguez López', 'maria.rodriguez@techstore.com', '3109876543', 'Vendedor Senior', '2023-03-20', 2800000.00, 2, 'active', NOW(), NOW()),
('Carlos', 'Martínez Silva', 'carlos.martinez@techstore.com', '3201122334', 'Vendedor', '2023-06-10', 2500000.00, 3, 'active', NOW(), NOW()),
('Ana', 'González Ramírez', 'ana.gonzalez@electromundo.com', '3145544332', 'Gerente Regional', '2022-08-01', 5500000.00, 5, 'active', NOW(), NOW()),
('Luis', 'Hernández Castro', 'luis.hernandez@electromundo.com', '3176677889', 'Vendedor', '2023-02-14', 2600000.00, 6, 'active', NOW(), NOW()),
('Laura', 'Díaz Morales', 'laura.diaz@digitalhouse.com', '3009988776', 'Gerente de Tienda', '2023-04-05', 4200000.00, 8, 'active', NOW(), NOW()),
('Pedro', 'López Vargas', 'pedro.lopez@electromundo.com', '3121231234', 'Cajero', '2023-09-01', 2200000.00, 7, 'active', NOW(), NOW()),
('Sofia', 'Torres Mejía', 'sofia.torres@techstore.com', '3154564567', 'Vendedor', '2023-07-20', 2500000.00, 3, 'active', NOW(), NOW());

-- 9. MARCAS
INSERT INTO brand (name, description, creation_date) VALUES
('Samsung', 'Electrónica y tecnología surcoreana', NOW()),
('Apple', 'Tecnología premium y dispositivos iOS', NOW()),
('LG', 'Electrodomésticos y electrónica', NOW()),
('Sony', 'Electrónica de consumo y entretenimiento', NOW()),
('HP', 'Computadoras y equipos de oficina', NOW()),
('Dell', 'Computadoras empresariales y personales', NOW()),
('Lenovo', 'Computadoras y dispositivos móviles', NOW()),
('Xiaomi', 'Smartphones y dispositivos inteligentes', NOW()),
('Huawei', 'Telecomunicaciones y smartphones', NOW()),
('Asus', 'Computadoras y componentes', NOW());

-- 10. CATEGORÍAS DE ITEMS
INSERT INTO item_category (name) VALUES
('Smartphones'),
('Laptops'),
('Tablets'),
('Televisores'),
('Audífonos'),
('Accesorios'),
('Computadoras de Escritorio'),
('Smartwatches'),
('Cámaras'),
('Consolas de Videojuegos');

-- 11. ITEMS DE INVENTARIO
INSERT INTO inventory_item (name, description, quantity, price, category_id, brand_id) VALUES
('Samsung Galaxy S23', 'Smartphone flagship de Samsung 2023', 50, 3299000.00, 1, 1),
('iPhone 14 Pro', 'iPhone de última generación con ProMotion', 30, 5499000.00, 1, 2),
('MacBook Pro 14"', 'Laptop profesional con chip M2', 20, 8999000.00, 2, 2),
('HP Pavilion 15', 'Laptop para uso general y estudiantes', 45, 2499000.00, 2, 5),
('Samsung Galaxy Tab S8', 'Tablet Android premium', 35, 2199000.00, 3, 1),
('iPad Air', 'Tablet iOS de gama media-alta', 25, 2899000.00, 3, 2),
('LG OLED 55"', 'Televisor OLED 4K 55 pulgadas', 15, 4599000.00, 4, 3),
('Sony Bravia 65"', 'Televisor LED 4K 65 pulgadas', 12, 3999000.00, 4, 4),
('AirPods Pro', 'Audífonos inalámbricos con cancelación de ruido', 60, 999000.00, 5, 2),
('Samsung Buds 2', 'Audífonos inalámbricos de Samsung', 70, 449000.00, 5, 1),
('Dell XPS 13', 'Laptop ultradelgada premium', 18, 5499000.00, 2, 6),
('Lenovo ThinkPad X1', 'Laptop empresarial de alta gama', 22, 6299000.00, 2, 7),
('Xiaomi Redmi Note 12', 'Smartphone de gama media', 80, 899000.00, 1, 8),
('Apple Watch Series 8', 'Smartwatch de Apple', 40, 1999000.00, 8, 2),
('Sony Alpha A7', 'Cámara mirrorless profesional', 10, 8499000.00, 9, 4);

-- 12. ÓRDENES DE VENTA
INSERT INTO sales_order (customer_name, order_date, total, status, employee_id, quote_id, creation_date, update_date) VALUES
('Juan Pérez García', '2024-10-01', 8998000.00, 'completed', 1, NULL, NOW(), NOW()),
('María Rodríguez López', '2024-10-05', 5498000.00, 'completed', 2, NULL, NOW(), NOW()),
('Carlos Martínez Silva', '2024-10-08', 2199000.00, 'pending', 3, NULL, NOW(), NOW()),
('Ana González Ramírez', '2024-10-10', 4599000.00, 'completed', 5, NULL, NOW(), NOW()),
('Luis Hernández Castro', '2024-10-12', 1448000.00, 'processing', 1, NULL, NOW(), NOW()),
('Laura Díaz Morales', '2024-10-15', 11998000.00, 'completed', 6, NULL, NOW(), NOW());

-- 13. ITEMS DE ORDEN DE VENTA
INSERT INTO sales_order_item (sales_order_id, item_id, quantity) VALUES
-- Orden 1
(1, 3, 1),  -- MacBook Pro
-- Orden 2
(2, 2, 1),  -- iPhone 14 Pro
-- Orden 3
(3, 5, 1),  -- Galaxy Tab S8
-- Orden 4
(4, 7, 1),  -- LG OLED 55"
-- Orden 5
(5, 9, 1),  -- AirPods Pro
(5, 10, 1), -- Samsung Buds
-- Orden 6
(6, 11, 1), -- Dell XPS
(6, 14, 3); -- Apple Watch (3 unidades)

-- 14. FACTURAS
INSERT INTO invoice (customer_name, invoice_date, total, employee_id, sales_order_id, creation_date, update_date) VALUES
('Juan Pérez García', '2024-10-01', 8998000.00, 1, 1, NOW(), NOW()),
('María Rodríguez López', '2024-10-05', 5498000.00, 2, 2, NOW(), NOW()),
('Ana González Ramírez', '2024-10-10', 4599000.00, 5, 4, NOW(), NOW()),
('Laura Díaz Morales', '2024-10-15', 11998000.00, 6, 6, NOW(), NOW());

-- 15. ITEMS DE FACTURA
INSERT INTO invoice_item (invoice_id, item_id, quantity, price) VALUES
-- Factura 1
(1, 3, 1, 8998000.00),
-- Factura 2
(2, 2, 1, 5498000.00),
-- Factura 3
(3, 7, 1, 4599000.00),
-- Factura 4
(4, 11, 1, 5499000.00),
(4, 14, 3, 1999000.00);

-- 16. ASIGNACIONES DE ITEMS A EMPLEADOS
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

-- 17. COTIZACIONES
INSERT INTO quote (customer_name, date, total, employee_id) VALUES
('Empresa ABC S.A.S', '2024-10-20', 45000000.00, 1),
('Colegio San José', '2024-10-22', 12500000.00, 2),
('Universidad Nacional', '2024-10-25', 89970000.00, 4),
('Hotel Estelar', '2024-10-28', 23000000.00, 6),
('Clínica del Norte', '2024-10-30', 15500000.00, 3),
('Gobierno Municipal', '2024-11-01', 67500000.00, 5);

-- 18. LÍNEAS DE COTIZACIÓN (Detalladas)
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

-- 19. ITEMS DE COTIZACIÓN (Simple - Alternativo)
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

-- 20. METAS DE VENTAS
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

-- Verificar cantidad de registros insertados
SELECT 'Roles' as tabla, COUNT(*) as registros FROM role
UNION ALL SELECT 'Usuarios', COUNT(*) FROM users
UNION ALL SELECT 'Estados', COUNT(*) FROM state
UNION ALL SELECT 'Ciudades', COUNT(*) FROM city
UNION ALL SELECT 'Organizaciones', COUNT(*) FROM organization
UNION ALL SELECT 'Sucursales', COUNT(*) FROM branch
UNION ALL SELECT 'Personas', COUNT(*) FROM person
UNION ALL SELECT 'Empleados', COUNT(*) FROM employee
UNION ALL SELECT 'Marcas', COUNT(*) FROM brand
UNION ALL SELECT 'Categorías', COUNT(*) FROM item_category
UNION ALL SELECT 'Items Inventario', COUNT(*) FROM inventory_item
UNION ALL SELECT 'Órdenes de Venta', COUNT(*) FROM sales_order
UNION ALL SELECT 'Items Orden Venta', COUNT(*) FROM sales_order_item
UNION ALL SELECT 'Facturas', COUNT(*) FROM invoice
UNION ALL SELECT 'Items Factura', COUNT(*) FROM invoice_item
UNION ALL SELECT 'Asignaciones', COUNT(*) FROM assignment
UNION ALL SELECT 'Cotizaciones', COUNT(*) FROM quote
UNION ALL SELECT 'Líneas de Cotización', COUNT(*) FROM quotation_line
UNION ALL SELECT 'Items de Cotización', COUNT(*) FROM quote_item
UNION ALL SELECT 'Metas de Ventas', COUNT(*) FROM sales_goal;
