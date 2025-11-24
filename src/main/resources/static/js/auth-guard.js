// auth-guard.js - Protección de rutas del dashboard
(function() {
    'use strict';
    
    // Verificar si el usuario está autenticado y es administrador
    async function checkAuth() {
        const token = localStorage.getItem('token');
        const role = localStorage.getItem('role');
        
        // Si no hay token, redirigir al login
        if (!token) {
            console.log('No hay token, redirigiendo al login...');
            window.location.href = '/login';
            return;
        }
        
        // Verificar que el token sea válido
        try {
            const response = await fetch('/api/auth/me', {
                headers: {
                    'Authorization': 'Bearer ' + token
                }
            });
            
            if (!response.ok) {
                console.log('Token inválido, redirigiendo al login...');
                localStorage.clear();
                window.location.href = '/login';
                return;
            }
            
            const data = await response.json();
            
            // Guardar permisos actualizados
            localStorage.setItem('role', data.roleName);
            localStorage.setItem('permissions', JSON.stringify(data.permissions || []));
            
            // Las páginas individuales pueden verificar permisos específicos
            // Este guard solo verifica que haya un token válido
            console.log('Usuario autenticado correctamente:', data.username, '- Rol:', data.roleName);
            
        } catch (error) {
            console.error('Error verificando autenticación:', error);
            localStorage.clear();
            window.location.href = '/login';
        }
    }
    
    // Ejecutar verificación al cargar la página
    checkAuth();
    
    // Función global para cerrar sesión
    window.logoutDashboard = function() {
        if (confirm('¿Está seguro de cerrar sesión?')) {
            localStorage.clear();
            window.location.href = '/login';
        }
    };
})();
