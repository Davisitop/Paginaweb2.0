<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Usuario"
    import="com.productos.seguridad.Bitacora"
%>

<%
    // ================================
    //   PROTEGER SOLO PARA ADMIN
    // ================================
    if (session.getAttribute("perfil") == null || (Integer) session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }

    // ID del usuario que se va a eliminar
    String id = request.getParameter("id");

    // Si ya se confirmó la eliminación:
    String opcion = request.getParameter("confirmar");

    if (opcion != null && opcion.equals("si")) {

        Usuario u = new Usuario();
        u.eliminarUsuario(id);

        // Registro en bitácora
        Integer idAdmin = (Integer) session.getAttribute("id_usuario");
        if (idAdmin == null) idAdmin = 0;

        Bitacora b = new Bitacora();
        b.registrar(idAdmin, "ELIMINAR USUARIO", "Eliminó usuario ID: " + id);

        response.sendRedirect("admin_verUsuarios.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Eliminar Usuario</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">

    <div class="alert alert-danger text-center">
        <h3>¿Seguro que deseas eliminar este usuario?</h3>
        <p>Esta acción no se puede deshacer.</p>

        <a href="admin_eliminarUsuario.jsp?id=<%= id %>&confirmar=si" class="btn btn-danger">Sí, eliminar</a>
        <a href="admin_verUsuarios.jsp" class="btn btn-secondary">Cancelar</a>
    </div>

</div>

</body>
</html>
