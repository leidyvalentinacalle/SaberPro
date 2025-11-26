<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Informe del Alumno - Saber Pro 2025</title>
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
            --warning: #F59E0B;
            --error: #EF4444;
            --info: #3B82F6;
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
            color: var(--text-primary);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }
        
        /* Efectos de fondo decorativos */
        .bg-decoration {
            position: fixed;
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
            width: 400px;
            height: 400px;
            top: -200px;
            right: -150px;
        }
        
        .circle-2 {
            width: 300px;
            height: 300px;
            bottom: -150px;
            left: -100px;
        }

        .header {
            background: var(--white);
            border-bottom: 1px solid var(--neutral-border);
            padding: 24px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-title h1 {
            font-size: 26px;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .header-title p {
            color: var(--text-secondary);
            margin-top: 4px;
            font-size: 16px;
        }

        .header-actions {
            display: flex;
            gap: 12px;
        }

        .header-actions a {
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .primary-link {
            background: var(--primary-gradient);
            color: var(--white);
            border: none;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
            position: relative;
            overflow: hidden;
        }

        .primary-link::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .primary-link:hover::after {
            left: 100%;
        }

        .secondary-link {
            background: rgba(107, 114, 128, 0.1);
            color: var(--text-secondary);
            border: 1px solid var(--neutral-border);
        }

        .header-actions a:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 32px 40px 40px;
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 24px;
        }

        .card {
            background: var(--white);
            border-radius: 16px;
            padding: 28px 32px;
            border: 1px solid var(--neutral-border);
            box-shadow: var(--shadow-lg);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeInUp 0.6s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .card-full {
            grid-column: 1 / -1;
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 24px;
        }

        .card-icon-container {
            position: relative;
            width: 60px;
            height: 60px;
            margin-right: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-icon-bg {
            position: absolute;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            border-radius: 12px;
            transform: rotate(45deg);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .card-icon {
            position: relative;
            color: white;
            font-size: 24px;
            z-index: 1;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .info-grid {
            display: grid;
            gap: 16px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px;
            background: var(--neutral-light);
            border-radius: 10px;
            border-left: 4px solid var(--primary);
            transition: all 0.2s ease;
        }

        .info-row:hover {
            background: var(--white);
            box-shadow: var(--shadow);
        }

        .info-label {
            color: var(--text-secondary);
            font-size: 14px;
            font-weight: 500;
        }

        .info-value {
            font-weight: 600;
            color: var(--text-primary);
        }

        .score-main {
            text-align: center;
            padding: 30px 20px;
            background: var(--neutral-light);
            border-radius: 16px;
            border: 1px solid var(--neutral-border);
            position: relative;
            overflow: hidden;
        }

        .score-main::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary-gradient);
        }

        .score-number {
            font-size: 48px;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 8px;
            text-shadow: 0 2px 4px rgba(37, 99, 235, 0.1);
        }

        .score-caption {
            color: var(--text-secondary);
            font-size: 16px;
            font-weight: 500;
        }

        .benefits-list {
            margin-top: 8px;
        }

        .benefit-item {
            padding: 20px;
            border-radius: 12px;
            background: rgba(16, 185, 129, 0.08);
            border: 1px solid rgba(16, 185, 129, 0.2);
            color: var(--success);
            margin-bottom: 16px;
            transition: all 0.3s ease;
        }

        .benefit-item:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
            background: rgba(16, 185, 129, 0.12);
        }

        .benefit-empty {
            padding: 30px 20px;
            border-radius: 12px;
            background: var(--neutral-light);
            border: 2px dashed var(--neutral-border);
            color: var(--text-secondary);
            text-align: center;
            transition: all 0.3s ease;
        }

        .benefit-empty:hover {
            background: var(--white);
            border-color: var(--primary-light);
        }

        .benefit-empty i {
            font-size: 48px;
            margin-bottom: 16px;
            color: var(--text-light);
            display: block;
        }

        .benefit-details {
            font-size: 14px;
            color: var(--text-secondary);
            margin-top: 8px;
            line-height: 1.5;
        }

        .benefit-highlight {
            color: var(--primary);
            font-weight: 600;
        }

        /* Animaciones */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Retrasos escalonados para las animaciones */
        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }
        .card:nth-child(3) { animation-delay: 0.3s; }

        @media (max-width: 960px) {
            .container {
                grid-template-columns: 1fr;
                padding: 24px 20px 32px;
            }
            
            .header {
                padding: 20px;
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }
            
            .header-actions {
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .score-number {
                font-size: 36px;
            }
        }

        @media (max-width: 480px) {
            .card {
                padding: 20px;
            }
            
            .card-icon-container {
                width: 50px;
                height: 50px;
            }
            
            .card-icon {
                font-size: 20px;
            }
            
            .header-title h1 {
                font-size: 22px;
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

    <header class="header">
        <div class="header-title">
            <h1>Informe del Alumno</h1>
            <p>
                ${alumno.primerNombre}
                <c:if test="${not empty alumno.segundoNombre}">${alumno.segundoNombre}</c:if>
                ${alumno.primerApellido}
                <c:if test="${not empty alumno.segundoApellido}">${alumno.segundoApellido}</c:if>
            </p>
        </div>
        <div class="header-actions">
            <a href="/coordinador/dashboard" class="primary-link">
                <i class="fas fa-arrow-left"></i>
                Volver al Dashboard
            </a>
            <a href="/logout" class="secondary-link">
                <i class="fas fa-sign-out-alt"></i>
                Cerrar Sesión
            </a>
        </div>
    </header>

    <main class="container">
        <!-- Datos del alumno -->
        <section class="card">
            <div class="card-header">
                <div class="card-icon-container">
                    <div class="card-icon-bg"></div>
                    <div class="card-icon">
                        <i class="fas fa-user"></i>
                    </div>
                </div>
                <h2 class="card-title">Información del Estudiante</h2>
            </div>
            <div class="info-grid">
                <div class="info-row">
                    <span class="info-label">Documento</span>
                    <span class="info-value">${alumno.numeroDocumento}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Correo</span>
                    <span class="info-value">${alumno.correo}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Teléfono</span>
                    <span class="info-value">
                        <c:out value="${alumno.telefono != null ? alumno.telefono : 'No registrado'}"/>
                    </span>
                </div>
            </div>
        </section>

        <!-- Puntaje global y resumen -->
        <section class="card">
            <div class="card-header">
                <div class="card-icon-container">
                    <div class="card-icon-bg"></div>
                    <div class="card-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                </div>
                <h2 class="card-title">Puntaje Global</h2>
            </div>
            <div class="score-main">
                <div class="score-number">
                    <c:choose>
                        <c:when test="${not empty resultadoTT and not empty resultadoTT.puntajeTotal}">
                            ${resultadoTT.puntajeTotal}
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="score-caption">Puntaje total en Saber T&T</div>
            </div>
        </section>

        <!-- Beneficios -->
        <section class="card card-full">
            <div class="card-header">
                <div class="card-icon-container">
                    <div class="card-icon-bg"></div>
                    <div class="card-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                </div>
                <h2 class="card-title">Beneficios Aplicables</h2>
            </div>

            <div class="benefits-list">
                <c:choose>
                    <c:when test="${not empty beneficio}">
                        <div class="benefit-item">
                            <strong>${beneficio.descripcion}</strong>
                            <div class="benefit-details">
                                Nota asignada: <span class="benefit-highlight">${beneficio.notaAsignada}</span> | 
                                Beca en derechos de grado: <span class="benefit-highlight">${beneficio.porcentajeBeca}%</span>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="benefit-empty">
                            <i class="fas fa-inbox"></i>
                            <c:choose>
                                <c:when test="${not empty resultadoTT and not empty resultadoTT.puntajeTotal}">
                                    Este estudiante no aplica a beneficios con el puntaje actual de 
                                    <span class="benefit-highlight">${resultadoTT.puntajeTotal} puntos</span>.
                                    <br>Los beneficios inician desde 120 puntos.
                                </c:when>
                                <c:otherwise>
                                    No se encontraron resultados de Saber T&T para calcular beneficios.
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

    <script>
        // Efectos de interacción adicionales
        document.addEventListener('DOMContentLoaded', function() {
            // Agregar efecto de pulso a la tarjeta de puntaje
            const scoreCard = document.querySelector('.card:nth-child(2)');
            if (scoreCard) {
                scoreCard.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px) scale(1.02)';
                });
                
                scoreCard.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(-5px)';
                });
            }
        });
    </script>
</body>
</html>