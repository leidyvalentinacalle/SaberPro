package com.example.saberpro.controller;

import com.example.saberpro.model.Alumno;
import com.example.saberpro.model.Beneficio;
import com.example.saberpro.model.Resultado;
import com.example.saberpro.service.CoordinadorService;
import com.example.saberpro.service.EstudianteService;
import com.example.saberpro.service.BeneficioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/coordinador")
public class CoordinadorController {

    @Autowired
    private CoordinadorService coordinadorService;

    @Autowired
    private EstudianteService estudianteService;

    @Autowired
    private BeneficioService beneficioService;

    // Dashboard con estadísticas y listado completo de alumnos
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // Opcional: validar que haya sesión de coordinador
        String rol = (String) session.getAttribute("rol");
        if (rol == null || !"COORDINADOR".equals(rol)) {
            return "redirect:/login";
        }

        // Estadísticas
        long totalAlumnos = coordinadorService.countAlumnos();
        double promedioPuntaje = coordinadorService.promedioPuntajeAlumnos();

        model.addAttribute("totalAlumnos", totalAlumnos);
        model.addAttribute("promedioPuntaje", promedioPuntaje);

        // Listado de alumnos para la tabla del dashboard
        List<Alumno> alumnos = coordinadorService.listarAlumnos();
        model.addAttribute("alumnos", alumnos);

        return "dashboard_coordinador";
    }

    // Redirigir listado a la misma pantalla de dashboard
    @GetMapping("/alumnos")
    public String listarAlumnos() {
        return "redirect:/coordinador/dashboard";
    }

    // Formulario nuevo alumno
    @GetMapping("/alumnos/nuevo")
    public String formularioCrearAlumno(Model model) {
        model.addAttribute("alumno", new Alumno());
        return "alumno_form";
    }

    // CORRECCIÓN: Guardar alumno con manejo de errores mejorado
    @PostMapping("/alumnos")
    public String guardarAlumno(@ModelAttribute Alumno alumno, Model model, HttpSession session) {
        try {
            // Validar sesión
            String rol = (String) session.getAttribute("rol");
            if (rol == null || !"COORDINADOR".equals(rol)) {
                return "redirect:/login";
            }

            // Para nuevo alumno, asegurar que el ID sea null
            alumno.setId(null);

            // Guardar usando el servicio que ahora valida duplicados
            coordinadorService.guardarAlumno(alumno);
            return "redirect:/coordinador/dashboard";
            
        } catch (RuntimeException e) {
            // Capturar errores de validación del servicio (documento/correo duplicados)
            model.addAttribute("error", e.getMessage());
            model.addAttribute("alumno", alumno);
            return "alumno_form";
        } catch (Exception e) {
            // Capturar cualquier otro error, incluyendo DataIntegrityViolationException
            String errorMessage = "Error al guardar el alumno: ";
            
            // Verificar si es error de duplicados
            if (e.getMessage() != null) {
                if (e.getMessage().contains("duplicate key") || e.getMessage().contains("unique constraint")) {
                    if (e.getMessage().contains("numero_documento") || e.getMessage().contains("numeroDocumento")) {
                        errorMessage = "Ya existe un alumno con ese número de documento.";
                    } else if (e.getMessage().contains("correo")) {
                        errorMessage = "Ya existe un alumno con ese correo electrónico.";
                    } else {
                        errorMessage = "Los datos ya existen en el sistema. Verifique el documento y correo.";
                    }
                } else {
                    errorMessage += e.getMessage();
                }
            } else {
                errorMessage += "Error desconocido.";
            }
            
            model.addAttribute("error", errorMessage);
            model.addAttribute("alumno", alumno);
            return "alumno_form";
        }
    }

    // Formulario editar alumno
    @GetMapping("/alumnos/editar/{id}")
    public String formularioEditarAlumno(@PathVariable Long id, Model model, HttpSession session) {
        // Validar sesión
        String rol = (String) session.getAttribute("rol");
        if (rol == null || !"COORDINADOR".equals(rol)) {
            return "redirect:/login";
        }

        Alumno alumno = coordinadorService.obtenerAlumnoPorId(id);
        if (alumno == null) {
            return "redirect:/coordinador/dashboard";
        }
        model.addAttribute("alumno", alumno);
        return "alumno_form";
    }

    // CORRECCIÓN: Guardar edición de alumno
    @PostMapping("/alumnos/editar")
    public String guardarEdicionAlumno(@ModelAttribute Alumno alumno, Model model, HttpSession session) {
        try {
            // Validar sesión
            String rol = (String) session.getAttribute("rol");
            if (rol == null || !"COORDINADOR".equals(rol)) {
                return "redirect:/login";
            }

            // Guardar usando el servicio (el ID ya viene en el objeto alumno)
            coordinadorService.guardarAlumno(alumno);
            return "redirect:/coordinador/dashboard";
            
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("alumno", alumno);
            return "alumno_form";
        } catch (Exception e) {
            model.addAttribute("error", "Error al actualizar el alumno: " + e.getMessage());
            model.addAttribute("alumno", alumno);
            return "alumno_form";
        }
    }

    // Eliminar alumno
    @GetMapping("/alumnos/eliminar/{id}")
    public String eliminarAlumno(@PathVariable Long id, HttpSession session) {
        // Validar sesión
        String rol = (String) session.getAttribute("rol");
        if (rol == null || !"COORDINADOR".equals(rol)) {
            return "redirect:/login";
        }

        coordinadorService.eliminarAlumno(id);
        return "redirect:/coordinador/dashboard";
    }

    // Informe detallado del alumno con beneficios
    @GetMapping("/alumnos/informe/{id}")
    public String informeAlumno(@PathVariable Long id, Model model, HttpSession session) {
        // Validar sesión
        String rol = (String) session.getAttribute("rol");
        if (rol == null || !"COORDINADOR".equals(rol)) {
            return "redirect:/login";
        }

        Alumno alumno = coordinadorService.obtenerAlumnoPorId(id);
        if (alumno == null) {
            return "redirect:/coordinador/dashboard";
        }

        // Migrar puntaje si es necesario
        if (alumno.getPuntajeTotal() != null) {
            estudianteService.migrarPuntajeAResultado(id);
        }

        List<Resultado> resultados = estudianteService.obtenerResultadosPorAlumno(id);
        Resultado resultadoTT = estudianteService.obtenerResultadoSaberTTPorAlumno(id);

        Beneficio beneficio = null;
        if (resultadoTT != null && resultadoTT.getPuntajeTotal() != null) {
            beneficio = beneficioService.calcularBeneficioSaberTT(resultadoTT.getPuntajeTotal());
        } else if (alumno.getPuntajeTotal() != null) {
            beneficio = beneficioService.calcularBeneficioSaberTT(alumno.getPuntajeTotal().intValue());
        }

        model.addAttribute("alumno", alumno);
        model.addAttribute("beneficio", beneficio);
        model.addAttribute("resultadoTT", resultadoTT);
        model.addAttribute("resultados", resultados);

        return "alumno_informe";
    }
}