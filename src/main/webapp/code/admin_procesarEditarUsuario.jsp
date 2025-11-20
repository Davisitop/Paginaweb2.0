<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Usuario"
    import="com.productos.seguridad.Bitacora"
%>

<%
    // PROTECCIÓN: SOLO ADMIN
    if (session.getAttribute("perfil") == null || (Integer) session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }

    // === OBTENER DATOS DEL FORM ===
    String id = request.getParameter("id");
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");
    int perfilNuevo = Integer.parseInt(request.getParameter("perfil"));

    Usuario u = new Usuario();
    String mensaje = u.actualizarUsuario(id, nombre, correo, clave, perfilNuevo);

    // === REGISTRAR EN BITÁCORA ===
    Integer idAdmin = (Integer) session.getAttribute("id_usuario");
    if (idAdmin == null) idAdmin = 0;

    Bitacora b = new Bitacora();
    b.registrar(idAdmin, "EDITAR USUARIO", "Editó el usuario ID: " + id);

    // REDIRIGIR
    response.sendRedirect("admin_verUsuarios.jsp");
%>
