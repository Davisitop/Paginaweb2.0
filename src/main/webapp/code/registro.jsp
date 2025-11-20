<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ page import="com.productos.seguridad.Bitacora" %>
    
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Cliente</title>
    <script src="cliente.js"></script>
    <style>
        body {
            background-color: #c7c7c7;
            font-family: Arial, sans-serif;
        }
        form {
            background-color: #5a5a5a;
            color: white;
            margin: 50px auto;
            padding: 20px;
            border-radius: 10px;
            width: 450px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            padding: 8px;
        }
        input, select {
            width: 100%;
            padding: 6px;
            border-radius: 6px;
            border: none;
        }
        input[type="radio"] {
            width: auto;
        }
        input[type="color"] {
            width: 60px;
        }
        input[type="submit"], input[type="reset"] {
            width: 48%;
            background-color: #ddd;
            border: none;
            padding: 10px;
            border-radius: 6px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #28a745;
            color: white;
        }
        input[type="reset"]:hover {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>
    <form id="formCliente" action="nuevoCliente.jsp" method="post" enctype="multipart/form-data">
        <h2>Registro de nuevo Cliente</h2>
        <table border="1">
            <tr>
                <td>Nombre</td>
                <td><input type="text" id="nombre" name="txtNombre" required />*</td>
            </tr>
            <tr>
                <td>Cédula</td>
                <td><input type="text" id="cedula" name="txtCedula" maxlength="10" required />*</td>
            </tr>
            <tr>
                <td>Estado Civil</td>
                <td>
                    <select id="estado" name="cmbEstado">
                        <option>Soltero</option>
                        <option>Casado</option>
                        <option>Divorciado</option>
                        <option>Viudo</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Lugar de Residencia</td>
                <td>
                    <input type="radio" name="rdResidencia" value="Sur" required> Sur
                    <input type="radio" name="rdResidencia" value="Norte"> Norte
                    <input type="radio" name="rdResidencia" value="Centro"> Centro
                </td>
            </tr>
            <tr>
                <td>Foto</td>
                <td><input type="file" id="foto" name="fileFoto" accept=".jpg, .jpeg, .png" /></td>
            </tr>
            <tr>
                <td>Mes y Año de Nacimiento</td>
                <td><input type="month" id="fecha" name="mFecha" required /></td>
            </tr>
            <tr>
                <td>Color Favorito</td>
                <td><input type="color" id="color" name="cColor" /></td>
            </tr>
            <tr>
                <td>Correo Electrónico</td>
                <td><input type="email" id="correo" name="txtCorreo"
                    placeholder="usuario@nombreProveedor.dominio" required /></td>
            </tr>
            <tr>
                <td>Clave</td>
                <td><input type="password" id="clave" name="txtClave" required /></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <input type="submit" value="Enviar">
                    <input type="reset" value="Restablecer">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
