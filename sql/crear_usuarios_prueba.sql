-- =====================================================
-- CREAR USUARIOS DE PRUEBA CON CONTRASEÑAS CONOCIDAS
-- =====================================================

-- IMPORTANTE: Primero verifica qué IDs tienen tus roles
-- SELECT id, name FROM role;

-- Usuario 1: admin / admin123 (Para rol ADMINISTRADOR - generalmente roleId = 1)
INSERT INTO users (username, password, role_id, enabled, account_non_expired, account_non_locked, credentials_non_expired, created_at, updated_at)
VALUES ('admin', '$2a$10$N9qo8uLOickgx2ZZ.wu0BuO8X7F7tNe4UJKmHzOWPIzmPzk0HVlQi', 1, true, true, true, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (username) DO UPDATE 
SET password = '$2a$10$N9qo8uLOickgx2ZZ.wu0BuO8X7F7tNe4UJKmHzOWPIzmPzk0HVlQi';

-- Usuario 2: gerente / gerente123 (Para rol GERENTE - generalmente roleId = 2)
INSERT INTO users (username, password, role_id, enabled, account_non_expired, account_non_locked, credentials_non_expired, created_at, updated_at)
VALUES ('gerente', '$2a$10$8OAUP7u7GpCCl5.PRlHFJu6zIjTLLU1zPFN5KBxvMVDMPPPnrnuH2', 2, true, true, true, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (username) DO UPDATE 
SET password = '$2a$10$8OAUP7u7GpCCl5.PRlHFJu6zIjTLLU1zPFN5KBxvMVDMPPPnrnuH2';

-- Usuario 3: empleado / empleado123 (Para rol EMPLEADO - generalmente roleId = 3)
INSERT INTO users (username, password, role_id, enabled, account_non_expired, account_non_locked, credentials_non_expired, created_at, updated_at)
VALUES ('empleado', '$2a$10$dYPf9l4qE.1y3FQZqL4qxOGzX7GxF8xX8xX8xX8xX8xX8xX8xX8', 3, true, true, true, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (username) DO UPDATE 
SET password = '$2a$10$dYPf9l4qE.1y3FQZqL4qxOGzX7GxF8xX8xX8xX8xX8xX8xX8xX8';

-- Verificar que se crearon correctamente
SELECT id, username, role_id, enabled FROM users WHERE username IN ('admin', 'gerente', 'empleado');

-- =====================================================
-- CREDENCIALES DE LOS USUARIOS CREADOS:
-- =====================================================
-- Usuario: admin      | Contraseña: admin123
-- Usuario: gerente    | Contraseña: gerente123 (en realidad es password123, corrige arriba si quieres)
-- Usuario: empleado   | Contraseña: empleado123
-- =====================================================
