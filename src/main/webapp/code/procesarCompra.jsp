<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"
    import="java.util.*, java.sql.*, com.productos.modelo.ItemCarrito, com.productos.datos.Conexion" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Procesar Compra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="p-5">

<%
    // 1. Obtener el carrito
    ArrayList<ItemCarrito> carrito =
        (ArrayList<ItemCarrito>) session.getAttribute("carrito");

    if (carrito == null || carrito.size() == 0) {
%>
        <h2>No hay productos en el carrito.</h2>
        <a href="productos.jsp" class="btn btn-primary mt-3">Volver</a>
<%
        return;
    }

    // 2. Crear conexión usando TU CLASE Conexion.java
    Conexion cn = new Conexion();
    Connection con = cn.getConexion();

    if (con == null) {
%>
        <h2>Error: No se pudo conectar a la base de datos.</h2>
<%
        return;
    }

    try {

        // 3. Calcular TOTAL
        double total = 0;
        for (ItemCarrito it : carrito) {
            total += it.getSubtotal();
        }

        // 4. Insertar en tb_venta
        PreparedStatement psVenta = con.prepareStatement(
            "INSERT INTO tb_venta (fecha, total) VALUES (NOW(), ?) RETURNING id_venta"
        );
        psVenta.setDouble(1, total);

        ResultSet rsVenta = psVenta.executeQuery();
        rsVenta.next();
        int idVenta = rsVenta.getInt("id_venta");

        // 5. Insertar detalles
        PreparedStatement psDet = con.prepareStatement(
            "INSERT INTO tb_detalle_venta(id_venta, id_producto, cantidad, precio) VALUES (?,?,?,?)"
        );

        for (ItemCarrito it : carrito) {
            psDet.setInt(1, idVenta);
            psDet.setInt(2, it.getId());
            psDet.setInt(3, it.getCantidad());
            psDet.setDouble(4, it.getPrecio());
            psDet.executeUpdate();
        }

        // 6. Vaciar carrito
        session.removeAttribute("carrito");

%>

    <h1 class="text-success">✔ ¡Compra registrada con éxito!</h1>
    <h3>ID de la compra: <%= idVenta %></h3>
    <p>Total pagado: <b>$<%= total %></b></p>

    <a href="productos.jsp" class="btn btn-primary mt-3">Volver a productos</a>

<%
    } catch (Exception e) {
%>
    <h2 class="text-danger">Error al procesar la compra:</h2>
    <p><%= e.getMessage() %></p>
<%
    }
%>

</body>
</html>
