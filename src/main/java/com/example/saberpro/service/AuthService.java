package com.example.saberpro.service;

import com.example.saberpro.model.Usuario;
import com.example.saberpro.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Valida el usuario comparando correo y contraseña en texto plano (solo uso académico)
    public Usuario validateUser(String correo, String rawPassword) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByCorreo(correo);
        if (usuarioOpt.isPresent()) {
            Usuario usuario = usuarioOpt.get();
            if (usuario.getContraseña() != null &&
                usuario.getContraseña().equals(rawPassword)) {
                return usuario;
            }
        }
        return null;
    }
}
