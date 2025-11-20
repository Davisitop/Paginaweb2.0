<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Pagina"
%><%@ page import="com.productos.seguridad.Bitacora" %>

<%
    // Protección de Página (Solo Admins)
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear Usuario - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header">
                        <h3>Crear Nuevo Usuario</h3>
                    </div>
                    <div class="card-body">
                        <form action="admin_guardarUsuario.jsp" method="post">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre Completo:</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="correo" class="form-label">Correo (Login):</label>
                                <input type="email" class="form-control" id="correo" name="correo" required>
                            </div>
                            <div class="mb-3">
                                <label for="clave" class="form-label">Contraseña:</label>
                                <input type="password" class="form-control" id="clave" name="clave" required>
                            </div>
                            <div class="mb-3">
                                <label for="perfil" class="form-label">Perfil:</label>
                                <select class="form-select" name="perfil" id="perfil">
                                    <option value="1">Administrador</option>
                                    <option value="3">Empleado (Vendedor)</option>
                                    <option value="2">Cliente</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Crear Usuario</button>
                            <a href="index.jsp" class="btn btn-secondary">Volver</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>