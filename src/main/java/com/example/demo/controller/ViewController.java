package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/usuarios")
    public String usuarios() {
        return "usuarios";
    }

    @GetMapping("/roles")
    public String roles() {
        return "roles";
    }

    @GetMapping("/estados")
    public String estados() {
        return "estados";
    }

    @GetMapping("/ciudades")
    public String ciudades() {
        return "ciudades";
    }

    @GetMapping("/organizaciones")
    public String organizaciones() {
        return "organizaciones";
    }

    @GetMapping("/sucursales")
    public String sucursales() {
        return "sucursales";
    }

    @GetMapping("/personas")
    public String personas() {
        return "personas";
    }

    @GetMapping("/empleados")
    public String empleados() {
        return "empleados";
    }

    @GetMapping("/marcas")
    public String marcas() {
        return "marcas";
    }

    @GetMapping("/categorias")
    public String categorias() {
        return "categorias";
    }

    @GetMapping("/inventario")
    public String inventario() {
        return "inventario";
    }

    @GetMapping("/ordenes-venta")
    public String ordenesVenta() {
        return "ordenes-venta";
    }

    @GetMapping("/facturas")
    public String facturas() {
        return "facturas";
    }

    @GetMapping("/items-orden-venta")
    public String itemsOrdenVenta() {
        return "items-orden-venta";
    }

    @GetMapping("/items-factura")
    public String itemsFactura() {
        return "items-factura";
    }
}
