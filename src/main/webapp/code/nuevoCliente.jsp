<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.productos.seguridad.Bitacora" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nuevo Cliente</title>
    <style>
        /* [ ... TU CSS ORIGINAL SE MANTIENE IGUAL ... ] */
        body { font-family: Arial, sans-serif; background-color: #eef2f3; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .formulario { background-color: #fff; padding: 30px 40px; border-radius: 12px; box-shadow: 0px 4px 10px rgba(0,0,0,0.2); width: 450px; }
        h2 { text-align: center; color: #2c3e50; margin-bottom: 20px; }
        label { display: block; margin-top: 10px; font-weight: bold; color: #34495e; }
        input, select { width: 100%; padding: 8px; margin-top: 5px; border-radius: 6px; border: 1px solid #ccc; }
        .radio-group { margin-top: 5px; }
        .radio-group input { margin-right: 5px; }
        .boton { margin-top: 20px; width: 100%; background-color: #3498db; color: white; border: none; padding: 10px; font-size: 16px; border-radius: 8px; cursor: pointer; transition: 0.3s; }
        .boton:hover { background-color: #2980b9; }
        .error-msg { color: red; font-size: 12px; margin-top: 2px; display: none; }
    </style>

    <script>
        function validarCedulaEcuatoriana(cedula) {
            if (cedula.length !== 10) return false;

            // Digitos iniciales (Provincia 01-24 y 30)
            const digitoRegion = parseInt(cedula.substring(0, 2));
            if ((digitoRegion < 1 || digitoRegion > 24) && digitoRegion !== 30) return false;

            // Tercer dígito debe ser menor a 6 (personas naturales)
            const tercerDigito = parseInt(cedula.substring(2, 3));
            if (tercerDigito >= 6) return false; // Nota: RUCs usan 6 o 9, pero cédula personal es < 6

            // Algoritmo Módulo 10
            const coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
            const ultimoDigito = parseInt(cedula.substring(9, 10));
            let suma = 0;

            for (let i = 0; i < 9; i++) {
                let valor = parseInt(cedula.substring(i, i + 1)) * coeficientes[i];
                if (valor >= 10) valor -= 9;
                suma += valor;
            }

            const digitoVerificador = (Math.ceil(suma / 10) * 10) - suma;
            const validador = (digitoVerificador === 10) ? 0 : digitoVerificador;

            return validador === ultimoDigito;
        }

        function validarFormulario(event) {
            let esValido = true;

            // 1. Validar Cédula
            const cedula = document.getElementById("txtCedula").value;
            const errorCedula = document.getElementById("errorCedula");
            
            if (!/^\d+$/.test(cedula)) { // Solo números
                 errorCedula.innerText = "La cédula debe contener solo números.";
                 errorCedula.style.display = "block";
                 esValido = false;
            } else if (!validarCedulaEcuatoriana(cedula)) {
                 errorCedula.innerText = "La cédula ingresada NO es válida en Ecuador.";
                 errorCedula.style.display = "block";
                 esValido = false;
            } else {
                errorCedula.style.display = "none";
            }

            // 2. Validar Nombre (Solo letras)
            const nombre = document.getElementById("txtNombre").value;
            const errorNombre = document.getElementById("errorNombre");
            if (!/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/.test(nombre)) {
                errorNombre.innerText = "El nombre solo debe contener letras.";
                errorNombre.style.display = "block";
                esValido = false;
            } else {
                errorNombre.style.display = "none";
            }

            // 3. Validar Fecha (No futuro, no muy antigua)
            const fechaInput = document.getElementById("mFecha").value; // Formato YYYY-MM
            const errorFecha = document.getElementById("errorFecha");
            if(fechaInput) {
                const fechaNac = new Date(fechaInput + "-01");
                const hoy = new Date();
                const fechaMinima = new Date("1900-01-01");

                if (fechaNac > hoy) {
                    errorFecha.innerText = "No puedes nacer en el futuro.";
                    errorFecha.style.display = "block";
                    esValido = false;
                } else if (fechaNac < fechaMinima) {
                    errorFecha.innerText = "Fecha inválida (demasiado antigua).";
                    errorFecha.style.display = "block";
                    esValido = false;
                } else {
                    errorFecha.style.display = "none";
                }
            }

            if (!esValido) {
                event.preventDefault(); // Detiene el envío si hay errores
            }
        }
    </script>
</head>
<body>
    <form class="formulario" action="registrarCliente.jsp" method="post" onsubmit="validarFormulario(event)">
        <h2>Registro de Cliente</h2>

        <label for="txtNombre">Nombre completo:</label>
        <input type="text" id="txtNombre" name="txtNombre" required>
        <div id="errorNombre" class="error-msg"></div>

        <label for="txtCedula">Cédula:</label>
        <input type="text" id="txtCedula" name="txtCedula" maxlength="10" required>
        <div id="errorCedula" class="error-msg"></div>

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

        <label for="mFecha">Mes y Año de Nacimiento:</label>
        <input type="month" id="mFecha" name="mFecha" required>
        <div id="errorFecha" class="error-msg"></div>

        <label for="cColor">Color favorito:</label>
        <input type="color" id="cColor" name="cColor" value="#2ecc71">

        <label for="txtCorreo">Correo electrónico:</label>
        <input type="email" id="txtCorreo" name="txtCorreo" required>

        <label for="txtClave">Contraseña:</label>
        <input type="password" id="txtClave" name="txtClave" minlength="4" required>

        <button type="submit" class="boton">Registrar</button>
    </form>
</body>
</html>