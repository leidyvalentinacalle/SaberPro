package com.example.saberpro.controller;

import com.example.saberpro.model.Alumno;
import com.example.saberpro.service.EstudianteService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    @Autowired
    private EstudianteService estudianteService;

    @GetMapping("/")
    public String root() {
        System.out.println(">>> Entró a / (root), redirigiendo a /login");
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        System.out.println(">>> Entró a GET /login, devolviendo vista login.jsp");
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(@RequestParam("correo") String correo,
                                @RequestParam("tipo") String tipo,
                                HttpSession session,
                                Model model) {

        // Login coordinador (solo por rol y correo, sin validar contraseña)
        if ("COORDINADOR".equals(tipo)) {
            session.setAttribute("rol", "COORDINADOR");
            session.setAttribute("correo", correo);
            return "redirect:/coordinador/dashboard";
        }

        // Login estudiante
        if ("ESTUDIANTE".equals(tipo)) {
            Alumno alumno = estudianteService.obtenerAlumnoPorCorreo(correo);
            if (alumno != null) {
                session.setAttribute("rol", "ESTUDIANTE");
                session.setAttribute("usuario", alumno);
                return "redirect:/estudiante/dashboard";
            } else {
                model.addAttribute("error", "No se encontró alumno con ese correo.");
                return "login";
            }
        }

        model.addAttribute("error", "Seleccione un tipo de usuario válido.");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
