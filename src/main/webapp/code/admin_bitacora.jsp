<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, com.productos.datos.Conexion"%>

<%
Integer perfil = (Integer) session.getAttribute("perfil");
if (perfil == null || perfil != 1) {
    response.sendRedirect("login.jsp?error=Acceso%20no%20autorizado");
    return;
}

Conexion con = new Conexion();
Statement st = con.getConexion().createStatement();
ResultSet rs = st.executeQuery(
    "SELECT b.id_bit, u.nombre_us, b.accion, b.fecha, b.detalle " +
    "FROM tb_bitacora b LEFT JOIN tb_usuario u ON b.id_usuario = u.id_us " +
    "ORDER BY b.fecha DESC"
);
%>

<!DOCTYPE html>
<html>
<head>
<title>Bitácora</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Bitácora del Sistema</h2>
    <table class="table table-striped">
        <thead>
            <tr><th>ID</th><th>Usuario</th><th>Acción</th><th>Fecha</th><th>Detalle</th></tr>
        </thead>
        <tbody>
        <%
        while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
                <td><%= rs.getTimestamp(4) %></td>
                <td><%= rs.getString(5) %></td>
            </tr>
        <%
        }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
