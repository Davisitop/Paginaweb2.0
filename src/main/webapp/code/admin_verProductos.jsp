<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.negocio.Producto"
%>

<%
    // Validar sesión y perfil admin (1)
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
    <meta charset="UTF-8">
    <title>Administrar Productos - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        #formAgregarProducto { display: none; margin-bottom: 30px; padding: 20px; background: white; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        label { font-weight: bold; }
    </style>
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

    <h2>Gestión de Productos (Admin)</h2>
    <p>Bienvenido, <strong><%= usuario %></strong></p>

    <!-- Botón para mostrar/ocultar formulario -->
    <button class="btn btn-success mb-3" onclick="toggleForm()">Añadir Producto Nuevo</button>

    <!-- Formulario para agregar producto -->
    <div id="formAgregarProducto">
        <form action="guardarProducto.jsp" method="post">
            <div class="mb-3">
                <label for="txt_nombre" class="form-label">Nombre:</label>
                <input type="text" class="form-control" id="txt_nombre" name="txt_nombre" required>
            </div>
            <div class="mb-3">
                <label for="cmb_categoria" class="form-label">Categoría:</label>
                <select class="form-select" id="cmb_categoria" name="cmb_categoria" required>
                    <option value="" disabled selected>Seleccione una categoría</option>
                    <option value="1">Electrónicos</option>
                    <option value="2">Hogar</option>
                    <option value="3">Ropa</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="txt_precio" class="form-label">Precio:</label>
                <input type="number" step="0.01" class="form-control" id="txt_precio" name="txt_precio" required>
            </div>
            <div class="mb-3">
                <label for="txt_cantidad" class="form-label">Cantidad:</label>
                <input type="number" class="form-control" id="txt_cantidad" name="txt_cantidad" required>
            </div>
            <button type="submit" class="btn btn-primary">Guardar Producto</button>
            <button type="button" class="btn btn-secondary" onclick="toggleForm()">Cancelar</button>
        </form>
    </div>

    <!-- Listado de productos -->
    <div class="card mt-4">
        <div class="card-header">
            Listado de Productos
        </div>
        <div class="card-body">
            <%
                Producto prod = new Producto();
                out.print(prod.reporteProducto());
            %>
        </div>
    </div>

    <a href="index.jsp" class="btn btn-secondary mt-4">Volver al Inicio</a>

</div>
</body>
</html>
