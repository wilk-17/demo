# Script para agregar @PreAuthorize a todos los controladores

$controllers = @(
    "BranchController",
    "StateController", 
    "CityController",
    "PersonController",
    "EmployeeController",
    "BrandController",
    "ItemCategoryController",
    "InventoryItemController",
    "SalesOrderController",
    "InvoiceController",
    "SalesOrderItemController",
    "InvoiceItemController",
    "AssignmentController",
    "QuoteController",
    "QuotationLineController",
    "QuoteItemController",
    "SalesGoalController"
)

$basePath = "c:\Users\wilke\Documents\Sistemas de BDD 6to\demo\src\main\java\com\example\demo\controller\"

foreach ($controller in $controllers) {
    $filePath = Join-Path $basePath "$controller.java"
    
    if (Test-Path $filePath) {
        Write-Host "Procesando $controller..." -ForegroundColor Cyan
        
        $content = Get-Content $filePath -Raw
        
        # Verificar si ya tiene @PreAuthorize
        if ($content -match "@PreAuthorize") {
            Write-Host "  ⚠️  Ya tiene @PreAuthorize, omitiendo..." -ForegroundColor Yellow
            continue
        }
        
        # Agregar import de PreAuthorize si no existe
        if ($content -notmatch "import org.springframework.security.access.prepost.PreAuthorize;") {
            $content = $content -replace "(import org\.springframework\.web\.bind\.annotation\.\*;)", "`$1`nimport org.springframework.security.access.prepost.PreAuthorize;"
        }
        
        # Agregar @PreAuthorize antes de @GetMapping
        $content = $content -replace "(\s+)@GetMapping", "`$1@PreAuthorize(`"hasRole('ADMINISTRADOR') or hasRole('GERENTE')`")`n`$1@GetMapping"
        
        # Agregar @PreAuthorize antes de @PostMapping
        $content = $content -replace "(\s+)@PostMapping", "`$1@PreAuthorize(`"hasRole('ADMINISTRADOR')`")`n`$1@PostMapping"
        
        # Agregar @PreAuthorize antes de @PutMapping
        $content = $content -replace "(\s+)@PutMapping", "`$1@PreAuthorize(`"hasRole('ADMINISTRADOR')`")`n`$1@PutMapping"
        
        # Agregar @PreAuthorize antes de @DeleteMapping
        $content = $content -replace "(\s+)@DeleteMapping", "`$1@PreAuthorize(`"hasRole('ADMINISTRADOR')`")`n`$1@DeleteMapping"
        
        # Guardar el archivo
        Set-Content -Path $filePath -Value $content -NoNewline
        
        Write-Host "  ✅ $controller actualizado" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Archivo no encontrado: $filePath" -ForegroundColor Red
    }
}

Write-Host "`n✨ Proceso completado!" -ForegroundColor Green
Write-Host "Controllers actualizados con @PreAuthorize" -ForegroundColor Green
