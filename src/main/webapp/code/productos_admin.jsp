<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.productos.negocio.Producto" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Productos (Admin)</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

</head>
<body class="container mt-4">

    <h2>Gestión de Productos (Admin)</h2>
    <hr>

    <!-- BOTÓN PARA AÑADIR PRODUCTO -->
    <a href="agregar_producto.jsp" class="btn btn-success mb-3">
        Añadir Producto
    </a>

    <!-- TABLA DE PRODUCTOS -->
    <%
        Producto prod = new Producto();
        out.print(prod.reporteProducto());
    %>

    <!-- Bootstrap Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
