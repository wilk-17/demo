-- ============================================================
-- SCRIPT DE POBLACIÓN COMPLETA DE BASE DE DATOS
-- Sistema: Spring Boot - Automatización Industrial
-- Dataset: Abril - Septiembre 2025 (6 meses)
-- Base de datos: prueba2
-- Descripción: Población completa con datos realistas para
--              todas las entidades del sistema multiCont
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
-- 4. SUCURSALES (5 sucursales de multiCont en ciudades principales)
-- ============================================================
INSERT INTO branch (organization_id, city_id) VALUES
(1, 1),  -- Bogotá
(1, 5),  -- Bucaramanga
(1, 9),  -- Medellín
(1, 13), -- Cali
(1, 17); -- Barranquilla

-- ============================================================
-- 5. PERSONAS (20 personas para empleados y clientes)
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
-- 7. EMPLEADOS (10 empleados asignados a sucursales)
-- ============================================================
INSERT INTO employee (first_name, last_name, email, phone, position, hire_date, salary, branch_id, status) VALUES
('Ana', 'García', 'ana.garcia@multicont.com', '300200001', 'Vendedor Senior', '2024-01-15', 3500000.00, 1, 'active'),
('Bruno', 'Pineda', 'bruno.pineda@multicont.com', '300200002', 'Vendedor', '2024-02-01', 3000000.00, 1, 'active'),
('Carla', 'Mora', 'carla.mora@multicont.com', '300200003', 'Vendedor', '2024-03-10', 3000000.00, 1, 'active'),
('Diego', 'Luna', 'diego.luna@multicont.com', '300200004', 'Vendedor Senior', '2023-11-05', 3500000.00, 2, 'active'),
('Elena', 'Suárez', 'elena.suarez@multicont.com', '300200005', 'Vendedor', '2024-01-20', 3000000.00, 2, 'active'),
('Felipe', 'Cruz', 'felipe.cruz@multicont.com', '300200006', 'Gerente de Ventas', '2023-06-01', 4500000.00, 3, 'active'),
('Gloria', 'Vega', 'gloria.vega@multicont.com', '300200007', 'Gerente de Ventas', '2023-08-15', 4500000.00, 3, 'active'),
('Hugo', 'Ríos', 'hugo.rios@multicont.com', '300200008', 'Administrador', '2023-01-10', 5000000.00, 4, 'active'),
('Irene', 'Quintero', 'irene.quintero@multicont.com', '300200009', 'Vendedor', '2024-04-01', 3000000.00, 4, 'active'),
('Jorge', 'Nieto', 'jorge.nieto@multicont.com', '300200010', 'Vendedor Senior', '2023-09-20', 3500000.00, 5, 'active');

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
INSERT INTO permission (name, description, module) VALUES
('READ_REPORTS', 'Leer reportes del sistema', 'REPORTS'),
('WRITE_REPORTS', 'Crear y modificar reportes', 'REPORTS'),
('READ_QUOTES', 'Ver cotizaciones', 'SALES'),
('WRITE_QUOTES', 'Crear y editar cotizaciones', 'SALES'),
('DELETE_QUOTES', 'Eliminar cotizaciones', 'SALES'),
('APPROVE_ORDERS', 'Aprobar órdenes de venta', 'SALES'),
('MANAGE_INVENTORY', 'Gestionar inventario', 'INVENTORY'),
('MANAGE_USERS', 'Administrar usuarios', 'ADMIN'),
('MANAGE_ROLES', 'Administrar roles y permisos', 'ADMIN'),
('ADMIN_ALL', 'Acceso total al sistema', 'ADMIN');

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
-- 11. ASIGNACIONES (10 empleados asignados a organización principal)
-- ============================================================
INSERT INTO assignment (organization_id, branch_id, employee_id) VALUES
(1, 1, 1),  -- Ana → multiCont Bogotá
(1, 1, 2),  -- Bruno → multiCont Bogotá
(1, 1, 3),  -- Carla → multiCont Bogotá
(1, 2, 4),  -- Diego → multiCont Bucaramanga
(1, 2, 5),  -- Elena → multiCont Bucaramanga
(1, 3, 6),  -- Felipe → multiCont Medellín
(1, 3, 7),  -- Gloria → multiCont Medellín
(1, 4, 8),  -- Hugo → multiCont Cali
(1, 4, 9),  -- Irene → multiCont Cali
(1, 5, 10); -- Jorge → multiCont Barranquilla

-- ============================================================
-- 12. MARCAS (6 fabricantes de equipos industriales)
-- ============================================================
INSERT INTO brand (name, country, website) VALUES
('Omron', 'Japón', 'www.omron.com'),
('ING Multicontrol', 'Alemania', 'www.ing-multicontrol.com'),
('Gefran', 'Italia', 'www.gefran.com'),
('Weidmüller', 'Alemania', 'www.weidmuller.com'),
('Rice-Lake', 'USA', 'www.ricelake.com'),
('Optec', 'Colombia', 'www.optec.com.co');

-- ============================================================
-- 13. INVENTARIO (60 items = 6 marcas × 10 productos)
-- ============================================================

-- OMRON (10 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id) VALUES
('OMR-PLC-NX1P2', 'Controlador PLC Omron NX1P2', 4500000.00, 10, 1),
('OMR-SEN-E3Z', 'Sensor fotoeléctrico Omron E3Z', 180000.00, 50, 1),
('OMR-INV-A1000', 'Variador Omron A1000', 6000000.00, 5, 1),
('OMR-HMI-NA5', 'HMI Omron NA5 7"', 2800000.00, 15, 1),
('OMR-IO-NX', 'Módulo I/O Omron NX', 850000.00, 20, 1),
('OMR-ENC-E6B2', 'Encoder Omron E6B2', 450000.00, 25, 1),
('OMR-REL-G2R', 'Relé electromecánico Omron G2R', 35000.00, 100, 1),
('OMR-SSR-G3NA', 'Relé de estado sólido Omron G3NA', 185000.00, 30, 1),
('OMR-PSU-S8VK', 'Fuente 24V Omron S8VK', 320000.00, 40, 1),
('OMR-SAF-F3SG', 'Cortina de seguridad Omron F3SG', 3200000.00, 8, 1);

-- ING MULTICONTROL (10 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id) VALUES
('ING-ARR-START', 'Arrancador suave ING Multicontrol', 2750000.00, 12, 2),
('ING-CON-24V', 'Fuente de poder 24V ING Multicontrol', 380000.00, 35, 2),
('ING-PLC-MC200', 'PLC ING Multicontrol MC200', 3800000.00, 10, 2),
('ING-HMI-MC7', 'HMI 7" ING Multicontrol', 1900000.00, 18, 2),
('ING-VFD-MC500', 'Variador ING Multicontrol MC500', 5200000.00, 7, 2),
('ING-IO-MOD8', 'Módulo I/O 8ch ING Multicontrol', 620000.00, 25, 2),
('ING-REL-SAF', 'Relé de seguridad ING Multicontrol', 580000.00, 22, 2),
('ING-SWI-ETH5', 'Switch Ethernet 5p ING Multicontrol', 490000.00, 30, 2),
('ING-ENC-INC', 'Encoder incremental ING Multicontrol', 380000.00, 28, 2),
('ING-PSU-48V', 'Fuente 48V ING Multicontrol', 520000.00, 20, 2);

-- GEFRAN (10 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id) VALUES
('GEF-TEMP-600', 'Controlador de temperatura Gefran 600', 1350000.00, 15, 3),
('GEF-INV-ADV', 'Inversor de frecuencia Gefran ADV', 6500000.00, 6, 3),
('GEF-TRANS-LIN', 'Transductor lineal Gefran', 2100000.00, 10, 3),
('GEF-SSR-GQ', 'Relé de estado sólido Gefran GQ', 285000.00, 35, 3),
('GEF-DRIVE-AX', 'Servo drive Gefran AX', 7800000.00, 5, 3),
('GEF-PRES-TRX', 'Transductor de presión Gefran', 980000.00, 18, 3),
('GEF-AMP-LC', 'Amplificador para celda de carga Gefran', 1450000.00, 12, 3),
('GEF-HMI-5', 'HMI 5" Gefran', 1680000.00, 14, 3),
('GEF-RTD-PT100', 'Sonda RTD PT100 Gefran', 220000.00, 45, 3),
('GEF-PSU-24', 'Fuente 24V Gefran', 380000.00, 30, 3);

-- WEIDMÜLLER (10 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id) VALUES
('WEI-BOR-TER', 'Bornera Weidmüller Terminal', 50000.00, 200, 4),
('WEI-SSR-IO', 'Módulo IO Weidmüller SSR', 250000.00, 40, 4),
('WEI-PSU-24', 'Fuente 24V Weidmüller', 400000.00, 35, 4),
('WEI-REL-TER', 'Relé interfaz Weidmüller', 85000.00, 60, 4),
('WEI-RAIL-DIN', 'Riel DIN Weidmüller', 35000.00, 150, 4),
('WEI-SW-IND8', 'Switch industrial 8p Weidmüller', 1250000.00, 15, 4),
('WEI-SURGE-SPD', 'Protección contra sobretensión Weidmüller SPD', 320000.00, 28, 4),
('WEI-CON-PUSHIN', 'Conector Push-In Weidmüller', 18000.00, 300, 4),
('WEI-MARKZ-CARD', 'Tarjetas marcadoras Weidmüller', 12000.00, 500, 4),
('WEI-TOOL-CRIMP', 'Herramienta crimpadora Weidmüller', 450000.00, 10, 4);

-- RICE-LAKE (10 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id) VALUES
('RCL-BAL-IND', 'Indicador de pesaje Rice-Lake', 4000000.00, 8, 5),
('RCL-CEL-CARGA', 'Celda de carga Rice-Lake', 1800000.00, 12, 5),
('RCL-PES-PLC', 'Módulo de pesaje para PLC Rice-Lake', 3800000.00, 6, 5),
('RCL-JBOX-4', 'Caja de conexiones 4 celdas Rice-Lake', 580000.00, 15, 5),
('RCL-SCALE-PLT', 'Báscula de plataforma Rice-Lake', 5500000.00, 5, 5),
('RCL-TRX-ANALOG', 'Transmisor analógico Rice-Lake', 720000.00, 18, 5),
('RCL-WEIGH-MOD', 'Módulo de pesaje Rice-Lake', 2900000.00, 8, 5),
('RCL-CHECK-CKW', 'Checkweigher Rice-Lake', 12500000.00, 3, 5),
('RCL-PRN-TT', 'Impresora térmica Rice-Lake', 950000.00, 10, 5),
('RCL-SW-LIC', 'Licencia software pesaje Rice-Lake', 1800000.00, 12, 5);

-- OPTEC (10 productos)
INSERT INTO inventory_item (name, description, price, quantity, brand_id) VALUES
('OPT-SEN-IND', 'Sensor inductivo Optec', 220000.00, 45, 6),
('OPT-BARR-SEG', 'Barrera de seguridad Optec', 900000.00, 12, 6),
('OPT-HMI-7', 'Panel HMI 7" Optec', 1200000.00, 15, 6),
('OPT-PE-SENS', 'Sensor fotoeléctrico Optec', 195000.00, 50, 6),
('OPT-PROX-M18', 'Sensor de proximidad M18 Optec', 165000.00, 60, 6),
('OPT-IO-LINK', 'Módulo IO-Link Master Optec', 850000.00, 18, 6),
('OPT-CAB-M12', 'Cable M12 Optec', 45000.00, 100, 6),
('OPT-BRK-ANG', 'Soporte/bracket angular Optec', 28000.00, 120, 6),
('OPT-PB-LED', 'Pulsador iluminado Optec', 75000.00, 80, 6),
('OPT-TWR-LIGHT', 'Torre luminosa Optec', 320000.00, 25, 6);

-- ============================================================
-- 14. QUOTATION LINES (8 líneas base para órdenes)
-- ============================================================
INSERT INTO quotation_line (item_code, quantity) VALUES
('OMR-PLC-NX1P2', 2),
('GEF-TEMP-600', 2),
('ING-PLC-MC200', 1),
('OMR-INV-A1000', 1),
('WEI-SSR-IO', 5),
('RCL-CEL-CARGA', 2),
('GEF-TRANS-LIN', 1),
('RCL-PES-PLC', 1);

-- ============================================================
-- 15. COTIZACIONES TANDA 1 (Abril-Junio 2025)
-- ============================================================
INSERT INTO quote (customer_name, date, total, employee_id) VALUES
('Automatiza Andina SAS', '2025-04-08', 12800000.00, 1),
('ControlTech SAS', '2025-04-15', 18300000.00, 4),
('Industrias del Norte SA', '2025-05-03', 15700000.00, 6),
('Vallepack LTDA', '2025-05-19', 6900000.00, 8),
('Caribe Foods SA', '2025-06-06', 22450000.00, 10),
('Metalúrgica Antioquia SAS', '2025-06-21', 9950000.00, 2);

-- ============================================================
-- 16. QUOTE ITEMS TANDA 1
-- ============================================================
INSERT INTO quote_item (quote_id, item_code, quantity, unit_price) VALUES
-- Quote 1 (Ana - $12,800,000)
(1, 'OMR-SEN-E3Z', 10, 180000.00),
(1, 'WEI-PSU-24', 5, 400000.00),
(1, 'OPT-SEN-IND', 5, 220000.00),
-- Quote 2 (Diego - $18,300,000) - ACCEPTED
(2, 'OMR-PLC-NX1P2', 2, 4500000.00),
(2, 'GEF-TEMP-600', 3, 1350000.00),
-- Quote 3 (Felipe - $15,700,000)
(3, 'ING-PLC-MC200', 1, 3800000.00),
(3, 'GEF-INV-ADV', 1, 6500000.00),
(3, 'RCL-BAL-IND', 1, 4000000.00),
-- Quote 4 (Hugo - $6,900,000) - REJECTED
(4, 'OMR-INV-A1000', 1, 6000000.00),
(4, 'OPT-BARR-SEG', 1, 900000.00),
-- Quote 5 (Jorge - $22,450,000) - ACCEPTED
(5, 'RCL-CEL-CARGA', 3, 1800000.00),
(5, 'WEI-SSR-IO', 10, 250000.00),
(5, 'OMR-SEN-E3Z', 10, 180000.00),
-- Quote 6 (Bruno - $9,950,000)
(6, 'GEF-TRANS-LIN', 2, 2100000.00),
(6, 'ING-CON-24V', 5, 380000.00);

-- ============================================================
-- 17. SALES ORDERS TANDA 1
-- ============================================================
INSERT INTO sales_order (quote_id, date, total, employee_id) VALUES
(2, '2025-04-20', 18300000.00, 4),  -- SO1 de Quote 2 (Diego)
(5, '2025-06-08', 22450000.00, 10); -- SO2 de Quote 5 (Jorge)

-- ============================================================
-- 18. SALES ORDER ITEMS TANDA 1
-- ============================================================
INSERT INTO sales_order_item (sales_order_id, item_code, quantity, unit_price) VALUES
-- SO1 items
(1, 'OMR-PLC-NX1P2', 2, 4500000.00),
(1, 'GEF-TEMP-600', 3, 1350000.00),
-- SO2 items
(2, 'RCL-CEL-CARGA', 3, 1800000.00),
(2, 'WEI-SSR-IO', 10, 250000.00),
(2, 'OMR-SEN-E3Z', 10, 180000.00);

-- ============================================================
-- 19. FACTURAS TANDA 1
-- ============================================================
INSERT INTO invoice (customer_name, invoice_date, total, sales_order_id, employee_id) VALUES
-- Factura de SO1 (Diego - ControlTech SAS)
('ControlTech SAS', '2025-04-21', 18300000.00, 1, 4),
-- Factura de SO2 (Jorge - Caribe Foods SA)
('Caribe Foods SA', '2025-06-10', 22450000.00, 2, 10),
-- Factura directa (Ana - Automatiza Andina SAS)
('Automatiza Andina SAS', '2025-04-30', 8600000.00, 1, 1),
-- Factura directa (Bruno - Metalúrgica Antioquia SAS)
('Metalúrgica Antioquia SAS', '2025-06-25', 6900000.00, 1, 2);

-- ============================================================
-- 20. INVOICE ITEMS TANDA 1
-- ============================================================
INSERT INTO invoice_item (invoice_id, item_code, quantity, unit_price) VALUES
-- Invoice 1 (de SO1)
(1, 'OMR-PLC-NX1P2', 2, 4500000.00),
(1, 'GEF-TEMP-600', 3, 1350000.00),
-- Invoice 2 (de SO2)
(2, 'RCL-CEL-CARGA', 3, 1800000.00),
(2, 'WEI-SSR-IO', 10, 250000.00),
(2, 'OMR-SEN-E3Z', 10, 180000.00),
-- Invoice 3 (directa Ana)
(3, 'WEI-PSU-24', 5, 400000.00),
(3, 'OPT-SEN-IND', 5, 220000.00),
(3, 'OMR-SEN-E3Z', 10, 180000.00),
-- Invoice 4 (directa Bruno)
(4, 'GEF-TRANS-LIN', 2, 2100000.00),
(4, 'ING-CON-24V', 5, 380000.00);

-- ============================================================
-- 21. COTIZACIONES TANDA 2 (Julio-Septiembre 2025)
-- ============================================================
INSERT INTO quote (customer_name, date, total, employee_id) VALUES
('Vallepack LTDA', '2025-07-05', 10400000.00, 8),
('Caribe Foods SA', '2025-07-18', 16900000.00, 10),
('Automatiza Andina SAS', '2025-08-08', 21600000.00, 1),
('Metalúrgica Antioquia SAS', '2025-08-22', 13750000.00, 6),
('ControlTech SAS', '2025-09-09', 7200000.00, 5),
('Industrias del Norte SA', '2025-09-14', 19300000.00, 7);

-- ============================================================
-- 22. QUOTE ITEMS TANDA 2
-- ============================================================
INSERT INTO quote_item (quote_id, item_code, quantity, unit_price) VALUES
-- Quote 7 (Hugo - $10,400,000)
(7, 'WEI-BOR-TER', 80, 50000.00),
(7, 'OMR-SEN-E3Z', 8, 180000.00),
-- Quote 8 (Jorge - $16,900,000) - ACCEPTED
(8, 'RCL-PES-PLC', 1, 3800000.00),
(8, 'OMR-INV-A1000', 1, 6000000.00),
(8, 'OPT-HMI-7', 1, 1200000.00),
-- Quote 9 (Ana - $21,600,000) - ACCEPTED
(9, 'OMR-PLC-NX1P2', 3, 4500000.00),
(9, 'ING-CON-24V', 3, 380000.00),
-- Quote 10 (Felipe - $13,750,000)
(10, 'ING-ARR-START', 2, 2750000.00),
(10, 'WEI-PSU-24', 5, 400000.00),
-- Quote 11 (Elena - $7,200,000)
(11, 'WEI-SSR-IO', 8, 250000.00),
(11, 'OMR-SEN-E3Z', 8, 180000.00),
-- Quote 12 (Gloria - $19,300,000) - ACCEPTED
(12, 'GEF-INV-ADV', 1, 6500000.00),
(12, 'GEF-TEMP-600', 2, 1350000.00),
(12, 'RCL-BAL-IND', 1, 4000000.00);

-- ============================================================
-- 23. SALES ORDERS TANDA 2
-- ============================================================
INSERT INTO sales_order (quote_id, date, total, employee_id) VALUES
(7, '2025-07-07', 10400000.00, 8),  -- SO3 de Quote 7 (Hugo)
(8, '2025-07-20', 16900000.00, 10), -- SO4 de Quote 8 (Jorge)
(9, '2025-08-10', 21600000.00, 1),  -- SO5 de Quote 9 (Ana)
(12, '2025-09-16', 19300000.00, 7); -- SO6 de Quote 12 (Gloria)

-- ============================================================
-- 24. SALES ORDER ITEMS TANDA 2
-- ============================================================
INSERT INTO sales_order_item (sales_order_id, item_code, quantity, unit_price) VALUES
-- SO3 items
(3, 'WEI-BOR-TER', 80, 50000.00),
(3, 'OMR-SEN-E3Z', 8, 180000.00),
-- SO4 items
(4, 'RCL-PES-PLC', 1, 3800000.00),
(4, 'OMR-INV-A1000', 1, 6000000.00),
(4, 'OPT-HMI-7', 1, 1200000.00),
-- SO5 items
(5, 'OMR-PLC-NX1P2', 3, 4500000.00),
(5, 'ING-CON-24V', 3, 380000.00),
-- SO6 items
(6, 'GEF-INV-ADV', 1, 6500000.00),
(6, 'GEF-TEMP-600', 2, 1350000.00),
(6, 'RCL-BAL-IND', 1, 4000000.00);

-- ============================================================
-- 25. FACTURAS TANDA 2
-- ============================================================
INSERT INTO invoice (customer_name, invoice_date, total, sales_order_id, employee_id) VALUES
-- Factura de SO3 (Hugo - Vallepack LTDA)
('Vallepack LTDA', '2025-07-08', 10400000.00, 3, 8),
-- Factura de SO4 (Jorge - Caribe Foods SA)
('Caribe Foods SA', '2025-07-21', 16900000.00, 4, 10),
-- Factura de SO5 (Ana - Automatiza Andina SAS)
('Automatiza Andina SAS', '2025-08-11', 21600000.00, 5, 1),
-- Factura de SO6 (Gloria - Industrias del Norte SA)
('Industrias del Norte SA', '2025-09-17', 19300000.00, 6, 7),
-- Factura directa (Felipe - Metalúrgica Antioquia SAS)
('Metalúrgica Antioquia SAS', '2025-08-25', 9150000.00, 4, 6),
-- Factura directa (Elena - ControlTech SAS)
('ControlTech SAS', '2025-09-20', 6440000.00, 4, 5);

-- ============================================================
-- 26. INVOICE ITEMS TANDA 2
-- ============================================================
INSERT INTO invoice_item (invoice_id, item_code, quantity, unit_price) VALUES
-- Invoice 5 (de SO3)
(5, 'WEI-BOR-TER', 80, 50000.00),
(5, 'OMR-SEN-E3Z', 8, 180000.00),
-- Invoice 6 (de SO4)
(6, 'RCL-PES-PLC', 1, 3800000.00),
(6, 'OMR-INV-A1000', 1, 6000000.00),
(6, 'OPT-HMI-7', 1, 1200000.00),
-- Invoice 7 (de SO5)
(7, 'OMR-PLC-NX1P2', 3, 4500000.00),
(7, 'ING-CON-24V', 3, 380000.00),
-- Invoice 8 (de SO6)
(8, 'GEF-INV-ADV', 1, 6500000.00),
(8, 'GEF-TEMP-600', 2, 1350000.00),
(8, 'RCL-BAL-IND', 1, 4000000.00),
-- Invoice 9 (directa Felipe)
(9, 'ING-ARR-START', 2, 2750000.00),
(9, 'WEI-PSU-24', 5, 400000.00),
(9, 'OMR-SEN-E3Z', 5, 180000.00),
-- Invoice 10 (directa Elena)
(10, 'WEI-SSR-IO', 8, 250000.00),
(10, 'OMR-SEN-E3Z', 8, 180000.00);

-- ============================================================
-- COMMIT Y RESUMEN
-- ============================================================
COMMIT;

-- ============================================================
-- CONSULTAS DE VERIFICACIÓN
-- ============================================================

-- Ver resumen de datos insertados
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
SELECT 'Asignaciones', COUNT(*) FROM assignment
UNION ALL
SELECT 'Marcas', COUNT(*) FROM brand
UNION ALL
SELECT 'Items Inventario', COUNT(*) FROM inventory_item
UNION ALL
SELECT 'Quotation Lines', COUNT(*) FROM quotation_line
UNION ALL
SELECT 'Cotizaciones', COUNT(*) FROM quote
UNION ALL
SELECT 'Quote Items', COUNT(*) FROM quote_item
UNION ALL
SELECT 'Sales Orders', COUNT(*) FROM sales_order
UNION ALL
SELECT 'Sales Order Items', COUNT(*) FROM sales_order_item
UNION ALL
SELECT 'Facturas', COUNT(*) FROM invoice
UNION ALL
SELECT 'Invoice Items', COUNT(*) FROM invoice_item
ORDER BY tabla;

-- Ver total facturado
SELECT 
    TO_CHAR(SUM(total), 'FM$999,999,999') AS total_facturado,
    COUNT(*) AS cantidad_facturas
FROM invoice;

-- Ver ventas por empleado
SELECT 
    e.id,
    p.first_name || ' ' || p.last_name AS empleado,
    COUNT(i.id) AS facturas,
    TO_CHAR(SUM(i.total), 'FM$999,999,999') AS total_vendido
FROM employee e
JOIN person p ON e.person_id = p.id
LEFT JOIN invoice i ON i.employee_id = e.id
GROUP BY e.id, p.first_name, p.last_name
ORDER BY SUM(i.total) DESC NULLS LAST;

-- Ver ventas por ciudad/sucursal
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

-- Ver productos más vendidos (por cantidad)
SELECT 
    ii.item_code,
    inv.description,
    SUM(ii.quantity) AS unidades_vendidas,
    TO_CHAR(SUM(ii.quantity * ii.unit_price), 'FM$999,999,999') AS valor_total
FROM invoice_item ii
JOIN inventory_item inv ON ii.item_code = inv.name
GROUP BY ii.item_code, inv.description
ORDER BY SUM(ii.quantity * ii.unit_price) DESC
LIMIT 10;

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
-- Dataset: Abril - Septiembre 2025
-- Total esperado: ~$170,000,000 COP en ventas
-- 10 facturas, 6 órdenes de venta, 12 cotizaciones
-- 60 productos en inventario, 10 empleados activos
-- ============================================================
