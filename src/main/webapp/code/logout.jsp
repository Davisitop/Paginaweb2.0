<%@ page language="java" contentType="text/html; charset=UTF-8" session="true" %>
<%
    // Invalidar la sesión para cerrar sesión
    session.invalidate();
    // Redirigir al login o página inicial
    response.sendRedirect("login.jsp");
%>
