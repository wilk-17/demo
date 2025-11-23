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
            
            // Verificar que sea administrador
            if (data.roleName !== 'ADMIN') {
                console.log('Usuario no es administrador, redirigiendo al login...');
                localStorage.clear();
                alert('⚠️ Acceso denegado. Solo los administradores pueden acceder a este sistema.');
                window.location.href = '/login';
                return;
            }
            
            console.log('Usuario autenticado correctamente:', data.username);
            
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
