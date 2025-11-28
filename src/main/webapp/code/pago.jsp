<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"
    import="java.util.*, com.productos.modelo.ItemCarrito" %>

<%
    // Verificar si hay carrito
    ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");
    if (carrito == null || carrito.size() == 0) {
        response.sendRedirect("productos.jsp");
        return;
    }

    // Calcular total para mostrar
    double total = 0;
    for (ItemCarrito item : carrito) {
        total += item.getSubtotal();
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pasarela de Pago - MediVital</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .payment-card {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .hidden { display: none; }
        .summary { background-color: #e9ecef; padding: 15px; border-radius: 10px; margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="container">
    <div class="payment-card">
        <h2 class="text-center mb-4">Finalizar Compra</h2>
        
        <div class="summary text-center">
            <h4>Total a Pagar: <span class="text-success">$<%= total %></span></h4>
        </div>

        <form id="formPago" action="procesarCompra.jsp" method="post">
            
            <div class="mb-4">
                <label class="form-label fw-bold">Seleccione método de pago:</label>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="metodoPago" id="pagoTarjeta" value="Tarjeta" checked onchange="toggleMetodo()">
                    <label class="form-check-label" for="pagoTarjeta">💳 Tarjeta de Crédito / Débito</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="metodoPago" id="pagoEfectivo" value="Efectivo" onchange="toggleMetodo()">
                    <label class="form-check-label" for="pagoEfectivo">💵 Efectivo (Contra entrega)</label>
                </div>
            </div>

            <div id="seccionTarjeta">
                <hr>
                <h5>Datos de la Tarjeta</h5>
                
                <div class="mb-3">
                    <label class="form-label">Nombre del Titular</label>
                    <input type="text" class="form-control" name="titular" id="titular" placeholder="Como aparece en la tarjeta">
                </div>

                <div class="mb-3">
                    <label class="form-label">Número de Tarjeta</label>
                    <input type="text" class="form-control" name="numeroTarjeta" id="numeroTarjeta" placeholder="0000 0000 0000 0000" maxlength="19">
                    <small class="text-muted">Simulación: Ingrese 16 dígitos.</small>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Vencimiento (MM/YY)</label>
                        <input type="text" class="form-control" id="vencimiento" placeholder="MM/YY" maxlength="5">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">CVV</label>
                        <input type="password" class="form-control" id="cvv" placeholder="123" maxlength="3">
                    </div>
                </div>
            </div>

            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-success btn-lg">Confirmar Pago</button>
                <a href="carrito.jsp" class="btn btn-secondary">Volver al Carrito</a>
            </div>
        </form>
    </div>
</div>

<script>
    // Función para mostrar/ocultar formulario de tarjeta
    function toggleMetodo() {
        const esTarjeta = document.getElementById('pagoTarjeta').checked;
        const seccion = document.getElementById('seccionTarjeta');
        if (esTarjeta) {
            seccion.classList.remove('hidden');
        } else {
            seccion.classList.add('hidden');
        }
    }

    // Formatear número de tarjeta con espacios
    document.getElementById('numeroTarjeta').addEventListener('input', function (e) {
        let value = e.target.value.replace(/\D/g, ''); // Solo números
        value = value.match(/.{1,4}/g)?.join(' ') || value; // Agrupar de a 4
        e.target.value = value;
    });

    // Validar antes de enviar
    document.getElementById('formPago').addEventListener('submit', function(e) {
        const esTarjeta = document.getElementById('pagoTarjeta').checked;

        if (esTarjeta) {
            const titular = document.getElementById('titular').value.trim();
            const numero = document.getElementById('numeroTarjeta').value.replace(/\s/g, ''); // Quitar espacios para validar
            const vencimiento = document.getElementById('vencimiento').value;
            const cvv = document.getElementById('cvv').value;

            // Validaciones
            if (titular === "") {
                alert("Por favor, ingrese el nombre del titular.");
                e.preventDefault(); return;
            }
            if (numero.length !== 16 || isNaN(numero)) {
                alert("El número de tarjeta debe tener 16 dígitos.");
                e.preventDefault(); return;
            }
            if (!/^\d{2}\/\d{2}$/.test(vencimiento)) {
                alert("El vencimiento debe ser en formato MM/YY.");
                e.preventDefault(); return;
            }
            if (cvv.length !== 3 || isNaN(cvv)) {
                alert("El CVV debe tener 3 dígitos.");
                e.preventDefault(); return;
            }
        } else {
            // Si es efectivo, limpiamos los campos de tarjeta para que no se envíen datos basura
            document.getElementById('titular').value = "Pago en Efectivo";
            document.getElementById('numeroTarjeta').value = "0000"; 
        }
        
        if(confirm("¿Confirmar la compra?")) {
            return true;
        } else {
            e.preventDefault();
        }
    });
</script>

</body>
</html>