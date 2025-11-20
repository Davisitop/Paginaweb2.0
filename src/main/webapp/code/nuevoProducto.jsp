<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Pagina"
    import="com.productos.negocio.Producto"
%>

<%
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (usuario == null || perfil == null || perfil != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Gestión de Productos - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script>
        function toggleForm() {
            const form = document.getElementById('formAgregarProducto');
            if (form.style.display === 'none' || form.style.display === '') {
                form.style.display = 'block';
            } else {
                form.style.display = 'none';
            }
        }
    </script>
</head>
<body>
<div class="container mt-4">

    <h1>Gestión de Productos (Admin)</h1>
    <p>Bienvenido, <strong><%= usuario %></strong></p>

    <nav class="mb-4">
        <a href="index.jsp" class="btn btn-secondary">Inicio</a>
        <a href="logout.jsp" class="btn btn-danger float-end">Cerrar Sesión</a>
    </nav>

    <% 
        String msg = request.getParameter("msg");
        if (msg != null && !msg.trim().isEmpty()) {
    %>
        <div class="alert alert-info"><%= msg %></div>
    <% } %>

    <!-- Botón para mostrar/ocultar formulario -->
    <button class="btn btn-success mb-3" onclick="toggleForm()">Añadir Producto Nuevo</button>

    <!-- Formulario oculto inicialmente -->
    <div id="formAgregarProducto" style="display:none;">
        <div class="card mb-4">
            <div class="card-header">Agregar Nuevo Producto</div>
            <div class="card-body">
                <form action="guardarProducto.jsp" method="post">
                    <div class="mb-3">
                        <label for="txt_nombre" class="form-label">Nombre:</label>
                        <input type="text" id="txt_nombre" name="txt_nombre" class="form-control" required />
                    </div>
                    <div class="mb-3">
                        <label for="cmb_categoria" class="form-label">Categoría:</label>
                        <select id="cmb_categoria" name="cmb_categoria" class="form-select" required>
                            <option value="1">Electrónicos</option>
                            <option value="2">Hogar</option>
                            <option value="3">Ropa</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txt_precio" class="form-label">Precio:</label>
                        <input type="number" id="txt_precio" name="txt_precio" step="0.01" class="form-control" required />
                    </div>
                    <div class="mb-3">
                        <label for="txt_cantidad" class="form-label">Cantidad:</label>
                        <input type="number" id="txt_cantidad" name="txt_cantidad" class="form-control" required />
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Producto</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Listado de productos -->
    <div class="card">
        <div class="card-header">Listado de Productos</div>
        <div class="card-body">
            <%
                Producto prod = new Producto();
                out.print(prod.reporteProducto());
            %>
        </div>
    </div>

</div>
</body>
</html>
