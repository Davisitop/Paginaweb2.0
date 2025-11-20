<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Bitacora"
%>

<%
    // --- PROTEGER SOLO PARA ADMIN ---
    if (session.getAttribute("perfil") == null || (Integer) session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }

    Bitacora b = new Bitacora();
    String tabla = b.reporteBitacora();
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Bitácora del Sistema</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3 class="text-center">Registro de Actividades (Bitácora)</h3>
        </div>

        <div class="card-body">
            <%= tabla %>
        </div>

        <div class="card-footer text-center">
            <a href="index.jsp" class="btn btn-secondary">Volver</a>
        </div>
    </div>

</div>

</body>
</html>
