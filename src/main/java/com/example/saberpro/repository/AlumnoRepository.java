package com.example.saberpro.repository;

import com.example.saberpro.model.Alumno;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AlumnoRepository extends JpaRepository<Alumno, Long> {

    // Buscar alumno por correo
    Optional<Alumno> findByCorreo(String correo);

    // NUEVO: Buscar alumno por número de documento
    Optional<Alumno> findByNumeroDocumento(String numeroDocumento);

    // NUEVO: Verificar si existe por documento
    boolean existsByNumeroDocumento(String numeroDocumento);

    // NUEVO: Verificar si existe por correo
    boolean existsByCorreo(String correo);

    // NUEVO: Contar alumnos con puntaje
    long countByPuntajeTotalIsNotNull();
}