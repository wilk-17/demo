package com.example.demo.config;

import com.example.demo.model.Permission;
import com.example.demo.model.Role;
import com.example.demo.model.User;
import com.example.demo.repository.PermissionRepository;
import com.example.demo.repository.RoleRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private PermissionRepository permissionRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("Inicializando permisos y datos de seguridad...");

        // 1. Crear permisos si no existen
        initializePermissions();

        // 2. Asignar permisos a roles existentes
        assignPermissionsToRoles();

        // 3. Encriptar contraseñas existentes
        encryptExistingPasswords();

        System.out.println("Inicialización completada.");
    }

    private void initializePermissions() {
        if (permissionRepository.count() > 0) {
            System.out.println("Los permisos ya existen, omitiendo creación...");
            return;
        }

        System.out.println("Creando permisos del sistema...");

        List<Permission> permissions = Arrays.asList(
                // Permisos de Usuario
                new Permission("CREATE_USER", "Crear usuarios", "USER"),
                new Permission("READ_USER", "Ver usuarios", "USER"),
                new Permission("UPDATE_USER", "Actualizar usuarios", "USER"),
                new Permission("DELETE_USER", "Eliminar usuarios", "USER"),

                // Permisos de Rol
                new Permission("CREATE_ROLE", "Crear roles", "ROLE"),
                new Permission("READ_ROLE", "Ver roles", "ROLE"),
                new Permission("UPDATE_ROLE", "Actualizar roles", "ROLE"),
                new Permission("DELETE_ROLE", "Eliminar roles", "ROLE"),

                // Permisos de Cliente
                new Permission("CREATE_CLIENT", "Crear clientes", "CLIENT"),
                new Permission("READ_CLIENT", "Ver clientes", "CLIENT"),
                new Permission("UPDATE_CLIENT", "Actualizar clientes", "CLIENT"),
                new Permission("DELETE_CLIENT", "Eliminar clientes", "CLIENT"),

                // Permisos de Proveedor
                new Permission("CREATE_SUPPLIER", "Crear proveedores", "SUPPLIER"),
                new Permission("READ_SUPPLIER", "Ver proveedores", "SUPPLIER"),
                new Permission("UPDATE_SUPPLIER", "Actualizar proveedores", "SUPPLIER"),
                new Permission("DELETE_SUPPLIER", "Eliminar proveedores", "SUPPLIER"),

                // Permisos de Producto
                new Permission("CREATE_PRODUCT", "Crear productos", "PRODUCT"),
                new Permission("READ_PRODUCT", "Ver productos", "PRODUCT"),
                new Permission("UPDATE_PRODUCT", "Actualizar productos", "PRODUCT"),
                new Permission("DELETE_PRODUCT", "Eliminar productos", "PRODUCT"),

                // Permisos de Categoría
                new Permission("CREATE_CATEGORY", "Crear categorías", "CATEGORY"),
                new Permission("READ_CATEGORY", "Ver categorías", "CATEGORY"),
                new Permission("UPDATE_CATEGORY", "Actualizar categorías", "CATEGORY"),
                new Permission("DELETE_CATEGORY", "Eliminar categorías", "CATEGORY"),

                // Permisos de Inventario
                new Permission("CREATE_INVENTORY", "Crear inventario", "INVENTORY"),
                new Permission("READ_INVENTORY", "Ver inventario", "INVENTORY"),
                new Permission("UPDATE_INVENTORY", "Actualizar inventario", "INVENTORY"),
                new Permission("DELETE_INVENTORY", "Eliminar inventario", "INVENTORY"),

                // Permisos de Pedido
                new Permission("CREATE_ORDER", "Crear pedidos", "ORDER"),
                new Permission("READ_ORDER", "Ver pedidos", "ORDER"),
                new Permission("UPDATE_ORDER", "Actualizar pedidos", "ORDER"),
                new Permission("DELETE_ORDER", "Eliminar pedidos", "ORDER"),

                // Permisos de Detalle de Pedido
                new Permission("CREATE_ORDER_DETAIL", "Crear detalles de pedido", "ORDER_DETAIL"),
                new Permission("READ_ORDER_DETAIL", "Ver detalles de pedido", "ORDER_DETAIL"),
                new Permission("UPDATE_ORDER_DETAIL", "Actualizar detalles de pedido", "ORDER_DETAIL"),
                new Permission("DELETE_ORDER_DETAIL", "Eliminar detalles de pedido", "ORDER_DETAIL"),

                // Permisos de Factura
                new Permission("CREATE_INVOICE", "Crear facturas", "INVOICE"),
                new Permission("READ_INVOICE", "Ver facturas", "INVOICE"),
                new Permission("UPDATE_INVOICE", "Actualizar facturas", "INVOICE"),
                new Permission("DELETE_INVOICE", "Eliminar facturas", "INVOICE"),

                // Permisos de Pago
                new Permission("CREATE_PAYMENT", "Crear pagos", "PAYMENT"),
                new Permission("READ_PAYMENT", "Ver pagos", "PAYMENT"),
                new Permission("UPDATE_PAYMENT", "Actualizar pagos", "PAYMENT"),
                new Permission("DELETE_PAYMENT", "Eliminar pagos", "PAYMENT"),

                // Permisos de Método de Pago
                new Permission("CREATE_PAYMENT_METHOD", "Crear métodos de pago", "PAYMENT_METHOD"),
                new Permission("READ_PAYMENT_METHOD", "Ver métodos de pago", "PAYMENT_METHOD"),
                new Permission("UPDATE_PAYMENT_METHOD", "Actualizar métodos de pago", "PAYMENT_METHOD"),
                new Permission("DELETE_PAYMENT_METHOD", "Eliminar métodos de pago", "PAYMENT_METHOD"),

                // Permisos de Estado de Pedido
                new Permission("CREATE_ORDER_STATUS", "Crear estados de pedido", "ORDER_STATUS"),
                new Permission("READ_ORDER_STATUS", "Ver estados de pedido", "ORDER_STATUS"),
                new Permission("UPDATE_ORDER_STATUS", "Actualizar estados de pedido", "ORDER_STATUS"),
                new Permission("DELETE_ORDER_STATUS", "Eliminar estados de pedido", "ORDER_STATUS"),

                // Permisos de Envío
                new Permission("CREATE_SHIPMENT", "Crear envíos", "SHIPMENT"),
                new Permission("READ_SHIPMENT", "Ver envíos", "SHIPMENT"),
                new Permission("UPDATE_SHIPMENT", "Actualizar envíos", "SHIPMENT"),
                new Permission("DELETE_SHIPMENT", "Eliminar envíos", "SHIPMENT"),

                // Permisos de Devolución
                new Permission("CREATE_RETURN", "Crear devoluciones", "RETURN"),
                new Permission("READ_RETURN", "Ver devoluciones", "RETURN"),
                new Permission("UPDATE_RETURN", "Actualizar devoluciones", "RETURN"),
                new Permission("DELETE_RETURN", "Eliminar devoluciones", "RETURN"),

                // Permisos Administrativos
                new Permission("VIEW_DASHBOARD", "Ver dashboard administrativo", "ADMIN"),
                new Permission("MANAGE_PERMISSIONS", "Gestionar permisos", "ADMIN"),
                new Permission("VIEW_AUDIT_LOGS", "Ver logs de auditoría", "ADMIN"),
                new Permission("GENERATE_REPORTS", "Generar reportes", "ADMIN")
        );

        permissionRepository.saveAll(permissions);
        System.out.println("Permisos creados: " + permissions.size());
    }

    @Transactional
    private void assignPermissionsToRoles() {
        System.out.println("Asignando permisos a roles...");

        // Obtener roles (buscar por nombre exacto en tu BD)
        Role adminRole = roleRepository.findByName("Administrador").orElse(null);
        Role managerRole = roleRepository.findByName("Gerente").orElse(null);
        Role employeeRole = roleRepository.findByName("Empleado").orElse(null);

        if (adminRole == null && managerRole == null && employeeRole == null) {
            System.out.println("ADVERTENCIA: No se encontraron roles. Asegúrate de tener roles en la BD.");
            return;
        }

        // ADMINISTRADOR - Todos los permisos
        if (adminRole != null) {
            List<Permission> allPermissions = permissionRepository.findAll();
            for (Permission permission : allPermissions) {
                adminRole.addPermission(permission);
            }
            roleRepository.save(adminRole);
            System.out.println("Asignados " + allPermissions.size() + " permisos a " + adminRole.getName());
        }

        // GERENTE - Permisos de lectura/creación/actualización (sin eliminación en áreas críticas)
        if (managerRole != null) {
            List<Permission> managerPermissions = permissionRepository.findAll().stream()
                    .filter(p -> !p.getName().startsWith("DELETE_USER") &&
                                 !p.getName().startsWith("DELETE_ROLE") &&
                                 !p.getName().equals("MANAGE_PERMISSIONS"))
                    .toList();
            for (Permission permission : managerPermissions) {
                managerRole.addPermission(permission);
            }
            roleRepository.save(managerRole);
            System.out.println("Asignados " + managerPermissions.size() + " permisos a " + managerRole.getName());
        }

        // EMPLEADO - Solo permisos de lectura y operaciones básicas
        if (employeeRole != null) {
            List<Permission> employeePermissions = permissionRepository.findAll().stream()
                    .filter(p -> p.getName().startsWith("READ_") ||
                                 p.getName().startsWith("CREATE_ORDER") ||
                                 p.getName().startsWith("CREATE_INVOICE") ||
                                 p.getName().startsWith("CREATE_PAYMENT") ||
                                 p.getName().startsWith("UPDATE_ORDER") ||
                                 p.getName().startsWith("UPDATE_INVENTORY"))
                    .toList();
            for (Permission permission : employeePermissions) {
                employeeRole.addPermission(permission);
            }
            roleRepository.save(employeeRole);
            System.out.println("Asignados " + employeePermissions.size() + " permisos a " + employeeRole.getName());
        }
    }

    private void encryptExistingPasswords() {
        System.out.println("Verificando contraseñas no encriptadas...");

        List<User> users = userRepository.findAll();
        int encryptedCount = 0;

        for (User user : users) {
            // Verificar si la contraseña ya está encriptada (BCrypt comienza con "$2a$")
            if (user.getPassword() != null && !user.getPassword().startsWith("$2a$")) {
                String encryptedPassword = passwordEncoder.encode(user.getPassword());
                user.setPassword(encryptedPassword);
                userRepository.save(user);
                encryptedCount++;
                System.out.println("Contraseña encriptada para usuario: " + user.getUsername());
            }
        }

        System.out.println("Contraseñas encriptadas: " + encryptedCount);
    }
}
