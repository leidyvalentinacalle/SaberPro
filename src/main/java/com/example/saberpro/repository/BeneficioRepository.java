package com.example.saberpro.repository;

import com.example.saberpro.model.Beneficio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BeneficioRepository extends JpaRepository<Beneficio, Long> {

    // Buscar beneficios por tipo de prueba
    List<Beneficio> findByTipoPrueba(String tipoPrueba);

    // Buscar beneficios por rango de puntaje y tipo de prueba
    @Query("SELECT b FROM Beneficio b WHERE b.tipoPrueba = :tipoPrueba AND :puntaje BETWEEN b.minimoPuntaje AND b.maximoPuntaje")
    List<Beneficio> findByPuntajeAndTipoPrueba(@Param("puntaje") int puntaje, @Param("tipoPrueba") String tipoPrueba);

    // Buscar beneficios por puntaje mínimo
    List<Beneficio> findByMinimoPuntajeLessThanEqual(Double puntaje);

    // Buscar beneficios por puntaje máximo
    List<Beneficio> findByMaximoPuntajeGreaterThanEqual(Double puntaje);
}