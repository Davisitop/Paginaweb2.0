<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.productos.seguridad.Usuario"
    session="true"%>

<%
if (session.getAttribute("perfil") == null || (Integer)session.getAttribute("perfil") != 1) {
    response.sendRedirect("login.jsp?error=Acceso+no+autorizado");
    return;
}

Usuario u = new Usuario();
String tabla = u.reporteUsuarios();
%>

<!DOCTYPE html>
<html>
<head>
<title>Usuarios</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Gestión de Usuarios</h2>
    <a href="index.jsp" class="btn btn-secondary">Volver</a>
    <div class="card mt-3">
        <div class="card-body">
            <%= tabla %>
        </div>
    </div>
</div>
</body>
</html>
