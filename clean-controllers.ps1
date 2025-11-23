# Script para limpiar líneas vacías extra en los controladores

$basePath = "c:\Users\wilke\Documents\Sistemas de BDD 6to\demo\src\main\java\com\example\demo\controller\"

$files = Get-ChildItem -Path $basePath -Filter "*Controller.java"

foreach ($file in $files) {
    Write-Host "Limpiando $($file.Name)..." -ForegroundColor Cyan
    
    $content = Get-Content $file.FullName -Raw
    
    # Eliminar líneas vacías duplicadas entre @PreAuthorize y @GetMapping/@PostMapping/@PutMapping/@DeleteMapping
    $content = $content -replace "@PreAuthorize\(`"[^`"]+`"`)\r?\n\r?\n\r?\n", "@PreAuthorize(`$1)`n"
    
    # Guardar
    Set-Content -Path $file.FullName -Value $content -NoNewline
    
    Write-Host "  ✅ Limpiado" -ForegroundColor Green
}

Write-Host "`n✨ Limpieza completada!" -ForegroundColor Green
