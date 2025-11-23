# ============================================================
# Script PowerShell para Limpiar y Repoblar Base de Datos
# Base de datos: prueba2
# Autor: Sistema de Gestión Spring Boot
# ============================================================

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  LIMPIEZA Y REPOBLACIÓN DE BASE DE DATOS prueba2" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Configuración
$dbName = "prueba2"
$dbUser = "postgres"
$dbPassword = "123456"
$dbHost = "localhost"
$dbPort = "5432"

# Rutas de scripts SQL
$scriptLimpiar = "LIMPIAR_BASE_DATOS.sql"
$scriptPoblar = "POBLAR_BASE_DATOS_COMPLETO.sql"

# Establecer variable de entorno para contraseña
$env:PGPASSWORD = $dbPassword

Write-Host "[1/3] Verificando conexión a PostgreSQL..." -ForegroundColor Yellow

# Verificar si PostgreSQL está disponible
$pgBinPath = "C:\Program Files\PostgreSQL\17\bin"
if (Test-Path $pgBinPath) {
    $env:PATH = "$pgBinPath;$env:PATH"
    Write-Host "  ✓ PostgreSQL encontrado en: $pgBinPath" -ForegroundColor Green
} else {
    Write-Host "  ⚠ Intentando usar PostgreSQL desde PATH..." -ForegroundColor Yellow
}

# Probar conexión
try {
    $testConnection = & psql -U $dbUser -d $dbName -c "SELECT 1;" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Conexión a base de datos exitosa" -ForegroundColor Green
    } else {
        Write-Host "  ✗ Error al conectar a la base de datos" -ForegroundColor Red
        Write-Host "  Error: $testConnection" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "  ✗ No se pudo ejecutar psql. Verifica la instalación de PostgreSQL" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[2/3] Limpiando base de datos..." -ForegroundColor Yellow

# Ejecutar script de limpieza
$resultLimpiar = & psql -U $dbUser -d $dbName -f $scriptLimpiar 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Base de datos limpiada exitosamente" -ForegroundColor Green
} else {
    Write-Host "  ✗ Error al limpiar base de datos" -ForegroundColor Red
    Write-Host "  Error: $resultLimpiar" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[3/3] Poblando base de datos con datos de prueba..." -ForegroundColor Yellow

# Ejecutar script de población
$resultPoblar = & psql -U $dbUser -d $dbName -f $scriptPoblar 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Base de datos poblada exitosamente" -ForegroundColor Green
} else {
    Write-Host "  ✗ Error al poblar base de datos" -ForegroundColor Red
    Write-Host "  Error: $resultPoblar" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  PROCESO COMPLETADO EXITOSAMENTE" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Mostrar resumen de datos
Write-Host "📊 RESUMEN DE DATOS INSERTADOS:" -ForegroundColor Cyan
Write-Host ""

$queryResumen = @"
SELECT 
    'Estados' AS tabla, COUNT(*) AS total FROM state
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
SELECT 'Marcas', COUNT(*) FROM brand
UNION ALL
SELECT 'Items Inventario', COUNT(*) FROM inventory_item
UNION ALL
SELECT 'Cotizaciones', COUNT(*) FROM quote
UNION ALL
SELECT 'Órdenes de Venta', COUNT(*) FROM sales_order
UNION ALL
SELECT 'Facturas', COUNT(*) FROM invoice
ORDER BY tabla;
"@

& psql -U $dbUser -d $dbName -c $queryResumen

Write-Host ""
Write-Host "💰 TOTAL FACTURADO:" -ForegroundColor Cyan
$queryTotal = "SELECT TO_CHAR(SUM(total), 'FM`$999,999,999') AS total_facturado FROM invoice;"
& psql -U $dbUser -d $dbName -c $queryTotal

Write-Host ""
Write-Host "✅ La base de datos está lista para usar!" -ForegroundColor Green
Write-Host "🌐 Puedes acceder al sistema en: http://localhost:8080" -ForegroundColor Yellow
Write-Host ""
Write-Host "📋 Credenciales de prueba:" -ForegroundColor Cyan
Write-Host "  Usuario: hugo | Contraseña: password123 | Rol: ADMIN" -ForegroundColor White
Write-Host "  Usuario: felipe | Contraseña: password123 | Rol: MANAGER" -ForegroundColor White
Write-Host "  Usuario: ana | Contraseña: password123 | Rol: SALES" -ForegroundColor White
Write-Host ""

# Limpiar variable de entorno
Remove-Item Env:\PGPASSWORD
