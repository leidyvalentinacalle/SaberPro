package com.example.saberpro.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "alumnos", uniqueConstraints = {
    @UniqueConstraint(columnNames = "numeroDocumento"),
    @UniqueConstraint(columnNames = "correo")
})
public class Alumno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String numeroDocumento;

    @Column(nullable = false)
    private String primerNombre;

    private String segundoNombre;

    @Column(nullable = false)
    private String primerApellido;

    private String segundoApellido;

    @Column(unique = true, nullable = false)
    private String correo;

    private String telefono;

    private Double puntajeTotal;

    @OneToMany(mappedBy = "alumno", cascade = CascadeType.ALL)
    private List<Resultado> resultados;

    // Constructores
    public Alumno() {
    }

    public Alumno(String numeroDocumento, String primerNombre, String primerApellido, String correo) {
        this.numeroDocumento = numeroDocumento;
        this.primerNombre = primerNombre;
        this.primerApellido = primerApellido;
        this.correo = correo;
    }

    // Getters y setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumeroDocumento() {
        return numeroDocumento;
    }

    public void setNumeroDocumento(String numeroDocumento) {
        this.numeroDocumento = numeroDocumento;
    }

    public String getPrimerNombre() {
        return primerNombre;
    }

    public void setPrimerNombre(String primerNombre) {
        this.primerNombre = primerNombre;
    }

    public String getSegundoNombre() {
        return segundoNombre;
    }

    public void setSegundoNombre(String segundoNombre) {
        this.segundoNombre = segundoNombre;
    }

    public String getPrimerApellido() {
        return primerApellido;
    }

    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }

    public String getSegundoApellido() {
        return segundoApellido;
    }

    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Double getPuntajeTotal() {
        return puntajeTotal;
    }

    public void setPuntajeTotal(Double puntajeTotal) {
        this.puntajeTotal = puntajeTotal;
    }

    public List<Resultado> getResultados() {
        return resultados;
    }

    public void setResultados(List<Resultado> resultados) {
        this.resultados = resultados;
    }
}