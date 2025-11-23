# Script para agregar Authorization header a todos los POST/PUT/DELETE

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

foreach ($template in $templates) {
    $filePath = Join-Path $basePath $template
    
    if (!(Test-Path $filePath)) {
        Write-Host "Archivo no encontrado: $template" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "Procesando $template..." -ForegroundColor Cyan
    
    $content = Get-Content $filePath -Raw
    
    # Cambiar headers: { 'Content-Type': 'application/json' } 
    # por headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` }
    $content = $content -replace "headers: \{ 'Content-Type': 'application/json' \}", "headers: { 'Content-Type': 'application/json', 'Authorization': ``Bearer `${localStorage.getItem('token')}`` }"
    
    # Cambiar method: 'DELETE' sin headers
    $content = $content -replace "(\{ method: 'DELETE' \})", "{ method: 'DELETE', headers: { 'Authorization': ``Bearer `${localStorage.getItem('token')}`` } }"
    
    # Guardar
    Set-Content -Path $filePath -Value $content -NoNewline
    
    Write-Host "  Actualizado" -ForegroundColor Green
}

Write-Host "`nProceso completado!" -ForegroundColor Green
