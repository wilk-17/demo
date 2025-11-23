# Script para agregar función getAuthHeaders() y fix fetch sin auth headers

$templates = @(
    "estados.html",
    "ciudades.html", 
    "personas.html",
    "empleados.html",
    "marcas.html",
    "categorias.html",
    "inventario.html",
    "ordenes-venta.html",
    "facturas.html",
    "items-orden-venta.html",
    "items-factura.html",
    "sucursales.html",
    "usuarios.html",
    "roles.html",
    "organizaciones.html"
)

$basePath = "c:\Users\wilke\Documents\Sistemas de BDD 6to\demo\src\main\resources\templates\"

$getAuthHeadersFunction = @"
        // Función para obtener headers de autenticación
        function getAuthHeaders() {
            const token = localStorage.getItem('token');
            return {
                'Content-Type': 'application/json',
                'Authorization': ``Bearer `${token}``
            };
        }
"@

foreach ($template in $templates) {
    $filePath = Join-Path $basePath $template
    
    if (!(Test-Path $filePath)) {
        Write-Host "⚠️  Archivo no encontrado: $template" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "Procesando $template..." -ForegroundColor Cyan
    
    $content = Get-Content $filePath -Raw
    
    # Verificar si ya tiene la función
    if ($content -match "function getAuthHeaders") {
        Write-Host "  Ya tiene getAuthHeaders()" -ForegroundColor Green
    } else {
        # Agregar la función antes del primer async function
        $content = $content -replace "(async function load)", "$getAuthHeadersFunction`n`n        `$1"
        Write-Host "  Agregada funcion getAuthHeaders()" -ForegroundColor Green
    }
    
    # Fix fetch calls sin headers
    # Patrón: fetch('/path'),
    $content = $content -replace "fetch\('/state'\),", "fetch('/state', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/city'\),", "fetch('/city', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/person'\),", "fetch('/person', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/employee'\),", "fetch('/employee', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/branch'\),", "fetch('/branch', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/inventory-item'\),", "fetch('/inventory-item', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/item-category'\),", "fetch('/item-category', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/brand'\),", "fetch('/brand', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/sales-order'\),", "fetch('/sales-order', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/invoice'\),", "fetch('/invoice', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/sales-order-item'\),", "fetch('/sales-order-item', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/invoice-item'\),", "fetch('/invoice-item', { headers: getAuthHeaders() }),"
    $content = $content -replace "fetch\('/api/organizations'\),", "fetch('/api/organizations', { headers: getAuthHeaders() }),"
    
    # Patrón: fetch('/path'))
    $content = $content -replace "fetch\('/state'\)\)", "fetch('/state', { headers: getAuthHeaders() })"
    $content = $content -replace "fetch\('/city'\)\)", "fetch('/city', { headers: getAuthHeaders() })"
    $content = $content -replace "fetch\('/person'\)\)", "fetch('/person', { headers: getAuthHeaders() })"
    $content = $content -replace "fetch\('/employee'\)\)", "fetch('/employee', { headers: getAuthHeaders() })"
    $content = $content -replace "fetch\('/branch'\)\)", "fetch('/branch', { headers: getAuthHeaders() })"
    
    # Guardar
    Set-Content -Path $filePath -Value $content -NoNewline
    
    Write-Host "  ✅ Actualizado" -ForegroundColor Green
}

Write-Host "`n✨ Proceso completado!" -ForegroundColor Green
