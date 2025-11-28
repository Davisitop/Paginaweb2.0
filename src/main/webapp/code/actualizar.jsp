<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.datos.Conexion"
    import="java.sql.ResultSet"
    import="java.sql.Connection"
    import="java.sql.Statement"
    import="com.productos.seguridad.Pagina"
%><%@ page import="com.productos.seguridad.Bitacora" %>

<%
    // --- PROTECCIÓN DE SEGURIDAD ---
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");

    if (perfil == null || perfil != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }
    
    // 1. Obtener el ID del producto
    String id = request.getParameter("id");

    // 2. Conectar y buscar datos
    Conexion con = new Conexion();
    Connection cn = con.getConexion();
    Statement st = null;
    ResultSet rs = null;
    
    if (cn == null || id == null || id.isEmpty()) {
        response.sendRedirect("admin_verProductos.jsp?error=ID no valido");
        return;
    }
    
    String sql = "SELECT * FROM tb_producto WHERE id_pr = " + id;
    st = cn.createStatement();
    rs = st.executeQuery(sql);
    
    // 3. Verificar si existe el producto
    boolean productoEncontrado = rs.next();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Producto - Admin MediVital</title>

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
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            color: white;
            padding: 60px 0 40px;
            text-align: center;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(253, 126, 20, 0.2);
        }

        /* Tarjeta de Edición */
        .edit-card {
            border: none;
            border-radius: 20px;
            background: white;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            max-width: 700px;
            margin: 0 auto;
            overflow: hidden;
        }
        .edit-header {
            background-color: #fff3cd;
            color: #856404;
            padding: 20px;
            text-align: center;
            font-weight: 600;
            border-bottom: 1px solid #ffeeba;
        }
        .edit-body {
            padding: 40px;
        }

        /* Inputs */
        .form-label {
            font-weight: 600;
            color: #555;
            font-size: 0.9rem;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .input-group-text {
            background-color: #fffbf0;
            border-color: #ffeeba;
            color: #fd7e14;
        }
        .form-control, .form-select {
            border-color: #ffeeba;
            padding: 10px 15px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #fd7e14;
            box-shadow: 0 0 0 0.25rem rgba(253, 126, 20, 0.25);
        }

        /* Botones */
        .btn-save {
            background-color: #fd7e14;
            color: white;
            border-radius: 50px;
            padding: 10px 30px;
            font-weight: 600;
            border: none;
            transition: all 0.3s;
            width: 100%;
        }
        .btn-save:hover {
            background-color: #e6700c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(253, 126, 20, 0.3);
        }
        .btn-cancel {
            border-radius: 50px;
            padding: 10px 30px;
            width: 100%;
            font-weight: 600;
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
            <h1 class="fw-bold">Modificar Producto</h1>
            <p class="mb-0 opacity-90">Actualiza la información del inventario</p>
        </div>
    </header>

    <div class="container mb-5">
        
        <% if (productoEncontrado) { %>
        
        <div class="edit-card">
            <div class="edit-header">
                <i class="bi bi-pencil-square me-2"></i> Editando: <strong><%= rs.getString("nombre_pr") %></strong> (ID: <%= id %>)
            </div>
            <div class="edit-body">
                <form action="admin_procesarActualizacion.jsp" method="post">
                    
                    <input type="hidden" name="id" value="<%= id %>">

                    <div class="mb-4">
                        <label for="nombre" class="form-label">Nombre del Producto</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-tag-fill"></i></span>
                            <input type="text" class="form-control" id="nombre" name="nombre" 
                                   value="<%= rs.getString("nombre_pr") %>" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="categoria" class="form-label">Categoría</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-grid-fill"></i></span>
                            <select class="form-select" name="categoria" id="categoria" required>
                                <option value="1" <%= rs.getInt("id_cat") == 1 ? "selected" : "" %>>Equipamiento (Electrónicos)</option>
                                <option value="2" <%= rs.getInt("id_cat") == 2 ? "selected" : "" %>>Hogar / Muebles</option>
                                <option value="3" <%= rs.getInt("id_cat") == 3 ? "selected" : "" %>>Ropa / Uniformes</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label for="precio" class="form-label">Precio Unitario</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-currency-dollar"></i></span>
                                <input type="number" step="0.01" class="form-control" id="precio" name="precio" 
                                       value="<%= rs.getDouble("precio_pr") %>" required>
                            </div>
                        </div>

                        <div class="col-md-6 mb-4">
                            <label for="cantidad" class="form-label">Stock Disponible</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-boxes"></i></span>
                                <input type="number" class="form-control" id="cantidad" name="cantidad" 
                                       value="<%= rs.getInt("cantidad_pr") %>" required>
                            </div>
                        </div>
                    </div>

                    <hr class="my-4 opacity-25">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <a href="admin_verProductos.jsp" class="btn btn-outline-secondary btn-cancel d-flex align-items-center justify-content-center">
                                <i class="bi bi-x-lg me-2"></i> Cancelar
                            </a>
                        </div>
                        <div class="col-md-6">
                            <button type="submit" class="btn btn-save">
                                <i class="bi bi-check-circle-fill me-2"></i> Guardar Cambios
                            </button>
                        </div>
                    </div>

                </form>
            </div>
        </div>

        <% } else { %>

        <div class="alert alert-danger text-center shadow p-5 rounded-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill display-4 text-danger mb-3"></i>
            <h2 class="alert-heading">¡Producto no encontrado!</h2>
            <p>El producto con ID <strong><%= id %></strong> no existe o ha sido eliminado.</p>
            <hr>
            <a href="admin_verProductos.jsp" class="btn btn-dark rounded-pill px-4">Volver al Inventario</a>
        </div>

        <% } %>

    </div>

    <footer>
        <div class="container">
            <p class="mb-0">© 2025 MediVital - Panel de Administración</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

<%
    // Limpieza de recursos
    try {
        if (rs != null) rs.close();
        if (st != null) st.close();
        if (cn != null) cn.close();
    } catch (Exception e) {}
%>