package com.example.saberpro.controller;

import com.example.saberpro.model.Alumno;
import com.example.saberpro.model.Beneficio;
import com.example.saberpro.model.Resultado;
import com.example.saberpro.service.BeneficioService;
import com.example.saberpro.service.EstudianteService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/estudiante")
public class EstudianteController {

    @Autowired
    private EstudianteService estudianteService;

    @Autowired
    private BeneficioService beneficioService;

    // Dashboard del estudiante con su info y resultados
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // Verificar sesión
        Alumno alumnoSesion = (Alumno) session.getAttribute("usuario");
        if (alumnoSesion == null) {
            return "redirect:/login";
        }

        // Cargar datos completos del alumno desde la BD
        Alumno alumnoCompleto = estudianteService.obtenerAlumnoPorId(alumnoSesion.getId());
        if (alumnoCompleto == null) {
            model.addAttribute("mensajeError", "No se encontró información del alumno.");
            return "dashboard_estudiante";
        }

        // Alumno para la vista
        model.addAttribute("alumno", alumnoCompleto);

        // Resultados del alumno
        List<Resultado> resultados = estudianteService.obtenerResultadosPorAlumno(alumnoCompleto.getId());
        model.addAttribute("resultados", resultados);

        // Calcular beneficio
        Beneficio beneficio = calcularBeneficioAlumno(alumnoCompleto, resultados);
        model.addAttribute("beneficio", beneficio);

        // Mensaje de beneficio
        String mensajeBeneficio = estudianteService.obtenerMensajeBeneficio(alumnoCompleto);
        model.addAttribute("mensajeBeneficio", mensajeBeneficio);

        return "dashboard_estudiante";
    }

    // Página para registrar resultados
    @GetMapping("/registrar-resultado")
    public String mostrarFormularioResultado(HttpSession session, Model model) {
        Alumno alumnoSesion = (Alumno) session.getAttribute("usuario");
        if (alumnoSesion == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("alumno", alumnoSesion);
        return "alumno_form";
    }

    // Procesar registro de resultados - VERSIÓN SIMPLIFICADA
    @PostMapping("/procesar-resultado")
    public String procesarResultado(
            @RequestParam("puntajeTotal") int puntajeTotal,
            @RequestParam("area") String area,
            @RequestParam("puntajeArea") double puntajeArea,
            HttpSession session,
            Model model) {
        
        Alumno alumnoSesion = (Alumno) session.getAttribute("usuario");
        if (alumnoSesion == null) {
            return "redirect:/login";
        }

        try {
            // 1. Calcular beneficio
            Beneficio beneficio = beneficioService.calcularBeneficioSaberTT(puntajeTotal);
            
            // 2. Guardar resultado en base de datos
            Resultado resultadoGuardado = estudianteService.guardarResultadoSaberTT(
                alumnoSesion.getId(), 
                puntajeTotal, 
                area, 
                puntajeArea, 
                beneficio != null ? beneficio.getDescripcion() : "Sin beneficio"
            );
            
            // 3. Preparar datos para la vista
            model.addAttribute("alumno", alumnoSesion);
            model.addAttribute("beneficio", beneficio);
            model.addAttribute("puntajeRegistrado", puntajeTotal);
            model.addAttribute("mensajeExito", "¡Resultado registrado exitosamente!");
            
            // 4. Agregar resultados actualizados
            List<Resultado> resultados = estudianteService.obtenerResultadosPorAlumno(alumnoSesion.getId());
            model.addAttribute("resultados", resultados);
            
        } catch (Exception e) {
            model.addAttribute("mensajeError", "Error al registrar resultado: " + e.getMessage());
            e.printStackTrace(); // Para debug
        }

        return "dashboard_estudiante";
    }

    // Página para ver detalles del beneficio
    @GetMapping("/beneficio-detalle")
    public String verDetalleBeneficio(HttpSession session, Model model) {
        Alumno alumnoSesion = (Alumno) session.getAttribute("usuario");
        if (alumnoSesion == null) {
            return "redirect:/login";
        }

        Alumno alumnoCompleto = estudianteService.obtenerAlumnoPorId(alumnoSesion.getId());
        
        System.out.println("=== INICIANDO BENEFICIO-DETALLE ===");
        System.out.println("Alumno: " + alumnoCompleto.getPrimerNombre() + " " + alumnoCompleto.getPrimerApellido());
        System.out.println("Puntaje Total: " + alumnoCompleto.getPuntajeTotal());
        
        // Migrar puntaje si es necesario
        if (alumnoCompleto.getPuntajeTotal() != null) {
            System.out.println("Migrando puntaje...");
            Resultado resultadoMigrado = estudianteService.migrarPuntajeAResultado(alumnoCompleto.getId());
            if (resultadoMigrado != null) {
                System.out.println("Puntaje migrado exitosamente: " + resultadoMigrado.getPuntajeTotal());
            } else {
                System.out.println("No se pudo migrar el puntaje");
            }
        }
        
        // Obtener resultados actualizados
        List<Resultado> resultados = estudianteService.obtenerResultadosPorAlumno(alumnoCompleto.getId());
        System.out.println("Total de resultados: " + resultados.size());
        
        // Buscar específicamente el resultado de Saber T&T
        Resultado resultadoTT = estudianteService.obtenerResultadoSaberTTPorAlumno(alumnoCompleto.getId());
        System.out.println("Resultado TT encontrado: " + (resultadoTT != null));
        
        Beneficio beneficio = null;
        if (resultadoTT != null && resultadoTT.getPuntajeTotal() != null) {
            System.out.println("Calculando beneficio para puntaje: " + resultadoTT.getPuntajeTotal());
            beneficio = beneficioService.calcularBeneficioSaberTT(resultadoTT.getPuntajeTotal());
        } else if (alumnoCompleto.getPuntajeTotal() != null) {
            System.out.println("Usando puntaje del alumno: " + alumnoCompleto.getPuntajeTotal());
            beneficio = beneficioService.calcularBeneficioSaberTT(alumnoCompleto.getPuntajeTotal().intValue());
        }
        
        System.out.println("Beneficio calculado: " + (beneficio != null ? beneficio.getDescripcion() : "null"));
        
        model.addAttribute("alumno", alumnoCompleto);
        model.addAttribute("beneficio", beneficio);
        model.addAttribute("resultadoTT", resultadoTT);
        model.addAttribute("resultados", resultados);
        
        return "alumno_informe";
    }

    // Verificar elegibilidad para graduación
    @GetMapping("/verificar-graduacion")
    public String verificarGraduacion(HttpSession session, Model model) {
        Alumno alumnoSesion = (Alumno) session.getAttribute("usuario");
        if (alumnoSesion == null) {
            return "redirect:/login";
        }

        Alumno alumnoCompleto = estudianteService.obtenerAlumnoPorId(alumnoSesion.getId());
        
        boolean puedeGraduarse = estudianteService.puedeGraduarse(alumnoCompleto.getId());
        String mensajeGraduacion = estudianteService.obtenerMensajeBeneficio(alumnoCompleto);
        
        Resultado resultadoTT = estudianteService.obtenerResultadoSaberTTPorAlumno(alumnoCompleto.getId());
        
        model.addAttribute("alumno", alumnoCompleto);
        model.addAttribute("puedeGraduarse", puedeGraduarse);
        model.addAttribute("mensajeGraduacion", mensajeGraduacion);
        model.addAttribute("resultadoTT", resultadoTT);
        
        return "verificar_graduacion";
    }

    // Método auxiliar para calcular beneficio del alumno
    private Beneficio calcularBeneficioAlumno(Alumno alumno, List<Resultado> resultados) {
        // Primero buscar en resultados
        if (resultados != null && !resultados.isEmpty()) {
            for (Resultado resultado : resultados) {
                if (resultado.getTipoPrueba() != null && 
                    resultado.getTipoPrueba().equalsIgnoreCase("SABER_TT") &&
                    resultado.getPuntajeTotal() != null) {
                    
                    return beneficioService.calcularBeneficioSaberTT(resultado.getPuntajeTotal());
                }
            }
        }
        
        // Si no encuentra en resultados, usar el puntaje del alumno
        if (alumno.getPuntajeTotal() != null) {
            return beneficioService.calcularBeneficioSaberTT(alumno.getPuntajeTotal().intValue());
        }
        
        return null;
    }
}