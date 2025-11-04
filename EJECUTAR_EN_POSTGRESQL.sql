-- =====================================================
-- SCRIPT DE MIGRACION - AGREGAR COLUMNAS DE SEGURIDAD
-- Base de datos: prueba2
-- Tabla: users
-- =====================================================

-- PASO 1: Agregar columnas de seguridad
ALTER TABLE users ADD COLUMN IF NOT EXISTS enabled BOOLEAN DEFAULT true NOT NULL;
ALTER TABLE users ADD COLUMN IF NOT EXISTS account_non_expired BOOLEAN DEFAULT true;
ALTER TABLE users ADD COLUMN IF NOT EXISTS account_non_locked BOOLEAN DEFAULT true;
ALTER TABLE users ADD COLUMN IF NOT EXISTS credentials_non_expired BOOLEAN DEFAULT true;
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_login TIMESTAMP;
ALTER TABLE users ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- PASO 2: Actualizar registros existentes
UPDATE users SET enabled = true WHERE enabled IS NULL;
UPDATE users SET account_non_expired = true WHERE account_non_expired IS NULL;
UPDATE users SET account_non_locked = true WHERE account_non_locked IS NULL;
UPDATE users SET credentials_non_expired = true WHERE credentials_non_expired IS NULL;
UPDATE users SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE updated_at IS NULL;

-- PASO 3: Verificar que se agregaron correctamente
SELECT 'Columnas agregadas correctamente' as status;
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'users' 
ORDER BY ordinal_position;
