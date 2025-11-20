<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    session="true" 
    import="com.productos.seguridad.Usuario" 
%>
<%@ page import="com.productos.seguridad.Bitacora" %>

<%
    // 1. Instancia del objeto Usuario (como en tu práctica 5)
    Usuario objUsuario = new Usuario(); 

    // 2. Obtener los valores del formulario
    String nlogin = request.getParameter("usuario");
    String nclave = request.getParameter("clave");

    // 3. Crear/obtener la sesión
    HttpSession sesion = request.getSession(); 

    // 4. Verificar credenciales contra la BD
    boolean respuesta = objUsuario.verificarUsuario(nlogin, nclave);

    if (respuesta) {

        // =============== LOGIN EXITOSO ===============

        // 5. Guardar datos en la sesión
        sesion.setAttribute("usuario", objUsuario.getNombre()); 
        sesion.setAttribute("perfil", objUsuario.getPerfil());
        sesion.setAttribute("id_usuario", objUsuario.getId());   // ← necesario para la bitácora

        // 6. Registrar actividad en la bitácora
        Bitacora b = new Bitacora();
        b.registrar(objUsuario.getId(), "LOGIN", "El usuario inició sesión");

        // 7. Redirigir al index (modo página principal)
        response.sendRedirect("index.jsp");

    } else {

        // =============== LOGIN FALLIDO ===============

%>
        <jsp:forward page="index.jsp">
            <jsp:param name="error" value="Datos incorrectos.<br/>Vuelva a intentarlo." />
        </jsp:forward>
<%
    }
%>
