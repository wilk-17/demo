-- Script para agregar columnas de seguridad a la tabla users
-- Ejecutar este script en PostgreSQL antes de iniciar la aplicación

-- Agregar columnas de seguridad a users
ALTER TABLE users ADD COLUMN IF NOT EXISTS enabled BOOLEAN DEFAULT true NOT NULL;
ALTER TABLE users ADD COLUMN IF NOT EXISTS account_non_expired BOOLEAN DEFAULT true;
ALTER TABLE users ADD COLUMN IF NOT EXISTS account_non_locked BOOLEAN DEFAULT true;
ALTER TABLE users ADD COLUMN IF NOT EXISTS credentials_non_expired BOOLEAN DEFAULT true;
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_login TIMESTAMP;
ALTER TABLE users ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Actualizar registros existentes
UPDATE users SET enabled = true WHERE enabled IS NULL;
UPDATE users SET account_non_expired = true WHERE account_non_expired IS NULL;
UPDATE users SET account_non_locked = true WHERE account_non_locked IS NULL;
UPDATE users SET credentials_non_expired = true WHERE credentials_non_expired IS NULL;
UPDATE users SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE updated_at IS NULL;

-- Verificar las columnas
SELECT column_name, data_type, is_nullable, column_default 
FROM information_schema.columns 
WHERE table_name = 'users' 
ORDER BY ordinal_position;
