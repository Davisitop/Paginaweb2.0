<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Usuario"
    import="com.productos.seguridad.Bitacora"
%>

<%
    // ================================
    //   PROTEGER LA PÁGINA (SOLO ADMIN)
    // ================================
    if (session.getAttribute("perfil") == null || (Integer) session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }

    // ================================
    //   RECIBIR DATOS DEL FORMULARIO
    // ================================
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");
    int idPer = Integer.parseInt(request.getParameter("perfil"));

    // ================================
    //   CREAR EL USUARIO EN BD
    // ================================
    Usuario u = new Usuario();
    String mensaje = u.ingresarUsuario(nombre, correo, clave, idPer);

    // ================================
    //   REGISTRAR EN BITÁCORA
    // ================================
    Integer idAdmin = (Integer) session.getAttribute("id_usuario");

    // Evitar NullPointer si por alguna razón la sesión no tiene id_usuario
    if (idAdmin == null) {
        idAdmin = 0; // usuario desconocido
    }

    Bitacora b = new Bitacora();
    b.registrar(idAdmin, "CREAR USUARIO", "Creó el usuario: " + nombre);

    // ================================
    //   REDIRIGIR AL LISTADO DE USUARIOS
    // ================================
    response.sendRedirect("admin_verUsuarios.jsp");
%>
