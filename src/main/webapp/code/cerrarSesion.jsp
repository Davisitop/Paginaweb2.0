<%@ page contentType="text/html; charset=UTF-8" language="java" %><%@ page import="com.productos.seguridad.Bitacora" %>

<%
    // Invalidar la sesión actual
    session.invalidate();
%>
<script>
    alert("Sesión cerrada correctamente");
    window.location = "index.jsp";
</script>
