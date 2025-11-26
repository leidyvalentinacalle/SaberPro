<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Dashboard Coordinador - Saber Pro</title>
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
            max-width: 1400px;
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
        
        .header-actions {
            display: flex;
            gap: 16px;
            align-items: center;
        }
        
        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.4);
        }
        
        .btn-primary::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn-primary:hover::after {
            left: 100%;
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
        }
        
        .logout-btn:hover {
            background: rgba(239, 68, 68, 0.2);
            transform: translateY(-2px);
        }
        
        /* Main Content */
        .dashboard-main {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: var(--white);
            border-radius: 16px;
            padding: 30px;
            border: 1px solid var(--neutral-border);
            box-shadow: var(--shadow-lg);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }
        
        .stat-icon-container {
            position: relative;
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .stat-icon-bg {
            position: absolute;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            border-radius: 16px;
            transform: rotate(45deg);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }
        
        .stat-icon {
            position: relative;
            color: white;
            font-size: 28px;
            z-index: 1;
        }
        
        .stat-value {
            font-size: 36px;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin: 8px 0;
        }
        
        .stat-label {
            color: var(--text-secondary);
            font-size: 16px;
            font-weight: 500;
        }
        
        /* Table Container */
        .table-container {
            background: var(--white);
            border-radius: 16px;
            padding: 30px;
            border: 1px solid var(--neutral-border);
            box-shadow: var(--shadow-lg);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .table-container:hover {
            box-shadow: var(--shadow-xl);
        }
        
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        
        .table-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--text-primary);
        }
        
        /* Table Styles */
        .students-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 16px;
        }
        
        .students-table th {
            background: var(--neutral-light);
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: var(--text-primary);
            border-bottom: 2px solid var(--neutral-border);
        }
        
        .students-table td {
            padding: 16px;
            border-bottom: 1px solid var(--neutral-border);
        }
        
        .students-table tr:hover {
            background: rgba(37, 99, 235, 0.05);
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        
        .btn-action {
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.2s ease;
            border: 1px solid;
        }
        
        .btn-view {
            background: rgba(59, 130, 246, 0.1);
            color: var(--info);
            border-color: rgba(59, 130, 246, 0.3);
        }
        
        .btn-edit {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
            border-color: rgba(245, 158, 11, 0.3);
        }
        
        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error);
            border-color: rgba(239, 68, 68, 0.3);
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }
        
        /* Student Name */
        .student-name {
            font-weight: 500;
            color: var(--text-primary);
        }
        
        .student-document {
            color: var(--text-secondary);
            font-size: 13px;
            margin-top: 4px;
        }
        
        /* Score Display */
        .score-badge {
            background: var(--primary-gradient);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
            display: inline-block;
            box-shadow: 0 2px 8px rgba(37, 99, 235, 0.3);
        }
        
        .no-score {
            color: var(--text-secondary);
            font-style: italic;
            font-size: 14px;
        }
        
        /* Responsive */
        @media (max-width: 1024px) {
            .dashboard-main {
                padding: 20px;
            }
            
            .header-content {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }
            
            .header-actions {
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 8px;
            }
        }
        
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .students-table {
                display: block;
                overflow-x: auto;
            }
            
            .dashboard-header {
                padding: 20px;
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
        
        .stat-card, .table-container {
            animation: fadeInUp 0.6s ease;
        }
        
        .stat-card:nth-child(2) {
            animation-delay: 0.1s;
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
    
    <!-- Header -->
    <header class="dashboard-header">
        <div class="header-content">
            <div class="welcome-section">
                <h1>Dashboard del Coordinador</h1>
                <p>Gestión Integral de Estudiantes - Saber Pro 2025</p>
            </div>
            <div class="header-actions">
                <a href="/coordinador/alumnos/nuevo" class="btn-primary">
                    <i class="fas fa-plus"></i>
                    Nuevo Alumno
                </a>
                <a href="/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    Cerrar Sesión
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="dashboard-main">
        <!-- Statistics -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon-container">
                    <div class="stat-icon-bg"></div>
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <div class="stat-value">${totalAlumnos}</div>
                <div class="stat-label">Total de Alumnos Inscritos</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon-container">
                    <div class="stat-icon-bg"></div>
                    <div class="stat-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                </div>
                <div class="stat-value">
                    <fmt:formatNumber value="${promedioPuntaje}" pattern="#.##"/>
                </div>
                <div class="stat-label">Puntaje Promedio Global</div>
            </div>
        </div>

        <!-- Students Table -->
        <div class="table-container">
            <div class="table-header">
                <h2 class="table-title">Listado de Alumnos</h2>
            </div>
            
            <table class="students-table">
                <thead>
                    <tr>
                        <th>Documento</th>
                        <th>Nombre Completo</th>
                        <th>Correo Electrónico</th>
                        <th>Puntaje Total</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="alumno" items="${alumnos}">
                    <tr>
                        <td>
                            <div class="student-document">${alumno.numeroDocumento}</div>
                        </td>
                        <td>
                            <div class="student-name">
                                ${alumno.primerNombre} 
                                <c:if test="${not empty alumno.segundoNombre}">${alumno.segundoNombre}</c:if>
                                ${alumno.primerApellido}
                                <c:if test="${not empty alumno.segundoApellido}">${alumno.segundoApellido}</c:if>
                            </div>
                        </td>
                        <td>${alumno.correo}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty alumno.puntajeTotal && alumno.puntajeTotal > 0}">
                                    <span class="score-badge">${alumno.puntajeTotal}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="no-score">Sin puntaje</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="/coordinador/alumnos/informe/${alumno.id}" class="btn-action btn-view">
                                    <i class="fas fa-eye"></i> Ver
                                </a>
                                <a href="/coordinador/alumnos/editar/${alumno.id}" class="btn-action btn-edit">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                                <a href="/coordinador/alumnos/eliminar/${alumno.id}" 
                                   class="btn-action btn-delete"
                                   onclick="return confirm('¿Estás seguro que deseas eliminar este alumno?');">
                                    <i class="fas fa-trash"></i> Eliminar
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <script>
        // Confirmación mejorada para eliminación
        document.addEventListener('DOMContentLoaded', function() {
            const deleteLinks = document.querySelectorAll('.btn-delete');
            deleteLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    if (!confirm('¿Estás seguro que deseas eliminar permanentemente este alumno?\nEsta acción no se puede deshacer.')) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
</body>
</html>