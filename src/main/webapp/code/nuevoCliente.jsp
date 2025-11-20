<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.productos.seguridad.Bitacora" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nuevo Cliente</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f3;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .formulario {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.2);
            width: 450px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: #34495e;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .radio-group {
            margin-top: 5px;
        }

        .radio-group input {
            margin-right: 5px;
        }

        .boton {
            margin-top: 20px;
            width: 100%;
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        .boton:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <form class="formulario" action="registrarCliente.jsp" method="post">
        <h2>Registro de Cliente</h2>

        <label for="txtNombre">Nombre completo:</label>
        <input type="text" id="txtNombre" name="txtNombre" required>

        <label for="txtCedula">Cédula:</label>
        <input type="text" id="txtCedula" name="txtCedula" required>

        <label for="cmbEstado">Estado civil:</label>
        <select id="cmbEstado" name="cmbEstado">
            <option value="1">Soltero</option>
            <option value="2">Casado</option>
            <option value="3">Divorciado</option>
            <option value="4">Viudo</option>
        </select>

        <label>Tipo de residencia:</label>
        <div class="radio-group">
            <input type="radio" name="rdResidencia" value="Urbana" checked> Urbana
            <input type="radio" name="rdResidencia" value="Rural"> Rural
        </div>

        <label for="mFecha">Fecha de nacimiento:</label>
        <input type="month" id="mFecha" name="mFecha">

        <label for="cColor">Color favorito:</label>
        <input type="color" id="cColor" name="cColor" value="#2ecc71">

        <label for="txtCorreo">Correo electrónico:</label>
        <input type="email" id="txtCorreo" name="txtCorreo" required>

        <label for="txtClave">Contraseña:</label>
        <input type="password" id="txtClave" name="txtClave" required>

        <button type="submit" class="boton">Registrar</button>
    </form>
</body>
</html>
