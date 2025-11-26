<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Dashboard Estudiante - Saber Pro 2025</title>
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
            padding: 0;
            position: relative;
            overflow-x: hidden;
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
        
        /* Header */
        .dashboard-header {
            background: var(--white);
            border-bottom: 1px solid var(--neutral-border);
            padding: 24px 40px;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .welcome-section h1 {
            font-size: 28px;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 4px;
        }
        
        .welcome-section p {
            color: var(--text-secondary);
            font-size: 16px;
        }
        
        .logout-btn {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error);
            border: 1px solid rgba(239, 68, 68, 0.3);
            padding: 10px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .logout-btn:hover {
            background: rgba(239, 68, 68, 0.2);
            transform: translateY(-2px);
        }
        
        /* Main Content */
        .dashboard-main {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }
        
        /* Cards */
        .card {
            background: var(--white);
            border-radius: 16px;
            padding: 30px;
            border: 1px solid var(--neutral-border);
            box-shadow: var(--shadow-lg);
            animation: fadeInUp 0.6s ease;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
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
            font-size: 20px;
            font-weight: 600;
            color: var(--text-primary);
        }
        
        /* Información Personal */
        .info-grid {
            display: grid;
            gap: 16px;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px;
            background: var(--neutral-light);
            border-radius: 10px;
            border-left: 4px solid var(--primary);
            transition: all 0.2s ease;
        }
        
        .info-item:hover {
            background: var(--white);
            box-shadow: var(--shadow);
        }
        
        .info-label {
            color: var(--text-secondary);
            font-weight: 500;
        }
        
        .info-value {
            font-weight: 600;
            color: var(--text-primary);
        }
        
        /* Puntaje Total */
        .score-display {
            text-align: center;
            padding: 40px 30px;
            background: var(--neutral-light);
            border-radius: 16px;
            border: 1px solid var(--neutral-border);
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
        }
        
        .score-display::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary-gradient);
        }
        
        .score-value {
            font-size: 48px;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin: 10px 0;
            text-shadow: 0 2px 4px rgba(37, 99, 235, 0.1);
        }
        
        .score-label {
            color: var(--text-secondary);
            font-size: 16px;
            font-weight: 500;
        }
        
        /* Tabla de Resultados */
        .results-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 16px;
        }
        
        .results-table th {
            background: var(--neutral-light);
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: var(--text-primary);
            border-bottom: 2px solid var(--neutral-border);
        }
        
        .results-table td {
            padding: 16px;
            border-bottom: 1px solid var(--neutral-border);
        }
        
        .results-table tr:hover {
            background: rgba(37, 99, 235, 0.05);
        }
        
        .area-name {
            font-weight: 500;
            color: var(--text-primary);
        }
        
        .area-score {
            font-weight: 600;
            color: var(--primary);
        }
        
        /* Estado de Beneficios */
        .benefits-status {
            text-align: center;
            padding: 30px;
        }
        
        .benefits-message {
            font-size: 18px;
            font-weight: 600;
            padding: 16px 24px;
            border-radius: 10px;
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.3);
            color: var(--info);
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .benefits-message:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }
        
        /* Mensaje cuando no hay resultados */
        .no-results {
            text-align: center;
            padding: 40px;
            color: var(--text-secondary);
            background: var(--neutral-light);
            border-radius: 12px;
            border: 1px dashed var(--neutral-border);
        }
        
        .no-results i {
            font-size: 48px;
            margin-bottom: 16px;
            color: var(--text-light);
        }
        
        /* Responsive */
        @media (max-width: 968px) {
            .dashboard-main {
                grid-template-columns: 1fr;
                padding: 20px;
            }
            
            .header-content {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }
        }
        
        @media (max-width: 480px) {
            .dashboard-header {
                padding: 20px;
            }
            
            .welcome-section h1 {
                font-size: 24px;
            }
            
            .card {
                padding: 20px;
            }
            
            .score-value {
                font-size: 36px;
            }
            
            .card-icon-container {
                width: 50px;
                height: 50px;
            }
            
            .card-icon {
                font-size: 20px;
            }
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
        .card:nth-child(4) { animation-delay: 0.4s; }
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
    
    <!-- Header -->
    <header class="dashboard-header">
        <div class="header-content">
            <div class="welcome-section">
                <h1>Bienvenido/a ${alumno.primerNombre} ${alumno.primerApellido}</h1>
                <p>Dashboard Estudiantil - Saber Pro 2025</p>
            </div>
            <a href="/logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Cerrar Sesión
            </a>
        </div>
    </header>

    <!-- Main Content -->
    <main class="dashboard-main">
        <!-- Información Personal -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon-container">
                    <div class="card-icon-bg"></div>
                    <div class="card-icon">
                        <i class="fas fa-user"></i>
                    </div>
                </div>
                <h2 class="card-title">Información Personal</h2>
            </div>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Documento</span>
                    <span class="info-value">${alumno.numeroDocumento}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Correo Electrónico</span>
                    <span class="info-value">${alumno.correo}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Teléfono</span>
                    <span class="info-value">${alumno.telefono}</span>
                </div>
            </div>
        </div>

        <!-- Puntaje Total -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon-container">
                    <div class="card-icon-bg"></div>
                    <div class="card-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                </div>
                <h2 class="card-title">Puntaje Total</h2>
            </div>
            <div class="score-display">
                <div class="score-value">${alumno.puntajeTotal}</div>
                <div class="score-label">Puntaje Global Obtenido</div>
            </div>
        </div>

        <!-- Resultados por Área -->
        <div class="card card-full">
            <div class="card-header">
                <div class="card-icon-container">
                    <div class="card-icon-bg"></div>
                    <div class="card-icon">
                        <i class="fas fa-layer-group"></i>
                    </div>
                </div>
                <h2 class="card-title">Resultados por Área</h2>
            </div>

            <c:choose>
                <c:when test="${not empty resultados}">
                    <table class="results-table">
                        <thead>
                        <tr>
                            <th>Área de Conocimiento</th>
                            <th>Puntaje Obtenido</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="resultado" items="${resultados}">
                            <tr>
                                <td class="area-name">${resultado.area}</td>
                                <td class="area-score">${resultado.puntaje}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <i class="fas fa-inbox"></i>
                        <p>Aún no hay resultados registrados para este estudiante.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Estado de Beneficios -->
        <div class="card card-full">
            <div class="card-header">
                <div class="card-icon-container">
                    <div class="card-icon-bg"></div>
                    <div class="card-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                </div>
                <h2 class="card-title">Estado de Beneficios</h2>
            </div>
            <div class="benefits-status">
                <div class="benefits-message">${mensajeBeneficio}</div>
            </div>
        </div>
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