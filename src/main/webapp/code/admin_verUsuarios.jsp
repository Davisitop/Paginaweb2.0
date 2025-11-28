<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Usuario"
    import="com.productos.seguridad.Pagina"
%>

<%
    // --- PROTECCIÓN DE SEGURIDAD ---
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");

    if (perfil == null || perfil != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }

    // Obtener la tabla de usuarios
    Usuario u = new Usuario();
    String tabla = u.reporteUsuarios();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios - Admin MediVital</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        /* --- ESTILOS GENERALES --- */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
            color: #333;
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
            background: linear-gradient(135deg, #212529, #495057);
            color: white;
            padding: 60px 0 40px;
            text-align: center;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        /* Tarjeta de Contenido */
        .content-card {
            border: none;
            border-radius: 20px;
            background: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        .card-header-custom {
            background-color: #fff;
            padding: 20px 30px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Estilos para la tabla inyectada */
        .table-custom thead {
            background-color: #f8f9fa;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            color: #6c757d;
        }
        .table-custom th, .table-custom td {
            vertical-align: middle;
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        .table-custom tr:hover {
            background-color: #fdfdfd;
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
            <h1 class="fw-bold">Directorio de Usuarios</h1>
            <p class="mb-0 opacity-75">Administración de cuentas, perfiles y accesos del sistema</p>
        </div>
    </header>

    <div class="container mb-5">
        <div class="content-card">
            
            <div class="card-header-custom">
                <h4 class="mb-0 fw-bold text-dark">
                    <i class="bi bi-people-fill text-primary me-2"></i> Usuarios Registrados
                </h4>
                <a href="admin_crearUsuario.jsp" class="btn btn-primary rounded-pill px-4 shadow-sm">
                    <i class="bi bi-person-plus-fill me-2"></i> Nuevo Usuario
                </a>
            </div>

            <div class="card-body p-0">
                <div class="table-responsive">
                    <%
                        // Truco visual: Reemplazamos la etiqueta simple <table> que viene de Java
                        // por una con clases de Bootstrap para que se vea bonita sin tocar el Java.
                        if (tabla != null) {
                            String tablaEstilizada = tabla.replace("class='table table-striped'", "class='table table-custom table-hover mb-0'");
                            // Si la clase Java original no tenía class, intentamos reemplazar solo <table>
                            if (!tablaEstilizada.contains("table-custom")) {
                                tablaEstilizada = tabla.replace("<table", "<table class='table table-custom table-hover mb-0'");
                            }
                            out.print(tablaEstilizada);
                        } else {
                    %>
                        <div class="p-5 text-center text-muted">
                            <i class="bi bi-exclamation-circle display-4"></i>
                            <p class="mt-3">No se encontraron usuarios o hubo un error de conexión.</p>
                        </div>
                    <%
                        }
                    %>
                </div>
            </div>
            
            <div class="bg-light p-3 text-center text-muted small border-top">
                Base de datos de personal y clientes MediVital
            </div>
        </div>
        
        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-outline-secondary rounded-pill px-4">
                <i class="bi bi-arrow-left"></i> Volver al Inicio
            </a>
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