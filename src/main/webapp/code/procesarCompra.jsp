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

<body class="p-5 text-center bg-light">

<%
    // 1. Validar Carrito
    ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");

    if (carrito == null || carrito.size() == 0) {
        response.sendRedirect("productos.jsp");
        return;
    }

    // 2. Recibir datos del formulario de pago (pago.jsp)
    String metodoPago = request.getParameter("metodoPago");
    String titular = request.getParameter("titular");
    String numeroTarjeta = request.getParameter("numeroTarjeta");
    
    // Extraer últimos 4 dígitos para seguridad (simulada)
    String ultimosDigitos = "0000";
    if (numeroTarjeta != null && numeroTarjeta.length() >= 4) {
        // Limpiamos espacios primero
        String limpio = numeroTarjeta.replace(" ", "");
        if (limpio.length() >= 4) {
            ultimosDigitos = limpio.substring(limpio.length() - 4);
        }
    }
    
    // Si es efectivo, ajustamos los valores
    if ("Efectivo".equals(metodoPago)) {
        titular = "Cliente (Contra Entrega)";
        ultimosDigitos = "N/A";
    }

    // 3. Conexión a Base de Datos
    Conexion cn = new Conexion();
    Connection con = cn.getConexion();

    if (con == null) {
        out.print("<h2 class='text-danger'>Error: Sin conexión a BD.</h2>");
        return;
    }

    try {
        // 4. Calcular TOTAL
        double total = 0;
        for (ItemCarrito it : carrito) {
            total += it.getSubtotal();
        }

        // 5. Insertar en tb_venta (con los nuevos campos de pago)
        // Nota: Asegúrate de haber corrido el script SQL del paso 1
        String sqlVenta = "INSERT INTO tb_venta (fecha, total, metodo_pago, titular_tarjeta, ultimos_digitos) "
                        + "VALUES (NOW(), ?, ?, ?, ?) RETURNING id_venta";
        
        PreparedStatement psVenta = con.prepareStatement(sqlVenta);
        psVenta.setDouble(1, total);
        psVenta.setString(2, metodoPago);
        psVenta.setString(3, titular);
        psVenta.setString(4, ultimosDigitos);

        ResultSet rsVenta = psVenta.executeQuery();
        
        if (rsVenta.next()) {
            int idVenta = rsVenta.getInt("id_venta");

            // 6. Insertar detalles
            String sqlDetalle = "INSERT INTO tb_detalle_venta(id_venta, id_producto, cantidad, precio) VALUES (?,?,?,?)";
            PreparedStatement psDet = con.prepareStatement(sqlDetalle);

            for (ItemCarrito it : carrito) {
                psDet.setInt(1, idVenta);
                psDet.setInt(2, it.getId());
                psDet.setInt(3, it.getCantidad());
                psDet.setDouble(4, it.getPrecio());
                psDet.executeUpdate();
            }

            // 7. Vaciar carrito y cerrar recursos
            session.removeAttribute("carrito");
            psDet.close();
            psVenta.close();
            con.close();
%>

            <div class="card shadow p-4 mx-auto" style="max-width: 600px;">
                <h1 class="text-success display-4">✔ ¡Pago Exitoso!</h1>
                <hr>
                <p class="lead">Su compra ha sido procesada correctamente.</p>
                
                <div class="text-start bg-white p-3 rounded border">
                    <p><strong>ID de Compra:</strong> #<%= idVenta %></p>
                    <p><strong>Método de Pago:</strong> <%= metodoPago %></p>
                    <% if ("Tarjeta".equals(metodoPago)) { %>
                        <p><strong>Tarjeta terminada en:</strong> **** **** **** <%= ultimosDigitos %></p>
                    <% } %>
                    <p><strong>Total Pagado:</strong> $<%= total %></p>
                </div>

                <a href="productos.jsp" class="btn btn-primary mt-4">Volver a la Tienda</a>
            </div>

<%
        } else {
            throw new Exception("No se pudo obtener el ID de la venta.");
        }

    } catch (Exception e) {
%>
        <div class="alert alert-danger">
            <h2>Error al procesar la compra:</h2>
            <p><%= e.getMessage() %></p>
            <a href="carrito.jsp" class="btn btn-dark">Volver</a>
        </div>
<%
        e.printStackTrace();
    }
%>

</body>
</html>