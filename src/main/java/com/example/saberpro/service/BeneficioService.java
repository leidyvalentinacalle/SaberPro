package com.example.saberpro.service;

import com.example.saberpro.model.Beneficio;
import com.example.saberpro.repository.BeneficioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BeneficioService {

    @Autowired
    private BeneficioRepository beneficioRepository;

    // Listar todos los beneficios
    public List<Beneficio> listarBeneficios() {
        return beneficioRepository.findAll();
    }

    // Obtener beneficios para un puntaje dado (método existente mejorado)
    public List<Beneficio> obtenerBeneficiosPorPuntaje(Double puntaje) {
        return beneficioRepository.findAll().stream()
                .filter(b -> puntaje >= b.getMinimoPuntaje() && puntaje <= b.getMaximoPuntaje())
                .toList();
    }

    // CORREGIDO: Calcular beneficio específico para Saber T&T consultando la base de datos
    public Beneficio calcularBeneficioSaberTT(int puntaje) {
        // Primero buscar en la base de datos
        List<Beneficio> beneficios = beneficioRepository.findByPuntajeAndTipoPrueba(puntaje, "SABER_TT");
        
        if (!beneficios.isEmpty()) {
            return beneficios.get(0); // Retorna el primer beneficio que cumple
        }
        
        // Si no encuentra beneficio en la base de datos, verificar casos especiales
        if (puntaje < 80) {
            return crearBeneficioNoAprobatorio();
        } else {
            return crearBeneficioSinBeneficio();
        }
    }

    // NUEVO: Buscar beneficios por tipo de prueba
    public List<Beneficio> obtenerBeneficiosPorTipo(String tipoPrueba) {
        return beneficioRepository.findByTipoPrueba(tipoPrueba);
    }

    // Verificar si el puntaje es aprobatorio (>= 80 puntos)
    public boolean esPuntajeAprobatorio(int puntaje) {
        return puntaje >= 80;
    }

    // Obtener beneficio por ID
    public Optional<Beneficio> obtenerBeneficioPorId(Long id) {
        return beneficioRepository.findById(id);
    }

    // Guardar beneficio
    public Beneficio guardarBeneficio(Beneficio beneficio) {
        return beneficioRepository.save(beneficio);
    }

    // Eliminar beneficio
    public void eliminarBeneficio(Long id) {
        beneficioRepository.deleteById(id);
    }

    // Beneficio para puntaje no aprobatorio
    private Beneficio crearBeneficioNoAprobatorio() {
        Beneficio beneficio = new Beneficio();
        beneficio.setTipoPrueba("SABER_TT");
        beneficio.setDescripcion("Puntaje insuficiente. No podrá graduarse según el Acuerdo Institucional. Puntaje mínimo requerido: 80 puntos");
        beneficio.setNotaAsignada(0.0);
        beneficio.setPorcentajeBeca(0.0);
        beneficio.setMinimoPuntaje(0.0);
        beneficio.setMaximoPuntaje(79.0);
        return beneficio;
    }

    // Beneficio para puntaje aprobatorio pero sin beneficios adicionales
    private Beneficio crearBeneficioSinBeneficio() {
        Beneficio beneficio = new Beneficio();
        beneficio.setTipoPrueba("SABER_TT");
        beneficio.setDescripcion("Puntaje aprobatorio. Puede graduarse pero no aplica para beneficios adicionales. Los beneficios inician desde 120 puntos");
        beneficio.setNotaAsignada(0.0);
        beneficio.setPorcentajeBeca(0.0);
        beneficio.setMinimoPuntaje(80.0);
        beneficio.setMaximoPuntaje(119.0);
        return beneficio;
    }

    // Inicializar beneficios en la base de datos (útil para data inicial)
    public void inicializarBeneficiosSaberTT() {
        // Solo crear si no existen beneficios de Saber T&T
        List<Beneficio> beneficiosExistentes = beneficioRepository.findByTipoPrueba("SABER_TT");
        if (beneficiosExistentes.isEmpty()) {
            List<Beneficio> beneficios = List.of(
                new Beneficio("SABER_TT", 120.0, 150.0, 
                    "Se exonera de la entrega del informe final de trabajo de grado, o de realizar Seminario de grado II, con nota de cuatro punto cinco (4.5)", 
                    4.5, 0.0),
                new Beneficio("SABER_TT", 151.0, 170.0, 
                    "Se exonera de la entrega del informe final de trabajo de grado, o de realizar Seminario de grado II, con nota de cuatro punto siete (4.7). Además, se beca con un 50% el valor de derechos de grado", 
                    4.7, 50.0),
                new Beneficio("SABER_TT", 171.0, 200.0, 
                    "Se exonera de la entrega del informe final de trabajo de grado, o de realizar Seminario de grado II, con nota de cinco punto cero (5.0). Además, se beca con un 100% el valor de derechos de grado", 
                    5.0, 100.0)
            );
            beneficioRepository.saveAll(beneficios);
        }
    }

    // NUEVO: Verificar si la base de datos tiene beneficios
    public boolean tieneBeneficios() {
        return beneficioRepository.count() > 0;
    }
}