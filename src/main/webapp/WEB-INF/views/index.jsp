<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Login - Saber Pro 2025</title>
    <style>
        /* Sistema de diseño moderno y profesional */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        :root {
            --primary: #2563EB;
            --primary-light: #3B82F6;
            --primary-dark: #1D4ED8;
            --primary-gradient: linear-gradient(135deg, #2563EB 0%, #1E40AF 100%);
            --secondary: #059669;
            --neutral-dark: #1F2937;
            --neutral-medium: #374151;
            --neutral-light: #F9FAFB;
            --neutral-border: #E5E7EB;
            --neutral-surface: #F3F4F6;
            --text-primary: #111827;
            --text-secondary: #6B7280;
            --text-light: #9CA3AF;
            --success: #10B981;
            --error: #EF4444;
            --white: #FFFFFF;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        
        body {
            background: var(--neutral-surface);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: var(--text-primary);
            position: relative;
            overflow-x: hidden;
        }
        
        /* Efectos de fondo decorativos */
        .bg-decoration {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            overflow: hidden;
        }
        
        .bg-circle {
            position: absolute;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(37, 99, 235, 0.05) 0%, rgba(30, 64, 175, 0.05) 100%);
        }
        
        .circle-1 {
            width: 300px;
            height: 300px;
            top: -150px;
            right: -100px;
        }
        
        .circle-2 {
            width: 200px;
            height: 200px;
            bottom: -80px;
            left: -80px;
        }
        
        /* Contenedor principal */
        .login-container {
            width: 100%;
            max-width: 480px;
            background: var(--white);
            border-radius: 16px;
            padding: 48px 40px;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--neutral-border);
            position: relative;
            z-index: 1;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15);
        }
        
        /* Encabezado */
        .login-header {
            text-align: center;
            margin-bottom: 36px;
        }
        
        .logo-container {
            position: relative;
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .logo-bg {
            position: absolute;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            border-radius: 16px;
            transform: rotate(45deg);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }
        
        .logo {
            position: relative;
            color: white;
            font-size: 28px;
            font-weight: 700;
            z-index: 1;
        }
        
        .login-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        
        .login-header p {
            color: var(--text-secondary);
            font-size: 16px;
            font-weight: 400;
            line-height: 1.5;
        }
        
        /* Formulario */
        .form-group {
            margin-bottom: 24px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-primary);
            font-size: 14px;
        }
        
        .input-container {
            position: relative;
        }
        
        .input-field {
            width: 100%;
            padding: 14px 16px 14px 48px;
            background: var(--white);
            border: 1.5px solid var(--neutral-border);
            border-radius: 10px;
            color: var(--text-primary);
            font-size: 15px;
            transition: all 0.2s ease;
        }
        
        .input-field:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
        
        .input-field::placeholder {
            color: var(--text-light);
        }
        
        /* Iconos para campos */
        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            font-size: 16px;
            transition: color 0.2s ease;
        }
        
        .input-field:focus + .input-icon {
            color: var(--primary);
        }
        
        /* Estilo específico para el select */
        select.input-field {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%239CA3AF'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 16px;
            padding-right: 44px;
            appearance: none;
            -webkit-appearance: none;
        }
        
        /* Botón */
        .submit-btn {
            width: 100%;
            padding: 16px;
            background: var(--primary-gradient);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 8px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.4);
        }
        
        .submit-btn:active {
            transform: translateY(0);
        }
        
        .submit-btn::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }
        
        .submit-btn:hover::after {
            left: 100%;
        }
        
        /* Mensajes de estado */
        .message {
            padding: 14px 16px;
            border-radius: 10px;
            margin-top: 20px;
            text-align: center;
            font-weight: 500;
            font-size: 14px;
            animation: fadeIn 0.3s ease;
        }
        
        .error {
            background: rgba(239, 68, 68, 0.05);
            color: var(--error);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }
        
        .success {
            background: rgba(16, 185, 129, 0.05);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Enlace de ayuda */
        .help-link {
            text-align: center;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid var(--neutral-border);
        }
        
        .help-link a {
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.2s ease;
            display: inline-flex;
            align-items: center;
            padding: 8px 16px;
            border-radius: 8px;
        }
        
        .help-link a:hover {
            color: var(--primary);
            background: rgba(37, 99, 235, 0.05);
        }
        
        .help-link i {
            margin-right: 8px;
            font-size: 14px;
        }
        
        /* Efectos responsivos */
        @media (max-width: 480px) {
            .login-container {
                padding: 36px 24px;
            }
            
            .login-header h1 {
                font-size: 24px;
            }
            
            .logo-container {
                width: 70px;
                height: 70px;
            }
            
            .logo {
                font-size: 24px;
            }
        }
    </style>
    <!-- Font Awesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Elementos decorativos de fondo -->
    <div class="bg-decoration">
        <div class="bg-circle circle-1"></div>
        <div class="bg-circle circle-2"></div>
    </div>
    
    <div class="login-container">
        <div class="login-header">
            <div class="logo-container">
                <div class="logo-bg"></div>
                <div class="logo">SP</div>
            </div>
            <h1>Saber Pro 2025</h1>
            <p>Accede a tu cuenta para continuar</p>
        </div>
        
        <form method="post" action="/login">
            <div class="form-group">
                <label for="correo">Correo electrónico</label>
                <div class="input-container">
                    <input type="email" 
                           id="correo" 
                           name="correo" 
                           class="input-field" 
                           placeholder="usuario@uts.edu.co" 
                           required />
                    <i class="fas fa-envelope input-icon"></i>
                </div>
            </div>
            
            <div class="form-group">
                <label for="password">Contraseña</label>
                <div class="input-container">
                    <input type="password" 
                           id="password" 
                           name="contrasena" 
                           class="input-field" 
                           placeholder="Ingresa tu contraseña" 
                           required />
                    <i class="fas fa-lock input-icon"></i>
                </div>
            </div>
            
            <div class="form-group">
                <label for="tipo">Tipo de usuario</label>
                <div class="input-container">
                    <select id="tipo" name="tipo" class="input-field" required>
                        <option value="" disabled selected>Selecciona una opción</option>
                        <option value="ESTUDIANTE">Estudiante</option>
                        <option value="COORDINADOR">Coordinador</option>
                    </select>
                    <i class="fas fa-user-tag input-icon"></i>
                </div>
            </div>
            
            <button type="submit" class="submit-btn">Iniciar Sesión</button>
        </form>
        
        <c:if test="${not empty error}">
            <div class="message error">
                ${error}
            </div>
        </c:if>
        
        <div class="help-link">
            <a href="#"><i class="fas fa-question-circle"></i> ¿Necesitas ayuda para acceder?</a>
        </div>
    </div>
</body>
</html>