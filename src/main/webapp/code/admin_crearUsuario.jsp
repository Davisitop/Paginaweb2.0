<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Pagina"
%><%@ page import="com.productos.seguridad.Bitacora" %>

<%
    // Protección de Página (Solo Admins)
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");
    
    if (perfil == null || perfil != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Usuario - Admin MediVital</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        /* --- ESTILOS GENERALES --- */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
            color: #333;
            overflow-x: hidden;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navbar */
        .navbar {
            background-color: rgba(255, 255, 255, 0.95);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            backdrop-filter: blur(10px);
        }
        .navbar-brand {
            font-weight: 700;
            color: #007bff !important;
            font-size: 1.5rem;
        }
        .nav-link {
            font-weight: 500;
            color: #555 !important;
            margin: 0 5px;
            transition: color 0.3s;
        }
        .nav-link:hover, .nav-link.active {
            color: #007bff !important;
        }

        /* Hero Header Compacto */
        .page-header {
            background: linear-gradient(135deg, #343a40, #6c757d);
            color: white;
            padding: 60px 0 40px;
            text-align: center;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        /* Tarjeta del Formulario */
        .form-card {
            border: none;
            border-radius: 20px;
            background: white;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            max-width: 600px;
            margin: 0 auto;
        }
        .form-header {
            background-color: #007bff;
            color: white;
            padding: 20px;
            text-align: center;
            font-weight: 600;
            font-size: 1.2rem;
        }
        .form-body {
            padding: 40px;
        }

        /* Inputs */
        .form-label {
            font-weight: 500;
            color: #555;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        .form-control, .form-select {
            border-radius: 10px;
            padding: 10px 15px;
            border: 1px solid #e0e0e0;
            background-color: #fdfdfd;
        }
        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
            border-color: #007bff;
        }
        .input-group-text {
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
            border-radius: 10px 0 0 10px;
            color: #007bff;
        }
        .form-control { border-radius: 0 10px 10px 0; }

        /* Botones */
        .btn-primary-custom {
            background-color: #007bff;
            color: white;
            border-radius: 50px;
            padding: 10px 30px;
            font-weight: 600;
            border: none;
            transition: all 0.3s;
            width: 100%;
            box-shadow: 0 5px 15px rgba(0,123,255,0.3);
        }
        .btn-primary-custom:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
        .btn-secondary-custom {
            background-color: transparent;
            color: #6c757d;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.3s;
            width: 100%;
            text-align: center;
            display: inline-block;
            text-decoration: none;
        }
        .btn-secondary-custom:hover {
            background-color: #f8f9fa;
            color: #333;
            border-color: #ccc;
        }

        /* Footer */
        footer {
            background-color: #343a40;
            color: rgba(255,255,255,0.6);
            text-align: center;
            padding: 30px 0;
            margin-top: auto;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <img src="../image/logo.PNG" alt="Logo" width="40" height="40" class="rounded-circle me-2">
                MediVital
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3 text-primary fw-bold">👋 <%= usuario %> (Admin)</li>
                    
                    <%
                        Pagina pag = new Pagina();
                        // Renderizar menú dinámico (Admin, Usuarios, etc.)
                        out.print(pag.mostrarMenu(perfil));
                    %>
                    
                    <li class="nav-item ms-2">
                        <form action="logout.jsp" method="post" class="d-inline">
                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3">Salir</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="page-header mt-5 pt-5">
        <div class="container mt-3">
            <h1 class="fw-bold">Gestión de Usuarios</h1>
            <p class="mb-0 opacity-75">Crear nuevas credenciales de acceso al sistema</p>
        </div>
    </header>

    <div class="container mb-5">
        <div class="form-card">
            <div class="form-header">
                <i class="bi bi-person-plus-fill me-2"></i> Nuevo Usuario
            </div>
            <div class="form-body">
                
                <form action="admin_guardarUsuario.jsp" method="post">
                    
                    <div class="mb-4">
                        <label for="nombre" class="form-label">Nombre Completo</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ej. Juan Pérez" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="correo" class="form-label">Correo Electrónico (Login)</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <input type="email" class="form-control" id="correo" name="correo" placeholder="usuario@medivital.com" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="clave" class="form-label">Contraseña</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-key"></i></span>
                            <input type="password" class="form-control" id="clave" name="clave" placeholder="••••••••" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="perfil" class="form-label">Asignar Perfil</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                            <select class="form-select" name="perfil" id="perfil" required>
                                <option value="" disabled selected>Seleccione un rol...</option>
                                <option value="1">Administrador</option>
                                <option value="3">Empleado (Vendedor)</option>
                                <option value="2">Cliente</option>
                            </select>
                        </div>
                    </div>

                    <div class="row g-3 mt-4">
                        <div class="col-md-6">
                            <a href="admin_verUsuarios.jsp" class="btn-secondary-custom">
                                <i class="bi bi-arrow-left"></i> Cancelar
                            </a>
                        </div>
                        <div class="col-md-6">
                            <button type="submit" class="btn-primary-custom">
                                Crear Usuario <i class="bi bi-check-lg ms-1"></i>
                            </button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <footer>
        <div class="container">
            <p class="mb-0">© 2025 MediVital - Panel de Administración</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>