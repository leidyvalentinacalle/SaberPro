package com.example.saberpro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "beneficios")
public class Beneficio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 255) // Ajustar según el tamaño de tu columna en la base de datos
    private String descripcion;

    private Double minimoPuntaje;
    private Double maximoPuntaje;
    private String tipoPrueba;
    private Double notaAsignada;
    private Double porcentajeBeca;

    // Constructores
    public Beneficio() {
    }

    public Beneficio(String tipoPrueba, Double minimoPuntaje, Double maximoPuntaje, 
                    String descripcion, Double notaAsignada, Double porcentajeBeca) {
        this.tipoPrueba = tipoPrueba;
        this.minimoPuntaje = minimoPuntaje;
        this.maximoPuntaje = maximoPuntaje;
        this.descripcion = descripcion;
        this.notaAsignada = notaAsignada;
        this.porcentajeBeca = porcentajeBeca;
    }

    // Getters y setters (permanecen igual)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Double getMinimoPuntaje() {
        return minimoPuntaje;
    }

    public void setMinimoPuntaje(Double minimoPuntaje) {
        this.minimoPuntaje = minimoPuntaje;
    }

    public Double getMaximoPuntaje() {
        return maximoPuntaje;
    }

    public void setMaximoPuntaje(Double maximoPuntaje) {
        this.maximoPuntaje = maximoPuntaje;
    }

    public String getTipoPrueba() {
        return tipoPrueba;
    }

    public void setTipoPrueba(String tipoPrueba) {
        this.tipoPrueba = tipoPrueba;
    }

    public Double getNotaAsignada() {
        return notaAsignada;
    }

    public void setNotaAsignada(Double notaAsignada) {
        this.notaAsignada = notaAsignada;
    }

    public Double getPorcentajeBeca() {
        return porcentajeBeca;
    }

    public void setPorcentajeBeca(Double porcentajeBeca) {
        this.porcentajeBeca = porcentajeBeca;
    }

    // Método toString para debugging
    @Override
    public String toString() {
        return "Beneficio{" +
                "id=" + id +
                ", descripcion='" + descripcion + '\'' +
                ", minimoPuntaje=" + minimoPuntaje +
                ", maximoPuntaje=" + maximoPuntaje +
                ", tipoPrueba='" + tipoPrueba + '\'' +
                ", notaAsignada=" + notaAsignada +
                ", porcentajeBeca=" + porcentajeBeca +
                '}';
    }
}