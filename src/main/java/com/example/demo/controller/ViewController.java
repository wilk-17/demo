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

    @GetMapping("/estados")
    public String estados() {
        return "estados";
    }

    @GetMapping("/ciudades")
    public String ciudades() {
        return "ciudades";
    }
}
