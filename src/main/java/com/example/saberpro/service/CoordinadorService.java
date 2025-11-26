package com.example.saberpro.service;

import com.example.saberpro.model.Alumno;
import com.example.saberpro.model.Beneficio;
import com.example.saberpro.repository.AlumnoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CoordinadorService {

    @Autowired
    private AlumnoRepository alumnoRepository;

    @Autowired
    private BeneficioService beneficioService;

    // Listar todos los alumnos
    public List<Alumno> listarAlumnos() {
        return alumnoRepository.findAll();
    }

    // CORRECCIÓN COMPLETA: Guardar alumno con validación de duplicados
    public Alumno guardarAlumno(Alumno alumno) {
        // Validar campos obligatorios
        if (alumno.getNumeroDocumento() == null || alumno.getNumeroDocumento().trim().isEmpty()) {
            throw new RuntimeException("El número de documento es obligatorio");
        }
        
        if (alumno.getPrimerNombre() == null || alumno.getPrimerNombre().trim().isEmpty()) {
            throw new RuntimeException("El primer nombre es obligatorio");
        }
        
        if (alumno.getPrimerApellido() == null || alumno.getPrimerApellido().trim().isEmpty()) {
            throw new RuntimeException("El primer apellido es obligatorio");
        }
        
        if (alumno.getCorreo() == null || alumno.getCorreo().trim().isEmpty()) {
            throw new RuntimeException("El correo electrónico es obligatorio");
        }

        // Verificar duplicados para NUEVO alumno (ID null)
        if (alumno.getId() == null) {
            // Verificar documento duplicado
            if (alumnoRepository.existsByNumeroDocumento(alumno.getNumeroDocumento())) {
                throw new RuntimeException("Ya existe un alumno con el documento: " + alumno.getNumeroDocumento());
            }
            
            // Verificar correo duplicado
            if (alumnoRepository.existsByCorreo(alumno.getCorreo())) {
                throw new RuntimeException("Ya existe un alumno con el correo: " + alumno.getCorreo());
            }
            
            // Asegurar que el ID sea null para nuevo registro
            alumno.setId(null);
        } 
        // Verificar duplicados para EDICIÓN de alumno (ID no null)
        else {
            // CORRECCIÓN: Usar Optional correctamente - línea 62
            Optional<Alumno> existentePorDocumento = alumnoRepository.findByNumeroDocumento(alumno.getNumeroDocumento());
            if (existentePorDocumento.isPresent() && !existentePorDocumento.get().getId().equals(alumno.getId())) {
                throw new RuntimeException("Ya existe otro alumno con el documento: " + alumno.getNumeroDocumento());
            }
            
            // CORRECCIÓN: Usar Optional correctamente - línea 68
            Optional<Alumno> existentePorCorreo = alumnoRepository.findByCorreo(alumno.getCorreo());
            if (existentePorCorreo.isPresent() && !existentePorCorreo.get().getId().equals(alumno.getId())) {
                throw new RuntimeException("Ya existe otro alumno con el correo: " + alumno.getCorreo());
            }
        }

        return alumnoRepository.save(alumno);
    }

    // Obtener alumno por id
    public Alumno obtenerAlumnoPorId(Long id) {
        return alumnoRepository.findById(id).orElse(null);
    }

    // Eliminar alumno por id
    public void eliminarAlumno(Long id) {
        alumnoRepository.deleteById(id);
    }

    // Contar total alumnos
    public long countAlumnos() {
        return alumnoRepository.count();
    }

    // Promedio de puntaje total de alumnos (solo alumnos con puntaje)
    public double promedioPuntajeAlumnos() {
        List<Alumno> alumnos = alumnoRepository.findAll();
        long count = alumnos.stream()
                .filter(a -> a.getPuntajeTotal() != null && a.getPuntajeTotal() > 0)
                .count();
                
        if (count == 0) return 0.0;
        
        double suma = alumnos.stream()
                .filter(a -> a.getPuntajeTotal() != null && a.getPuntajeTotal() > 0)
                .mapToDouble(Alumno::getPuntajeTotal)
                .sum();
                
        return suma / count;
    }

    // Obtener beneficios aplicables para un alumno según puntaje total
    public List<Beneficio> obtenerBeneficiosAlumno(Alumno alumno) {
        if (alumno.getPuntajeTotal() == null) return List.of();
        return beneficioService.obtenerBeneficiosPorPuntaje(alumno.getPuntajeTotal());
    }

    // Obtener beneficio individual calculado
    public Beneficio obtenerBeneficioCalculado(Alumno alumno) {
        if (alumno.getPuntajeTotal() == null) return null;
        return beneficioService.calcularBeneficioSaberTT(alumno.getPuntajeTotal().intValue());
    }

    // NUEVO: Buscar alumno por documento
    public Alumno buscarPorDocumento(String numeroDocumento) {
        return alumnoRepository.findByNumeroDocumento(numeroDocumento).orElse(null);
    }

    // NUEVO: Buscar alumno por correo
    public Alumno buscarPorCorreo(String correo) {
        return alumnoRepository.findByCorreo(correo).orElse(null);
    }
}