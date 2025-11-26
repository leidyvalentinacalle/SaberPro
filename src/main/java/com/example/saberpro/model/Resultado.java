package com.example.saberpro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "resultados")
public class Resultado {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String area;           // Área del resultado (ej. Comunicación Escrita, Razonamiento Cuantitativo)
    private Double puntaje;        // Puntaje obtenido en esa área
    
    // NUEVOS CAMPOS PARA SABER T&T
    private String tipoPrueba;     // "SABER_TT" o "SABER_PRO"
    private Integer puntajeTotal;  // Puntaje total de la prueba (0-200 para Saber T&T)
    private String beneficioObtenido; // Descripción del beneficio obtenido

    @ManyToOne
    @JoinColumn(name = "alumno_id")
    private Alumno alumno;

    // Constructores
    public Resultado() {
    }
    
    public Resultado(String tipoPrueba, Integer puntajeTotal, String area, Double puntajeArea, Alumno alumno) {
        this.tipoPrueba = tipoPrueba;
        this.puntajeTotal = puntajeTotal;
        this.area = area;
        this.puntaje = puntajeArea;
        this.alumno = alumno;
    }

    // Getters y setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public Double getPuntaje() {
        return puntaje;
    }

    public void setPuntaje(Double puntaje) {
        this.puntaje = puntaje;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public String getTipoPrueba() {
        return tipoPrueba;
    }

    public void setTipoPrueba(String tipoPrueba) {
        this.tipoPrueba = tipoPrueba;
    }

    public Integer getPuntajeTotal() {
        return puntajeTotal;
    }

    public void setPuntajeTotal(Integer puntajeTotal) {
        this.puntajeTotal = puntajeTotal;
    }

    public String getBeneficioObtenido() {
        return beneficioObtenido;
    }

    public void setBeneficioObtenido(String beneficioObtenido) {
        this.beneficioObtenido = beneficioObtenido;
    }
    
    // Método toString para debugging
    @Override
    public String toString() {
        return "Resultado{" +
                "id=" + id +
                ", area='" + area + '\'' +
                ", puntaje=" + puntaje +
                ", tipoPrueba='" + tipoPrueba + '\'' +
                ", puntajeTotal=" + puntajeTotal +
                ", beneficioObtenido='" + beneficioObtenido + '\'' +
                '}';
    }
}