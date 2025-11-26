<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Gestión de Alumno - Saber Pro 2025</title>
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
	            font-size: 24px;
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
	            background: rgba(107, 114, 128, 0.1);
	            color: var(--text-secondary);
	            border: 1px solid var(--neutral-border);
	        }

	        .header-actions a:hover {
	            transform: translateY(-2px);
	            box-shadow: var(--shadow-lg);
	            background: var(--white);
	        }

	        .container {
	            max-width: 900px;
	            margin: 0 auto;
	            padding: 32px 40px 40px;
	        }

	        .card {
	            background: var(--white);
	            border-radius: 16px;
	            padding: 32px 36px;
	            border: 1px solid var(--neutral-border);
	            box-shadow: var(--shadow-lg);
	            transition: transform 0.3s ease, box-shadow 0.3s ease;
	            animation: fadeInUp 0.6s ease;
	        }

	        .card:hover {
	            transform: translateY(-5px);
	            box-shadow: var(--shadow-xl);
	        }

	        .card-title {
	            font-size: 20px;
	            font-weight: 600;
	            margin-bottom: 24px;
	            color: var(--text-primary);
	            display: flex;
	            align-items: center;
	            gap: 12px;
	        }

	        .card-title i {
	            color: var(--primary);
	            font-size: 22px;
	        }

	        .form-grid {
	            display: grid;
	            grid-template-columns: repeat(2, minmax(0, 1fr));
	            gap: 20px 24px;
	        }

	        .form-group {
	            display: flex;
	            flex-direction: column;
	        }

	        label {
	            font-size: 14px;
	            font-weight: 500;
	            margin-bottom: 8px;
	            color: var(--text-primary);
	        }

	        .input-container {
	            position: relative;
	        }

	        .input-field {
	            width: 100%;
	            padding: 14px 16px;
	            border-radius: 10px;
	            border: 1.5px solid var(--neutral-border);
	            background: var(--white);
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

	        .input-icon {
	            position: absolute;
	            right: 16px;
	            top: 50%;
	            transform: translateY(-50%);
	            color: var(--text-light);
	            font-size: 16px;
	            transition: color 0.2s ease;
	        }

	        .input-field:focus + .input-icon {
	            color: var(--primary);
	        }

	        .form-actions {
	            margin-top: 32px;
	            display: flex;
	            justify-content: flex-end;
	            gap: 16px;
	            padding-top: 24px;
	            border-top: 1px solid var(--neutral-border);
	        }

	        .btn {
	            padding: 14px 28px;
	            border-radius: 10px;
	            font-weight: 600;
	            border: none;
	            cursor: pointer;
	            transition: all 0.3s ease;
	            display: inline-flex;
	            align-items: center;
	            gap: 8px;
	            text-decoration: none;
	            font-size: 15px;
	        }

	        .btn-primary {
	            background: var(--primary-gradient);
	            color: var(--white);
	            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
	            position: relative;
	            overflow: hidden;
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

	        .btn-secondary {
	            background: rgba(107, 114, 128, 0.1);
	            color: var(--text-secondary);
	            border: 1px solid var(--neutral-border);
	        }

	        .btn:hover {
	            transform: translateY(-2px);
	            box-shadow: var(--shadow-lg);
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

	        /* Validación visual */
	        .input-field:invalid:not(:focus):not(:placeholder-shown) {
	            border-color: var(--error);
	        }

	        .input-field:valid:not(:focus):not(:placeholder-shown) {
	            border-color: var(--success);
	        }

	        @media (max-width: 768px) {
	            .container {
	                padding: 24px 20px 32px;
	            }
	            
	            .form-grid {
	                grid-template-columns: 1fr;
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
	            
	            .card {
	                padding: 24px;
	            }
	            
	            .form-actions {
	                flex-direction: column-reverse;
	            }
	            
	            .btn {
	                justify-content: center;
	            }
	        }

	        @media (max-width: 480px) {
	            .header-title h1 {
	                font-size: 20px;
	            }
	            
	            .card-title {
	                font-size: 18px;
	            }
	            
	            .btn {
	                padding: 12px 20px;
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
            <c:choose>
                <c:when test="${not empty alumno.id}">
                    <h1>Editar Alumno</h1>
                    <p>Actualiza los datos del estudiante seleccionado</p>
                </c:when>
                <c:otherwise>
                    <h1>Nuevo Alumno</h1>
                    <p>Registra un nuevo estudiante para Saber Pro 2025</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="header-actions">
            <a href="/coordinador/dashboard">
                <i class="fas fa-arrow-left"></i>
                Volver al Dashboard
            </a>
        </div>
    </header>
	
	<!-- Mensaje de error -->
	<c:if test="${not empty error}">
	    <div style="background: rgba(239,68,68,0.1); color: #EF4444; padding: 12px; border-radius: 8px; border: 1px solid rgba(239,68,68,0.3); margin-bottom: 20px; margin: 0 40px 20px 40px;">
	        <strong>Error:</strong> ${error}
	    </div>
	</c:if>

    <main class="container">
        <div class="card">
            <h2 class="card-title">
                <i class="fas fa-user-graduate"></i>
                Datos del Alumno
            </h2>

            <!-- CORRECCIÓN: Formulario con action dinámico -->
            <form method="post" 
                  action="${empty alumno.id ? '/coordinador/alumnos' : '/coordinador/alumnos/editar'}">
                
                <!-- Campo oculto para el ID en edición -->
                <c:if test="${not empty alumno.id}">
                    <input type="hidden" name="id" value="${alumno.id}" />
                </c:if>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="numeroDocumento">Número de Documento</label>
                        <div class="input-container">
                            <input type="text" id="numeroDocumento" name="numeroDocumento"
                                   class="input-field" value="${alumno.numeroDocumento}" 
                                   placeholder="Ingresa el número de documento" required />
                            <i class="fas fa-id-card input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="primerNombre">Primer Nombre</label>
                        <div class="input-container">
                            <input type="text" id="primerNombre" name="primerNombre"
                                   class="input-field" value="${alumno.primerNombre}" 
                                   placeholder="Primer nombre" required />
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="segundoNombre">Segundo Nombre</label>
                        <div class="input-container">
                            <input type="text" id="segundoNombre" name="segundoNombre"
                                   class="input-field" value="${alumno.segundoNombre}" 
                                   placeholder="Segundo nombre (opcional)" />
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="primerApellido">Primer Apellido</label>
                        <div class="input-container">
                            <input type="text" id="primerApellido" name="primerApellido"
                                   class="input-field" value="${alumno.primerApellido}" 
                                   placeholder="Primer apellido" required />
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="segundoApellido">Segundo Apellido</label>
                        <div class="input-container">
                            <input type="text" id="segundoApellido" name="segundoApellido"
                                   class="input-field" value="${alumno.segundoApellido}" 
                                   placeholder="Segundo apellido (opcional)" />
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="correo">Correo Electrónico</label>
                        <div class="input-container">
                            <input type="email" id="correo" name="correo"
                                   class="input-field" value="${alumno.correo}" 
                                   placeholder="correo@ejemplo.com" required />
                            <i class="fas fa-envelope input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="telefono">Teléfono</label>
                        <div class="input-container">
                            <input type="text" id="telefono" name="telefono"
                                   class="input-field" value="${alumno.telefono}" 
                                   placeholder="Número de teléfono (opcional)" />
                            <i class="fas fa-phone input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="puntajeTotal">Puntaje Total</label>
                        <div class="input-container">
                            <input type="number" step="0.1" id="puntajeTotal" name="puntajeTotal"
                                   class="input-field" value="${alumno.puntajeTotal}" 
                                   placeholder="0.0" />
                            <i class="fas fa-chart-line input-icon"></i>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="/coordinador/dashboard" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancelar
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty alumno.id}">
                                <i class="fas fa-save"></i>
                                Guardar Cambios
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus"></i>
                                Crear Alumno
                            </c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </main>

	<script>
	        // Efectos de interacción mejorados
	        document.addEventListener('DOMContentLoaded', function() {
	            const form = document.querySelector('form');
	            const inputs = document.querySelectorAll('.input-field');
	            
	            // Agregar efecto de focus mejorado
	            inputs.forEach(input => {
	                input.addEventListener('focus', function() {
	                    this.parentElement.style.transform = 'scale(1.02)';
	                });
	                
	                input.addEventListener('blur', function() {
	                    this.parentElement.style.transform = 'scale(1)';
	                });
	            });
	            
	            // Validación en tiempo real
	            form.addEventListener('submit', function(e) {
	                let isValid = true;
	                const requiredFields = form.querySelectorAll('[required]');
	                
	                requiredFields.forEach(field => {
	                    if (!field.value.trim()) {
	                        isValid = false;
	                        field.style.borderColor = 'var(--error)';
	                    }
	                });
	                
	                if (!isValid) {
	                    e.preventDefault();
	                    // Efecto de shake en campos inválidos
	                    requiredFields.forEach(field => {
	                        if (!field.value.trim()) {
	                            field.style.animation = 'shake 0.5s ease-in-out';
	                            setTimeout(() => {
	                                field.style.animation = '';
	                            }, 500);
	                        }
	                    });
	                }
	            });
	        });

	        // Animación de shake para campos inválidos
	        const style = document.createElement('style');
	        style.textContent = `
	            @keyframes shake {
	                0%, 100% { transform: translateX(0); }
	                25% { transform: translateX(-5px); }
	                75% { transform: translateX(5px); }
	            }
	        `;
	        document.head.appendChild(style);
	    </script>
</body>
</html>