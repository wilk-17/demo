-- ============================================================
-- SCRIPT DE POBLACIÓN COMPLETA DE BASE DE DATOS
-- Sistema: Spring Boot - Automatización Industrial
-- Dataset: Abril - Septiembre 2025 (6 meses)
-- Base de datos: prueba2
-- Descripción: Población completa con datos realistas
--              ajustados a la estructura actual del proyecto
-- ============================================================

-- Iniciar transacción
BEGIN;

-- ============================================================
-- 1. ESTADOS (5 departamentos de Colombia)
-- ============================================================
INSERT INTO state (description, code) VALUES
('Cundinamarca', 'CUN'),
('Santander', 'SAN'),
('Antioquia', 'ANT'),
('Valle del Cauca', 'VAC'),
('Atlántico', 'ATL');

-- ============================================================
-- 2. CIUDADES (20 ciudades principales)
-- ============================================================
INSERT INTO city (description, code, state_id) VALUES
-- Cundinamarca (id=1)
('Bogotá', 'BOG', 1),
('Soacha', 'SOA', 1),
('Chía', 'CHI', 1),
('Zipaquirá', 'ZIP', 1),
-- Santander (id=2)
('Bucaramanga', 'BGA', 2),
('Floridablanca', 'FLA', 2),
('Girón', 'GIR', 2),
('Piedecuesta', 'PDC', 2),
-- Antioquia (id=3)
('Medellín', 'MED', 3),
('Envigado', 'ENV', 3),
('Bello', 'BEL', 3),
('Itagüí', 'ITA', 3),
-- Valle del Cauca (id=4)
('Cali', 'CLO', 4),
('Palmira', 'PAL', 4),
('Yumbo', 'YUM', 4),
('Buga', 'BUG', 4),
-- Atlántico (id=5)
('Barranquilla', 'BAQ', 5),
('Soledad', 'SOL', 5),
('Malambo', 'MAL', 5),
('Puerto Colombia', 'PTC', 5);

-- ============================================================
-- 3. ORGANIZACIONES (7 clientes empresariales)
-- ============================================================
INSERT INTO organization (historical_name, current_name) VALUES
('multiCont', 'multiCont'),
('Automatiza Andina SAS', 'Automatiza Andina SAS'),
('ControlTech SAS', 'ControlTech SAS'),
('Industrias del Norte SA', 'Industrias del Norte SA'),
('Vallepack LTDA', 'Vallepack LTDA'),
('Caribe Foods SA', 'Caribe Foods SA'),
('Metalúrgica Antioquia SAS', 'Metalúrgica Antioquia SAS');

-- ============================================================
-- 4. SUCURSALES (5 sucursales de multiCont)
-- ============================================================
INSERT INTO branch (organization_id, city_id) VALUES
(1, 1),  -- Bogotá
(1, 5),  -- Bucaramanga
(1, 9),  -- Medellín
(1, 13), -- Cali
(1, 17); -- Barranquilla

-- ============================================================
-- 5. PERSONAS (20 personas)
-- ============================================================
INSERT INTO person (dni, first_name, last_name, address, phone, city_id) VALUES
('CC3001', 'Ana', 'García', 'Cra 10 #1-23', '300200001', 1),
('CC3002', 'Bruno', 'Pineda', 'Cll 12 #3-45', '300200002', 5),
('CC3003', 'Carla', 'Mora', 'Cll 8 #9-10', '300200003', 9),
('CC3004', 'Diego', 'Luna', 'Cra 45 #12-34', '300200004', 13),
('CC3005', 'Elena', 'Suárez', 'Av 7 #98-11', '300200005', 17),
('CC3006', 'Felipe', 'Cruz', 'Mz 4 Cs 5', '300200006', 2),
('CC3007', 'Gloria', 'Vega', 'Cra 70 #20-30', '300200007', 6),
('CC3008', 'Hugo', 'Ríos', 'Cll 25 #4-55', '300200008', 10),
('CC3009', 'Irene', 'Quintero', 'Cll 30 #6-77', '300200009', 14),
('CC3010', 'Jorge', 'Nieto', 'Cra 15 #5-22', '300200010', 18),
('CC3011', 'Karen', 'Ortiz', 'Cll 72 #15-33', '300200011', 3),
('CC3012', 'Luis', 'Pardo', 'Cra 8 #14-50', '300200012', 7),
('CC3013', 'Marta', 'Rey', 'Cll 40 #9-21', '300200013', 11),
('CC3014', 'Nicolás', 'Soto', 'Av 13 #45-60', '300200014', 15),
('CC3015', 'Olga', 'Torres', 'Cra 9 #20-20', '300200015', 19),
('CC3016', 'Pablo', 'Uribe', 'Cll 12 #23-12', '300200016', 4),
('CC3017', 'Raquel', 'Valencia', 'Cra 22 #33-44', '300200017', 8),
('CC3018', 'Sergio', 'Weber', 'Cll 9 #10-11', '300200018', 12),
('CC3019', 'Tatiana', 'Ximénez', 'Cll 1 #1-1', '300200019', 16),
('CC3020', 'Ulises', 'Zárate', 'Cra 100 #50-60', '300200020', 20);

-- ============================================================
-- 6. ROLES (3 roles del sistema)
-- ============================================================
INSERT INTO role (name, description) VALUES
('ADMIN', 'Administrador del sistema con acceso total'),
('MANAGER', 'Gerente con permisos de supervisión y reportes'),
('SALES', 'Vendedor con permisos de cotizaciones y ventas');

-- ============================================================
-- 7. EMPLEADOS (10 empleados con estructura real)
-- ============================================================
INSERT INTO employee (first_name, last_name, email, phone, position, hire_date, salary, branch_id, status, creation_date, update_date) VALUES
('Ana', 'García', 'ana.garcia@multicont.com', '300200001', 'Vendedor Senior', '2024-01-15', 3500000.00, 1, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Bruno', 'Pineda', 'bruno.pineda@multicont.com', '300200002', 'Vendedor', '2024-02-01', 3000000.00, 1, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Carla', 'Mora', 'carla.mora@multicont.com', '300200003', 'Vendedor', '2024-03-10', 3000000.00, 1, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Diego', 'Luna', 'diego.luna@multicont.com', '300200004', 'Vendedor Senior', '2023-11-05', 3500000.00, 2, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Elena', 'Suárez', 'elena.suarez@multicont.com', '300200005', 'Vendedor', '2024-01-20', 3000000.00, 2, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Felipe', 'Cruz', 'felipe.cruz@multicont.com', '300200006', 'Gerente de Ventas', '2023-06-01', 4500000.00, 3, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Gloria', 'Vega', 'gloria.vega@multicont.com', '300200007', 'Gerente de Ventas', '2023-08-15', 4500000.00, 3, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Hugo', 'Ríos', 'hugo.rios@multicont.com', '300200008', 'Administrador', '2023-01-10', 5000000.00, 4, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Irene', 'Quintero', 'irene.quintero@multicont.com', '300200009', 'Vendedor', '2024-04-01', 3000000.00, 4, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Jorge', 'Nieto', 'jorge.nieto@multicont.com', '300200010', 'Vendedor Senior', '2023-09-20', 3500000.00, 5, 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ============================================================
-- 8. USUARIOS (8 usuarios - primeros 8 empleados)
-- ============================================================
INSERT INTO users (username, password, role_id) VALUES
('ana', '$2a$10$XnBBYaOvtmJYhZkHmEq7YO5c3zKxqE1sFGzKfLqU0EH8x.nFbXe8K', 3),
('bruno', '$2a$10$XnBBYaOvtmJYhZkHmEq7YO5c3zKxqE1sFGzKfLqU0EH8x.nFbXe8K', 3),
('carla', '$2a$10$XnBBYaOvtmJYhZkHmEq7YO5c3zKxqE1sFGzKfLqU0EH8x.nFbXe8K', 3),
('diego', '$2a$10$XnBBYaOvtmJYhZkHmEq7YO5c3zKxqE1sFGzKfLqU0EH8x.nFbXe8K', 3),
('elena', '$2a$10$XnBBYaOvtmJYhZkHmEq7YO5c3zKxqE1sFGzKfLqU0EH8x.nFbXe8K', 3),
('felipe', '$2a$10$XnBBYaOvtmJYhZkHmEq7YO5c3zKxqE1sFGzKfLqU0EH8x.nFbXe8K', 2),
('gloria', '$2a$10$XnBBYaOvtmJYhZkHmEq7YO5c3zKxqE1sFGzKfLqU0EH8x.nFbXe8K', 2),
('hugo', '$2a$10$XnBBYaOvtmJYhZkHmEq7YO5c3zKxqE1sFGzKfLqU0EH8x.nFbXe8K', 1);

-- ============================================================
-- 9. PERMISOS (10 permisos del sistema)
-- ============================================================
INSERT INTO permission (name, description, module, created_at) VALUES
('READ_REPORTS', 'Leer reportes del sistema', 'REPORTS', CURRENT_TIMESTAMP),
('WRITE_REPORTS', 'Crear y modificar reportes', 'REPORTS', CURRENT_TIMESTAMP),
('READ_QUOTES', 'Ver cotizaciones', 'SALES', CURRENT_TIMESTAMP),
('WRITE_QUOTES', 'Crear y editar cotizaciones', 'SALES', CURRENT_TIMESTAMP),
('DELETE_QUOTES', 'Eliminar cotizaciones', 'SALES', CURRENT_TIMESTAMP),
('APPROVE_ORDERS', 'Aprobar órdenes de venta', 'SALES', CURRENT_TIMESTAMP),
('MANAGE_INVENTORY', 'Gestionar inventario', 'INVENTORY', CURRENT_TIMESTAMP),
('MANAGE_USERS', 'Administrar usuarios', 'ADMIN', CURRENT_TIMESTAMP),
('MANAGE_ROLES', 'Administrar roles y permisos', 'ADMIN', CURRENT_TIMESTAMP),
('ADMIN_ALL', 'Acceso total al sistema', 'ADMIN', CURRENT_TIMESTAMP);

-- ============================================================
-- 10. ROLE_PERMISSION (Relación ManyToMany)
-- ============================================================
INSERT INTO role_permission (role_id, permission_id) VALUES
-- ADMIN (role_id=1) tiene todos los permisos
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
-- MANAGER (role_id=2) tiene permisos de reportes y aprobación
(2, 1), (2, 2), (2, 3), (2, 6), (2, 7),
-- SALES (role_id=3) tiene permisos de ventas
(3, 3), (3, 4), (3, 7);

-- ============================================================
-- ============================================================
-- 11. CATEGORÍAS DE ITEMS (6 categorías de productos industriales)
-- ============================================================
INSERT INTO item_category (name) VALUES
('Controladores y PLCs'),
('Sensores y Detectores'),
('Variadores de Frecuencia'),
('Interfaces Humano-Máquina (HMI)'),
('Componentes de Potencia'),
('Sistemas de Pesaje y Medición');

-- ============================================================
-- 12. MARCAS (6 fabricantes de equipos industriales)
-- ============================================================
INSERT INTO brand (name, description, creation_date) VALUES
('Omron', 'Fabricante japonés de componentes de automatización industrial', CURRENT_TIMESTAMP),
('ING Multicontrol', 'Empresa alemana especializada en control industrial', CURRENT_TIMESTAMP),
('Gefran', 'Fabricante italiano de sensores y controladores', CURRENT_TIMESTAMP),
('Weidmüller', 'Proveedor alemán de soluciones de conectividad industrial', CURRENT_TIMESTAMP),
('Rice-Lake', 'Empresa estadounidense de sistemas de pesaje industrial', CURRENT_TIMESTAMP),
('Optec', 'Empresa colombiana de sensores y componentes industriales', CURRENT_TIMESTAMP);

-- ============================================================
-- 13. INVENTARIO (30 items - 5 por marca para simplificar)
-- ============================================================

-- OMRON (5 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id, category_id) VALUES
('OMR-PLC-NX1P2', 'Controlador PLC Omron NX1P2', 4500000.00, 10, 1, 1),
('OMR-SEN-E3Z', 'Sensor fotoeléctrico Omron E3Z', 180000.00, 50, 1, 2),
('OMR-INV-A1000', 'Variador Omron A1000', 6000000.00, 5, 1, 3),
('OMR-HMI-NA5', 'HMI Omron NA5 7"', 2800000.00, 15, 1, 4),
('OMR-IO-NX', 'Módulo I/O Omron NX', 850000.00, 20, 1, 1);

-- ING MULTICONTROL (5 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id, category_id) VALUES
('ING-ARR-START', 'Arrancador suave ING Multicontrol', 2750000.00, 12, 2, 5),
('ING-CON-24V', 'Fuente de poder 24V ING Multicontrol', 380000.00, 35, 2, 5),
('ING-PLC-MC200', 'PLC ING Multicontrol MC200', 3800000.00, 10, 2, 1),
('ING-HMI-MC7', 'HMI 7" ING Multicontrol', 1900000.00, 18, 2, 4),
('ING-VFD-MC500', 'Variador ING Multicontrol MC500', 5200000.00, 7, 2, 3);

-- GEFRAN (5 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id, category_id) VALUES
('GEF-TEMP-600', 'Controlador de temperatura Gefran 600', 1350000.00, 15, 3, 1),
('GEF-INV-ADV', 'Inversor de frecuencia Gefran ADV', 6500000.00, 6, 3, 3),
('GEF-TRANS-LIN', 'Transductor lineal Gefran', 2100000.00, 10, 3, 2),
('GEF-SSR-GQ', 'Relé de estado sólido Gefran GQ', 285000.00, 35, 3, 5),
('GEF-DRIVE-AX', 'Servo drive Gefran AX', 7800000.00, 5, 3, 3);

-- WEIDMÜLLER (5 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id, category_id) VALUES
('WEI-BOR-TER', 'Bornera Weidmüller Terminal', 50000.00, 200, 4, 5),
('WEI-SSR-IO', 'Módulo IO Weidmüller SSR', 250000.00, 40, 4, 1),
('WEI-PSU-24', 'Fuente 24V Weidmüller', 400000.00, 35, 4, 5),
('WEI-REL-TER', 'Relé interfaz Weidmüller', 85000.00, 60, 4, 5),
('WEI-SW-IND8', 'Switch industrial 8p Weidmüller', 1250000.00, 15, 4, 1);

-- RICE-LAKE (5 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id, category_id) VALUES
('RCL-BAL-IND', 'Indicador de pesaje Rice-Lake', 4000000.00, 8, 5, 6),
('RCL-CEL-CARGA', 'Celda de carga Rice-Lake', 1800000.00, 12, 5, 6),
('RCL-PES-PLC', 'Módulo de pesaje para PLC Rice-Lake', 3800000.00, 6, 5, 6),
('RCL-JBOX-4', 'Caja de conexiones 4 celdas Rice-Lake', 580000.00, 15, 5, 6),
('RCL-SCALE-PLT', 'Báscula de plataforma Rice-Lake', 5500000.00, 5, 5, 6);

-- OPTEC (5 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id, category_id) VALUES
('OPT-SEN-IND', 'Sensor inductivo Optec', 220000.00, 45, 6, 2),
('OPT-BARR-SEG', 'Barrera de seguridad Optec', 900000.00, 12, 6, 2),
('OPT-HMI-7', 'Panel HMI 7" Optec', 1200000.00, 15, 6, 4),
('OPT-PE-SENS', 'Sensor fotoeléctrico Optec', 195000.00, 50, 6, 2),
('OPT-IO-LINK', 'Módulo IO-Link Master Optec', 850000.00, 18, 6, 1);

-- ============================================================
-- 14. ASIGNACIONES (Asignaciones de inventario a empleados)
-- ============================================================
-- Assignment: employee_id, item_id, quantity, assigned_date, status ('ACTIVE'|'RETURNED'|'LOST'), creation_date
INSERT INTO assignment (employee_id, item_id, quantity, assigned_date, status, creation_date) VALUES
(1, 1, 1, '2024-01-15', 'ACTIVE', CURRENT_TIMESTAMP),  -- Ana usa PLC Omron
(1, 6, 2, '2024-01-15', 'ACTIVE', CURRENT_TIMESTAMP),  -- Ana usa 2 módulos ING
(2, 11, 1, '2024-01-20', 'ACTIVE', CURRENT_TIMESTAMP), -- Bruno usa sensor Gefran
(3, 16, 1, '2024-02-01', 'ACTIVE', CURRENT_TIMESTAMP), -- Carla usa terminal Weidmüller
(4, 21, 1, '2024-02-10', 'ACTIVE', CURRENT_TIMESTAMP), -- Diego usa indicador Rice-Lake
(5, 26, 2, '2024-02-15', 'ACTIVE', CURRENT_TIMESTAMP), -- Elena usa sensores Optec
(6, 2, 1, '2024-01-10', 'RETURNED', CURRENT_TIMESTAMP),-- Felipe devolvió CPU Omron
(7, 7, 1, '2024-01-25', 'ACTIVE', CURRENT_TIMESTAMP),  -- Gloria usa fuente ING
(8, 12, 1, '2024-02-05', 'ACTIVE', CURRENT_TIMESTAMP), -- Hugo usa controlador Gefran
(9, 17, 1, '2024-02-20', 'ACTIVE', CURRENT_TIMESTAMP); -- Irene usa módulo Weidmüller

-- ============================================================
-- 15. COTIZACIONES (6 cotizaciones)
-- ============================================================
INSERT INTO quote (customer_name, date, total, employee_id) VALUES
('Automatiza Andina SAS', '2025-04-08', 5200000.00, 1),
('ControlTech SAS', '2025-04-15', 18300000.00, 4),
('Industrias del Norte SA', '2025-05-03', 15700000.00, 6),
('Vallepack LTDA', '2025-06-05', 10400000.00, 8),
('Caribe Foods SA', '2025-07-18', 16900000.00, 10),
('Metalúrgica Antioquia SAS', '2025-08-22', 13750000.00, 6);

-- ============================================================
-- 16. QUOTE ITEMS (items de las cotizaciones usando item_id)
-- ============================================================
INSERT INTO quote_item (quote_id, item_id, quantity) VALUES
-- Quote 1 (Ana)
(1, 2, 10),  -- OMR-SEN-E3Z
(1, 18, 5),  -- WEI-PSU-24
(1, 26, 5),  -- OPT-SEN-IND
-- Quote 2 (Diego) - ACCEPTED
(2, 1, 2),   -- OMR-PLC-NX1P2
(2, 11, 3),  -- GEF-TEMP-600
-- Quote 3 (Felipe)
(3, 8, 1),   -- ING-PLC-MC200
(3, 12, 1),  -- GEF-INV-ADV
(3, 21, 1),  -- RCL-BAL-IND
-- Quote 4 (Hugo)
(4, 16, 80), -- WEI-BOR-TER
(4, 2, 8),   -- OMR-SEN-E3Z
-- Quote 5 (Jorge) - ACCEPTED
(5, 23, 1),  -- RCL-PES-PLC
(5, 3, 1),   -- OMR-INV-A1000
(5, 28, 1),  -- OPT-HMI-7
-- Quote 6 (Felipe)
(6, 6, 2),   -- ING-ARR-START
(6, 18, 5);  -- WEI-PSU-24

-- ============================================================
-- 17. QUOTATION LINES (líneas detalladas de cotizaciones)
-- ============================================================
INSERT INTO quotation_line (quote_id, description, quantity, price, item_id) VALUES
(2, 'Controladores PLC Omron', 2, 4500000.00, 1),
(2, 'Controladores de temperatura Gefran', 3, 1350000.00, 11),
(5, 'Módulo de pesaje Rice-Lake', 1, 3800000.00, 23),
(5, 'Variador Omron', 1, 6000000.00, 3),
(5, 'HMI Optec', 1, 1200000.00, 28);

-- ============================================================
-- 18. SALES ORDERS (2 órdenes de venta)
-- ============================================================
INSERT INTO sales_order (customer_name, order_date, total, status, employee_id, quote_id, creation_date, update_date) VALUES
('ControlTech SAS', '2025-04-20', 18300000.00, 'completed', 4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),   -- SO1 de Quote 2 (Diego)
('Caribe Foods SA', '2025-07-20', 16900000.00, 'pending', 10, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);  -- SO2 de Quote 5 (Jorge)

-- ============================================================
-- 19. SALES ORDER ITEMS (items de órdenes usando item_id)
-- ============================================================
INSERT INTO sales_order_item (sales_order_id, item_id, quantity) VALUES
-- SO1 items
(1, 1, 2),   -- OMR-PLC-NX1P2
(1, 11, 3),  -- GEF-TEMP-600
-- SO2 items
(2, 23, 1),  -- RCL-PES-PLC
(2, 3, 1),   -- OMR-INV-A1000
(2, 28, 1);  -- OPT-HMI-7

-- ============================================================
-- 20. FACTURAS (6 facturas)
-- ============================================================
INSERT INTO invoice (customer_name, invoice_date, total, sales_order_id, employee_id, creation_date, update_date) VALUES
('ControlTech SAS', '2025-04-21', 18300000.00, 1, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Caribe Foods SA', '2025-07-21', 16900000.00, 2, 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Automatiza Andina SAS', '2025-04-30', 4900000.00, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Vallepack LTDA', '2025-07-08', 10400000.00, 2, 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Industrias del Norte SA', '2025-08-11', 15700000.00, 2, 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Metalúrgica Antioquia SAS', '2025-09-17', 13750000.00, 2, 7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ============================================================
-- 21. INVOICE ITEMS (items de facturas usando item_id y price)
-- ============================================================
INSERT INTO invoice_item (invoice_id, item_id, quantity, price) VALUES
-- Invoice 1 (de SO1 - Diego)
(1, 1, 2, 4500000.00),   -- OMR-PLC-NX1P2
(1, 11, 3, 1350000.00),  -- GEF-TEMP-600
-- Invoice 2 (de SO2 - Jorge)
(2, 23, 1, 3800000.00),  -- RCL-PES-PLC
(2, 3, 1, 6000000.00),   -- OMR-INV-A1000
(2, 28, 1, 1200000.00),  -- OPT-HMI-7
-- Invoice 3 (directa Ana)
(3, 2, 10, 180000.00),   -- OMR-SEN-E3Z
(3, 18, 5, 400000.00),   -- WEI-PSU-24
(3, 26, 5, 220000.00),   -- OPT-SEN-IND
-- Invoice 4 (directa Hugo)
(4, 16, 80, 50000.00),   -- WEI-BOR-TER
(4, 2, 8, 180000.00),    -- OMR-SEN-E3Z
-- Invoice 5 (directa Felipe)
(5, 8, 1, 3800000.00),   -- ING-PLC-MC200
(5, 12, 1, 6500000.00),  -- GEF-INV-ADV
(5, 21, 1, 4000000.00),  -- RCL-BAL-IND
-- Invoice 6 (directa Gloria)
(6, 6, 2, 2750000.00),   -- ING-ARR-START
(6, 18, 5, 400000.00);   -- WEI-PSU-24

-- ============================================================
-- 22. METAS DE VENTAS (6 metas - mensuales y trimestrales)
-- ============================================================
-- SalesGoal: employee_id, branch_id, period_type, start_date, end_date, target_amount, creation_date, created_by_user_id
INSERT INTO sales_goal (employee_id, branch_id, period_type, start_date, end_date, target_amount, creation_date, created_by_user_id) VALUES
-- Metas mensuales por empleado (vendedores)
(1, NULL, 'MONTHLY', '2025-01-01', '2025-01-31', 15000000.00, CURRENT_TIMESTAMP, 1),  -- Ana - Enero
(4, NULL, 'MONTHLY', '2025-02-01', '2025-02-28', 20000000.00, CURRENT_TIMESTAMP, 1),  -- Diego - Febrero
(6, NULL, 'MONTHLY', '2025-03-01', '2025-03-31', 18000000.00, CURRENT_TIMESTAMP, 1),  -- Felipe - Marzo
-- Metas trimestrales por sucursal
(NULL, 1, 'QUARTERLY', '2025-01-01', '2025-03-31', 80000000.00, CURRENT_TIMESTAMP, 1), -- Bogotá Q1
(NULL, 2, 'QUARTERLY', '2025-01-01', '2025-03-31', 60000000.00, CURRENT_TIMESTAMP, 1), -- Bucaramanga Q1
(NULL, 3, 'QUARTERLY', '2025-04-01', '2025-06-30', 75000000.00, CURRENT_TIMESTAMP, 1); -- Medellín Q2

-- ============================================================
-- 23. ACTIVITY LOG (10 registros de auditoría)
-- ============================================================
-- ActivityLog: user_id, action, entity, entity_id, description, ip_address, created_at
INSERT INTO activity_log (user_id, action, entity, entity_id, description, ip_address, created_at) VALUES
(1, 'CREATE', 'Quote', 1, 'Creó cotización para Automatiza Andina SAS', '192.168.1.10', CURRENT_TIMESTAMP - INTERVAL '10 days'),
(1, 'UPDATE', 'Quote', 1, 'Actualizó total de cotización', '192.168.1.10', CURRENT_TIMESTAMP - INTERVAL '9 days'),
(4, 'CREATE', 'Quote', 2, 'Creó cotización para ControlTech SAS', '192.168.1.15', CURRENT_TIMESTAMP - INTERVAL '8 days'),
(4, 'CREATE', 'SalesOrder', 1, 'Convirtió cotización a orden de venta', '192.168.1.15', CURRENT_TIMESTAMP - INTERVAL '7 days'),
(4, 'CREATE', 'Invoice', 1, 'Generó factura para ControlTech SAS', '192.168.1.15', CURRENT_TIMESTAMP - INTERVAL '6 days'),
(6, 'CREATE', 'Quote', 3, 'Creó cotización para Industrias del Norte', '192.168.1.20', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(8, 'CREATE', 'Quote', 4, 'Creó cotización para Vallepack LTDA', '192.168.1.25', CURRENT_TIMESTAMP - INTERVAL '4 days'),
(1, 'UPDATE', 'Employee', 3, 'Actualizó información de empleado', '192.168.1.10', CURRENT_TIMESTAMP - INTERVAL '3 days'),
(1, 'CREATE', 'SalesGoal', 1, 'Estableció meta de ventas para enero', '192.168.1.10', CURRENT_TIMESTAMP - INTERVAL '2 days'),
(10, 'CREATE', 'Quote', 5, 'Creó cotización para Caribe Foods SA', '192.168.1.30', CURRENT_TIMESTAMP - INTERVAL '1 day');

-- ============================================================
-- COMMIT
-- ============================================================
COMMIT;

-- ============================================================
-- CONSULTAS DE VERIFICACIÓN
-- ============================================================

SELECT 'Estados' AS tabla, COUNT(*) AS total FROM state
UNION ALL
SELECT 'Ciudades', COUNT(*) FROM city
UNION ALL
SELECT 'Organizaciones', COUNT(*) FROM organization
UNION ALL
SELECT 'Sucursales', COUNT(*) FROM branch
UNION ALL
SELECT 'Personas', COUNT(*) FROM person
UNION ALL
SELECT 'Empleados', COUNT(*) FROM employee
UNION ALL
SELECT 'Usuarios', COUNT(*) FROM users
UNION ALL
SELECT 'Roles', COUNT(*) FROM role
UNION ALL
SELECT 'Permisos', COUNT(*) FROM permission
UNION ALL
SELECT 'Roles-Permisos', COUNT(*) FROM role_permission
UNION ALL
SELECT 'Categorías Items', COUNT(*) FROM item_category
UNION ALL
SELECT 'Marcas', COUNT(*) FROM brand
UNION ALL
SELECT 'Items Inventario', COUNT(*) FROM inventory_item
UNION ALL
SELECT 'Asignaciones', COUNT(*) FROM assignment
UNION ALL
SELECT 'Cotizaciones', COUNT(*) FROM quote
UNION ALL
SELECT 'Quote Items', COUNT(*) FROM quote_item
UNION ALL
SELECT 'Quotation Lines', COUNT(*) FROM quotation_line
UNION ALL
SELECT 'Órdenes Venta', COUNT(*) FROM sales_order
UNION ALL
SELECT 'Sales Order Items', COUNT(*) FROM sales_order_item
UNION ALL
SELECT 'Facturas', COUNT(*) FROM invoice
UNION ALL
SELECT 'Invoice Items', COUNT(*) FROM invoice_item
UNION ALL
SELECT 'Metas de Ventas', COUNT(*) FROM sales_goal
UNION ALL
SELECT 'Activity Logs', COUNT(*) FROM activity_log
ORDER BY tabla;

-- Total facturado
SELECT 
    TO_CHAR(SUM(total), 'FM$999,999,999') AS total_facturado,
    COUNT(*) AS cantidad_facturas
FROM invoice;

-- Ventas por empleado
SELECT 
    e.id,
    e.first_name || ' ' || e.last_name AS empleado,
    COUNT(i.id) AS facturas,
    TO_CHAR(SUM(i.total), 'FM$999,999,999') AS total_vendido
FROM employee e
LEFT JOIN invoice i ON i.employee_id = e.id
GROUP BY e.id, e.first_name, e.last_name
ORDER BY SUM(i.total) DESC NULLS LAST;

-- Ventas por ciudad/sucursal
SELECT 
    c.description AS ciudad,
    COUNT(DISTINCT i.id) AS facturas,
    TO_CHAR(SUM(i.total), 'FM$999,999,999') AS total_vendido
FROM branch b
JOIN city c ON b.city_id = c.id
JOIN employee emp ON emp.branch_id = b.id
JOIN invoice i ON i.employee_id = emp.id
GROUP BY c.description
ORDER BY SUM(i.total) DESC;

-- Productos más vendidos
SELECT 
    inv.name,
    inv.description,
    SUM(ii.quantity) AS unidades_vendidas,
    TO_CHAR(SUM(ii.quantity * ii.price), 'FM$999,999,999') AS valor_total
FROM invoice_item ii
JOIN inventory_item inv ON ii.item_id = inv.id
GROUP BY inv.id, inv.name, inv.description
ORDER BY SUM(ii.quantity * ii.price) DESC
LIMIT 10;
