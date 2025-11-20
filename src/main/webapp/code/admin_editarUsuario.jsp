<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Usuario"
    import="com.productos.seguridad.Bitacora"
%>

<%
    // --- PROTECCIÓN SOLO ADMIN ---
    if (session.getAttribute("perfil") == null || (Integer) session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }

    String id = request.getParameter("id");
    if (id == null) {
        response.sendRedirect("admin_verUsuarios.jsp?error=Falta+ID");
        return;
    }

    Usuario u = new Usuario();
    Usuario datos = u.obtenerUsuarioPorId(id);

    if (datos == null) {
        response.sendRedirect("admin_verUsuarios.jsp?error=Usuario+no+existe");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Editar Usuario</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">

    <div class="card">
        <div class="card-header bg-warning text-dark">
            <h3>Editar Usuario (ID: <%= id %>)</h3>
        </div>

        <div class="card-body">

            <form method="post" action="admin_procesarEditarUsuario.jsp">

                <input type="hidden" name="id" value="<%= id %>">

                <div class="mb-3">
                    <label class="form-label">Nombre Completo:</label>
                    <input type="text" class="form-control" name="nombre" value="<%= datos.getNombre() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Correo:</label>
                    <input type="email" class="form-control" name="correo" value="<%= datos.getCorreo() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Clave:</label>
                    <input type="text" class="form-control" name="clave" value="<%= datos.getClave() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Perfil:</label>
                    <select name="perfil" class="form-select">
                        <option value="1" <%= datos.getPerfil() == 1 ? "selected" : "" %>>Administrador</option>
                        <option value="2" <%= datos.getPerfil() == 2 ? "selected" : "" %>>Cliente</option>
                        <option value="3" <%= datos.getPerfil() == 3 ? "selected" : "" %>>Empleado</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-warning">Guardar Cambios</button>
                <a href="admin_verUsuarios.jsp" class="btn btn-secondary">Cancelar</a>

            </form>

        </div>
    </div>

</div>

</body>
</html>
