<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"
    import="java.util.*, com.productos.modelo.ItemCarrito" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }
        h1 {
            text-align: center;
            margin-top: 40px;
            font-weight: bold;
            color: #333;
        }
        .container {
            margin-top: 40px;
            max-width: 900px;
        }
        table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th {
            background: #e9ecef;
            font-weight: bold;
        }
        .btn-danger {
            padding: 3px 8px;
            font-size: 0.9em;
        }
        .total-box {
            text-align: right;
            font-size: 1.6em;
            margin-top: 20px;
            font-weight: bold;
        }
        .btn-group {
            float: right;
            margin-top: 25px;
        }
    </style>
</head>

<body>

<h1>🛒 Carrito de Compras</h1>

<div class="container">

<%
    // ===========================
    // CARGAR EL CARRITO
    // ===========================
    ArrayList<ItemCarrito> carrito =
        (ArrayList<ItemCarrito>) session.getAttribute("carrito");

    if (carrito == null || carrito.size() == 0) {
%>

    <h3 class="text-center mt-5">El carrito está vacío.</h3>
    <div class="text-center mt-4">
        <a href="productos.jsp" class="btn btn-primary">Volver a productos</a>
    </div>

<%
        return;
    }
%>


<table class="table table-bordered">
    <thead>
        <tr>
            <th>Producto</th>
            <th>Precio</th>
            <th>Cant.</th>
            <th>Subtotal</th>
            <th></th>
        </tr>
    </thead>

    <tbody>

<%
    double total = 0;

    for (ItemCarrito item : carrito) {

        total += item.getSubtotal();
%>

        <tr>
            <td><%= item.getNombre() %></td>
            <td>$ <%= item.getPrecio() %></td>
            <td><%= item.getCantidad() %></td>
            <td>$ <%= item.getSubtotal() %></td>

            <td>
                <a href="quitarItem.jsp?id=<%= item.getId() %>"
                   class="btn btn-danger">Quitar</a>
            </td>
        </tr>

<%
    }
%>

    </tbody>
</table>

<div class="total-box">
    Total: $ <%= total %>
</div>

<div class="btn-group">

    <a href="productos.jsp" class="btn btn-secondary">
        Seguir comprando
    </a>

    <a href="vaciarCarrito.jsp" class="btn btn-danger">
        Vaciar carrito
    </a>

    <!-- BOTÓN COMPRAR -->
    <a href="procesarCompra.jsp" class="btn btn-success">
        Comprar 🛒
    </a>

</div>

</div>

</body>
</html>
