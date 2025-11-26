package com.example.saberpro.service;

import com.example.saberpro.model.Alumno;
import com.example.saberpro.model.Beneficio;
import com.example.saberpro.model.Resultado;
import com.example.saberpro.repository.AlumnoRepository;
import com.example.saberpro.repository.ResultadoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EstudianteService {

    @Autowired
    private AlumnoRepository alumnoRepository;

    @Autowired
    private ResultadoRepository resultadoRepository;

    @Autowired
    private BeneficioService beneficioService;

    // Obtener alumno por ID
    public Alumno obtenerAlumnoPorId(Long id) {
        return alumnoRepository.findById(id).orElse(null);
    }

    // Obtener alumno por correo (para login)
    public Alumno obtenerAlumnoPorCorreo(String correo) {
        Optional<Alumno> opt = alumnoRepository.findByCorreo(correo);
        return opt.orElse(null);
    }

    // Obtener lista de resultados por alumno
    public List<Resultado> obtenerResultadosPorAlumno(Long alumnoId) {
        return resultadoRepository.findByAlumnoId(alumnoId);
    }

    // NUEVO: Guardar resultado de prueba Saber T&T
    public Resultado guardarResultadoSaberTT(Long alumnoId, Integer puntajeTotal, String area, Double puntajeArea, String beneficioDescripcion) {
        Alumno alumno = obtenerAlumnoPorId(alumnoId);
        if (alumno == null) {
            throw new RuntimeException("Alumno no encontrado con ID: " + alumnoId);
        }
        
        Resultado resultado = new Resultado();
        resultado.setTipoPrueba("SABER_TT");
        resultado.setPuntajeTotal(puntajeTotal);
        resultado.setArea(area);
        resultado.setPuntaje(puntajeArea);
        resultado.setBeneficioObtenido(beneficioDescripcion);
        resultado.setAlumno(alumno);
        
        return resultadoRepository.save(resultado);
    }

    // NUEVO: Obtener resultado de Saber T&T de un alumno
    public Resultado obtenerResultadoSaberTTPorAlumno(Long alumnoId) {
        // Usar el método con ignore case para mayor robustez
        List<Resultado> resultados = resultadoRepository.findByAlumnoIdAndTipoPruebaIgnoreCase(alumnoId, "SABER_TT");
        
        System.out.println("=== BUSCANDO RESULTADO SABER TT ===");
        System.out.println("Alumno ID: " + alumnoId);
        System.out.println("Resultados encontrados: " + resultados.size());
        
        if (!resultados.isEmpty()) {
            Resultado resultado = resultados.get(0);
            System.out.println("Resultado encontrado - ID: " + resultado.getId());
            System.out.println("Puntaje Total: " + resultado.getPuntajeTotal());
            System.out.println("Tipo Prueba: " + resultado.getTipoPrueba());
            return resultado;
        } else {
            System.out.println("No se encontraron resultados de Saber TT");
            // También intentar con el método original por si acaso
            List<Resultado> resultadosAlt = resultadoRepository.findByAlumnoIdAndTipoPrueba(alumnoId, "SABER_TT");
            if (!resultadosAlt.isEmpty()) {
                return resultadosAlt.get(0);
            }
        }
        
        return null;
    }

    // NUEVO: Verificar si alumno puede graduarse
    public boolean puedeGraduarse(Long alumnoId) {
        Resultado resultadoTT = obtenerResultadoSaberTTPorAlumno(alumnoId);
        if (resultadoTT != null && resultadoTT.getPuntajeTotal() != null) {
            return beneficioService.esPuntajeAprobatorio(resultadoTT.getPuntajeTotal());
        }
        
        // Si no tiene resultado TT, verificar el puntaje del alumno
        Alumno alumno = obtenerAlumnoPorId(alumnoId);
        if (alumno != null && alumno.getPuntajeTotal() != null) {
            return beneficioService.esPuntajeAprobatorio(alumno.getPuntajeTotal().intValue());
        }
        
        return false;
    }

    // NUEVO: Obtener beneficio actual del alumno
    public Beneficio obtenerBeneficioAlumno(Long alumnoId) {
        Resultado resultadoTT = obtenerResultadoSaberTTPorAlumno(alumnoId);
        if (resultadoTT != null && resultadoTT.getPuntajeTotal() != null) {
            return beneficioService.calcularBeneficioSaberTT(resultadoTT.getPuntajeTotal());
        }
        
        // Si no tiene resultado TT, usar el puntaje del alumno
        Alumno alumno = obtenerAlumnoPorId(alumnoId);
        if (alumno != null && alumno.getPuntajeTotal() != null) {
            return beneficioService.calcularBeneficioSaberTT(alumno.getPuntajeTotal().intValue());
        }
        
        return null;
    }

    // NUEVO: Método para migrar puntaje de Alumno a Resultado
    public Resultado migrarPuntajeAResultado(Long alumnoId) {
        System.out.println("=== INICIANDO MIGRACIÓN DE PUNTAJE PARA ALUMNO: " + alumnoId + " ===");
        
        Alumno alumno = obtenerAlumnoPorId(alumnoId);
        if (alumno == null) {
            System.out.println("Alumno no encontrado");
            return null;
        }
        
        System.out.println("Alumno encontrado: " + alumno.getPrimerNombre() + " " + alumno.getPrimerApellido());
        System.out.println("Puntaje total del alumno: " + alumno.getPuntajeTotal());

        if (alumno.getPuntajeTotal() == null) {
            System.out.println("El alumno no tiene puntaje total");
            return null;
        }

        // Verificar si ya existe un resultado de Saber T&T
        Resultado resultadoExistente = obtenerResultadoSaberTTPorAlumno(alumnoId);
        if (resultadoExistente != null) {
            System.out.println("Ya existe un resultado de Saber T&T para este alumno");
            return resultadoExistente;
        }

        // Crear nuevo resultado de Saber T&T
        Resultado resultado = new Resultado();
        resultado.setTipoPrueba("SABER_TT");
        resultado.setPuntajeTotal(alumno.getPuntajeTotal().intValue());
        resultado.setArea("Saber T&T - Total");
        resultado.setPuntaje(alumno.getPuntajeTotal());
        resultado.setAlumno(alumno);
        
        // Calcular beneficio para la descripción
        Beneficio beneficio = beneficioService.calcularBeneficioSaberTT(alumno.getPuntajeTotal().intValue());
        if (beneficio != null) {
            resultado.setBeneficioObtenido(beneficio.getDescripcion());
            System.out.println("Beneficio calculado: " + beneficio.getDescripcion());
        } else {
            resultado.setBeneficioObtenido("Sin beneficio aplicable");
            System.out.println("No se aplica beneficio para puntaje: " + alumno.getPuntajeTotal());
        }

        Resultado resultadoGuardado = resultadoRepository.save(resultado);
        System.out.println("Resultado guardado exitosamente con ID: " + resultadoGuardado.getId());
        
        return resultadoGuardado;
    }

    // Mensaje para el alumno sobre beneficios o repetir examen
    public String obtenerMensajeBeneficio(Alumno alumno) {
        if (alumno == null) {
            return "Alumno no encontrado.";
        }

        // Buscar resultado de Saber T&T
        Resultado resultadoTT = obtenerResultadoSaberTTPorAlumno(alumno.getId());
        
        Integer puntajeTotal = null;
        
        if (resultadoTT != null && resultadoTT.getPuntajeTotal() != null) {
            puntajeTotal = resultadoTT.getPuntajeTotal();
        } else if (alumno.getPuntajeTotal() != null) {
            puntajeTotal = alumno.getPuntajeTotal().intValue();
        }

        if (puntajeTotal == null) {
            return "Resultado de Saber T&T aún no registrado.";
        }

        // Verificar puntaje mínimo para graduación
        if (puntajeTotal < 80) {
            return "No alcanzó el puntaje mínimo de 80 puntos. Debe volver a presentar las pruebas Saber T&T.";
        }

        // Calcular beneficio
        Beneficio beneficio = beneficioService.calcularBeneficioSaberTT(puntajeTotal);
        
        if (beneficio != null && beneficio.getDescripcion() != null) {
            return "¡Felicidades! " + beneficio.getDescripcion();
        } else {
            return "Puntaje aprobatorio. Puede graduarse pero no aplica para beneficios adicionales (beneficios desde 120 puntos).";
        }
    }

    // NUEVO: Actualizar alumno
    public Alumno actualizarAlumno(Alumno alumno) {
        return alumnoRepository.save(alumno);
    }

    // NUEVO: Eliminar resultado
    public void eliminarResultado(Long resultadoId) {
        resultadoRepository.deleteById(resultadoId);
    }
}