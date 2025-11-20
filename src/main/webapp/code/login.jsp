<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.productos.seguridad.Bitacora" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - MediVital</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #dfe9f3, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0; /* Asegura que no haya márgenes en el body */
        }
        .login-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            width: 320px;
            text-align: center;
        }
        .login-container img {
            width: 100px;
            border-radius: 50%;
            margin-bottom: 15px;
        }
        .login-container input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
        .login-container button {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 8px;
            width: 100%;
            cursor: pointer;
        }
        .login-container button:hover {
            background-color: #0056b3;
        }
        .login-container a {
            color: #007bff;
            text-decoration: none;
            font-size: 0.9em;
        }
        .error-msg {
            color: #dc3545;
            font-size: 0.9em;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="../image/logo.PNG" alt="Logo MediVital">
        <h2>Iniciar Sesión</h2>
        <form action="validarLogin.jsp" method="post">
            <input type="text" name="usuario" placeholder="Correo electrónico" required>
            <input type="password" name="clave" placeholder="Contraseña" required>
            <button type="submit">Entrar</button>
        </form>
        <p>¿No tienes cuenta? <a href="nuevoCliente.jsp">Regístrate aquí</a></p>
        
        <%-- Mostrar mensaje de error (usando request.getParameter) --%>
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="error-msg"><%= error %></div>
        <%
            }
        %>
    </div>
</body>
</html>