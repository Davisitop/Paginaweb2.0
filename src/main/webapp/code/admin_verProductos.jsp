<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.negocio.Producto"
    import="com.productos.seguridad.Pagina"
%>

<%
    // --- PROTECCIÓN DE SEGURIDAD ---
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");

    if (usuario == null || perfil == null || perfil != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }

    // Obtener tabla de productos
    Producto prod = new Producto();
    String tablaProductos = prod.reporteProducto();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario - Admin MediVital</title>

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

        /* Hero Header */
        .page-header {
            background: linear-gradient(135deg, #17a2b8, #138496);
            color: white;
            padding: 60px 0 40px;
            text-align: center;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(23, 162, 184, 0.2);
        }

        /* Tarjetas */
        .content-card {
            border: none;
            border-radius: 20px;
            background: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 30px;
        }
        .card-header-custom {
            background-color: #fff;
            padding: 20px 30px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Formulario */
        .form-container {
            background-color: #fcfcfc;
            border-bottom: 1px solid #eee;
            padding: 30px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #17a2b8;
            box-shadow: 0 0 0 0.25rem rgba(23, 162, 184, 0.25);
        }
        .input-group-text {
            background-color: white;
            border-right: none;
            color: #17a2b8;
        }
        .form-control { border-left: none; }

        /* Tabla Estilizada */
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
            background-color: #f1f9fa;
        }

        /* Botones */
        .btn-action {
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.3s;
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
            <h1 class="fw-bold">Inventario de Productos</h1>
            <p class="mb-0 opacity-75">Gestión de catálogo, stock y precios</p>
        </div>
    </header>

    <div class="container mb-5">

        <div class="content-card">
            
            <div class="card-header-custom">
                <h4 class="mb-0 fw-bold text-dark">
                    <i class="bi bi-box-seam text-info me-2"></i> Listado General
                </h4>
                <button class="btn btn-info text-white btn-action shadow-sm" type="button" data-bs-toggle="collapse" data-bs-target="#collapseForm" aria-expanded="false" aria-controls="collapseForm">
                    <i class="bi bi-plus-lg me-1"></i> Nuevo Producto
                </button>
            </div>

            <div class="collapse" id="collapseForm">
                <div class="form-container">
                    <h5 class="mb-4 text-muted border-bottom pb-2">Registrar Producto</h5>
                    <form action="guardarProducto.jsp" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">NOMBRE</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-tag"></i></span>
                                    <input type="text" class="form-control" name="txt_nombre" placeholder="Ej. Monitor Cardíaco" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">CATEGORÍA</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-list-ul"></i></span>
                                    <select class="form-select" name="cmb_categoria" required>
                                        <option value="" disabled selected>Seleccionar...</option>
                                        <option value="1">Electrónicos</option>
                                        <option value="2">Hogar / Muebles</option>
                                        <option value="3">Ropa / Uniformes</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label small fw-bold text-muted">PRECIO ($)</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-currency-dollar"></i></span>
                                    <input type="number" step="0.01" class="form-control" name="txt_precio" placeholder="0.00" required>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label small fw-bold text-muted">CANTIDAD</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-boxes"></i></span>
                                    <input type="number" class="form-control" name="txt_cantidad" placeholder="0" required>
                                </div>
                            </div>

                            <div class="col-md-4 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100 btn-action">Guardar</button>
                                <button type="button" class="btn btn-light ms-2 border" data-bs-toggle="collapse" data-bs-target="#collapseForm">Cancelar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card-body p-0">
                <div class="table-responsive">
                    <%
                        if (tablaProductos != null) {
                            // Inyección de estilos Bootstrap a la tabla HTML cruda
                            String tablaMejorada = tablaProductos;
                            
                            // Reemplazar clase básica o tag table
                            if (tablaMejorada.contains("class=")) {
                                tablaMejorada = tablaMejorada.replace("class='table", "class='table table-custom table-hover mb-0");
                                tablaMejorada = tablaMejorada.replace("class=\"table", "class=\"table table-custom table-hover mb-0");
                            } else {
                                tablaMejorada = tablaMejorada.replace("<table", "<table class='table table-custom table-hover mb-0'");
                            }

                            out.print(tablaMejorada);
                        } else {
                    %>
                        <div class="p-5 text-center text-muted">
                            <i class="bi bi-inbox display-4 opacity-50"></i>
                            <p class="mt-3">No hay productos registrados o error de conexión.</p>
                        </div>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="bg-light p-3 text-center text-muted small border-top">
                Mostrando inventario completo del sistema
            </div>

        </div>

        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-outline-secondary rounded-pill px-4">
                <i class="bi bi-house-door-fill me-2"></i> Volver al Inicio
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