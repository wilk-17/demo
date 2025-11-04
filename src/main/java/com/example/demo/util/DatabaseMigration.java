package com.example.demo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DatabaseMigration {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/prueba2";
        String user = "postgres";
        String password = "123456";

        String[] migrations = {
            // Arreglar contraseñas NULL - asignar contraseña temporal 'admin123'
            "UPDATE users SET password = '$2a$10$N9qo8uLOickgx2ZZ.wu0BuO8X7F7tNe4UJKmHzOWPIzmPzk0HVlQi' WHERE password IS NULL",
            "ALTER TABLE users ADD COLUMN IF NOT EXISTS enabled BOOLEAN DEFAULT true NOT NULL",
            "ALTER TABLE users ADD COLUMN IF NOT EXISTS account_non_expired BOOLEAN DEFAULT true",
            "ALTER TABLE users ADD COLUMN IF NOT EXISTS account_non_locked BOOLEAN DEFAULT true",
            "ALTER TABLE users ADD COLUMN IF NOT EXISTS credentials_non_expired BOOLEAN DEFAULT true",
            "ALTER TABLE users ADD COLUMN IF NOT EXISTS last_login TIMESTAMP",
            "ALTER TABLE users ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP",
            "ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP",
            "UPDATE users SET enabled = true WHERE enabled IS NULL",
            "UPDATE users SET account_non_expired = true WHERE account_non_expired IS NULL",
            "UPDATE users SET account_non_locked = true WHERE account_non_locked IS NULL",
            "UPDATE users SET credentials_non_expired = true WHERE credentials_non_expired IS NULL",
            "UPDATE users SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL",
            "UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE updated_at IS NULL"
        };

        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement()) {
            
            System.out.println("Conectado a la base de datos prueba2");
            System.out.println("Ejecutando migraciones...");
            
            for (String sql : migrations) {
                try {
                    stmt.execute(sql);
                    System.out.println("✓ " + sql.substring(0, Math.min(50, sql.length())) + "...");
                } catch (Exception e) {
                    System.out.println("✗ Error en: " + sql);
                    System.out.println("  " + e.getMessage());
                }
            }
            
            System.out.println("\n¡Migración completada!");
            
        } catch (Exception e) {
            System.err.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}
