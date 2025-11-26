package com.example.saberpro.repository;

import com.example.saberpro.model.Resultado;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ResultadoRepository extends JpaRepository<Resultado, Long> {

    // Buscar todos los resultados de un alumno
    List<Resultado> findByAlumnoId(Long alumnoId);

    // CORRECCIÓN: Buscar resultados por alumno y tipo de prueba
    List<Resultado> findByAlumnoIdAndTipoPrueba(Long alumnoId, String tipoPrueba);

    // CORRECCIÓN: Buscar el resultado más reciente de Saber T&T de un alumno
    @Query("SELECT r FROM Resultado r WHERE r.alumno.id = :alumnoId AND r.tipoPrueba = 'SABER_TT' ORDER BY r.id DESC")
    List<Resultado> findLatestSaberTTByAlumnoId(@Param("alumnoId") Long alumnoId);

    // Buscar resultados por tipo de prueba
    List<Resultado> findByTipoPrueba(String tipoPrueba);

    // Buscar resultados por rango de puntaje total
    List<Resultado> findByPuntajeTotalBetween(Integer minPuntaje, Integer maxPuntaje);

    // Buscar resultados por puntaje total mayor o igual
    List<Resultado> findByPuntajeTotalGreaterThanEqual(Integer puntaje);

    // Buscar resultados por puntaje total menor o igual
    List<Resultado> findByPuntajeTotalLessThanEqual(Integer puntaje);

    // Verificar si un alumno tiene resultado de Saber T&T
    boolean existsByAlumnoIdAndTipoPrueba(Long alumnoId, String tipoPrueba);

    // Contar resultados de Saber T&T por alumno
    long countByAlumnoIdAndTipoPrueba(Long alumnoId, String tipoPrueba);

    // Buscar resultados con beneficio obtenido (no nulo)
    List<Resultado> findByBeneficioObtenidoIsNotNull();

    // Buscar resultados con beneficio obtenido nulo
    List<Resultado> findByBeneficioObtenidoIsNull();

    // Buscar resultados por alumno y área específica
    List<Resultado> findByAlumnoIdAndArea(Long alumnoId, String area);

    // Buscar el mejor resultado de Saber T&T de un alumno
    @Query("SELECT r FROM Resultado r WHERE r.alumno.id = :alumnoId AND r.tipoPrueba = 'SABER_TT' ORDER BY r.puntajeTotal DESC")
    List<Resultado> findBestSaberTTByAlumnoId(@Param("alumnoId") Long alumnoId);

    // Obtener puntaje máximo de Saber T&T de un alumno
    @Query("SELECT MAX(r.puntajeTotal) FROM Resultado r WHERE r.alumno.id = :alumnoId AND r.tipoPrueba = 'SABER_TT'")
    Optional<Integer> findMaxPuntajeSaberTTByAlumnoId(@Param("alumnoId") Long alumnoId);

    // Obtener promedio de puntajes Saber T&T por alumno
    @Query("SELECT AVG(r.puntajeTotal) FROM Resultado r WHERE r.alumno.id = :alumnoId AND r.tipoPrueba = 'SABER_TT'")
    Optional<Double> findAveragePuntajeSaberTTByAlumnoId(@Param("alumnoId") Long alumnoId);

    // Eliminar todos los resultados de un alumno
    void deleteByAlumnoId(Long alumnoId);

    // Eliminar resultados de un alumno por tipo de prueba
    void deleteByAlumnoIdAndTipoPrueba(Long alumnoId, String tipoPrueba);

    // CORRECCIÓN: Método alternativo si los anteriores no funcionan
    @Query("SELECT r FROM Resultado r WHERE r.alumno.id = :alumnoId AND LOWER(r.tipoPrueba) = LOWER(:tipoPrueba)")
    List<Resultado> findByAlumnoIdAndTipoPruebaIgnoreCase(@Param("alumnoId") Long alumnoId, @Param("tipoPrueba") String tipoPrueba);
}