<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"
    import="java.util.*, com.productos.modelo.ItemCarrito, com.productos.seguridad.Pagina" %>

<%
    // --- LÓGICA DE SESIÓN Y NAVBAR ---
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");
    boolean logueado = (usuario != null && perfil != null);

    // --- LÓGICA DEL CARRITO ---
    ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");
    boolean carritoVacio = (carrito == null || carrito.size() == 0);
    double total = 0;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tu Carrito - MediVital</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        /* --- ESTILOS GENERALES --- */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navbar */
        .navbar {
            background-color: rgba(255, 255, 255, 0.95);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            backdrop-filter: blur(10px);
        }
        .navbar-brand {
            font-weight: 700;
            color: #007bff !important;
            font-size: 1.5rem;
        }
        .nav-link {
            font-weight: 500;
            color: #555 !important;
            margin: 0 5px;
            transition: color 0.3s;
        }
        .nav-link:hover, .nav-link.active {
            color: #007bff !important;
        }

        /* Hero Header Compacto */
        .page-header {
            background: linear-gradient(135deg, #007bff, #00c6ff);
            color: white;
            padding: 60px 0 40px;
            text-align: center;
            border-bottom-left-radius: 25px;
            border-bottom-right-radius: 25px;
            margin-bottom: 40px;
            box-shadow: 0 10px 20px rgba(0,123,255,0.15);
        }

        /* Tarjeta del Carrito */
        .cart-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            background: white;
            overflow: hidden;
        }
        .cart-header {
            background-color: #f8f9fa;
            padding: 15px 25px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
        }
        
        /* Tabla */
        .table-cart th {
            font-size: 0.85rem;
            text-transform: uppercase;
            color: #888;
            letter-spacing: 1px;
            border-bottom: 2px solid #eee;
        }
        .table-cart td {
            vertical-align: middle;
            padding: 15px 10px;
        }

        /* Resumen de Compra */
        .summary-card {
            background-color: #fff;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            position: sticky;
            top: 100px; /* Se queda fijo al hacer scroll */
        }

        /* Botones */
        .btn-rounded { border-radius: 50px; }
        .btn-checkout {
            background-color: #28a745;
            color: white;
            font-weight: 600;
            padding: 12px;
            transition: transform 0.2s;
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }
        .btn-checkout:hover {
            background-color: #218838;
            color: white;
            transform: translateY(-2px);
        }

        /* Footer */
        footer {
            background-color: #343a40;
            color: rgba(255,255,255,0.6);
            text-align: center;
            padding: 30px 0;
            margin-top: auto; /* Empuja el footer al fondo */
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <img src="../image/logo.PNG" alt="Logo" width="40" height="40" class="rounded-circle me-2">
                MediVital
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <% if (logueado) { %>
                        <li class="nav-item me-3 text-primary fw-bold">👋 ¡Hola, <%= usuario %>!</li>
                        <%
                            Pagina pag = new Pagina();
                            String menu = pag.mostrarMenu(perfil);
                            out.print(menu);
                        %>
                        <li class="nav-item"><a class="nav-link" href="servicios.jsp">Servicios</a></li>
                        <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                        <li class="nav-item"><a class="nav-link active" href="carrito.jsp">🛒 Carrito</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="servicios.jsp">Servicios</a></li>
                        <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                        <li class="nav-item"><a class="nav-link active" href="carrito.jsp">🛒 Carrito</a></li>
                        <li class="nav-item ms-2"><a href="index.jsp" class="btn btn-success btn-rounded px-4 btn-sm">Login</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="page-header pt-5 mt-5">
        <div class="container">
            <h1 class="fw-bold">Tu Carrito de Compras</h1>
            <p class="opacity-75">Revisa tus productos antes de finalizar</p>
        </div>
    </header>

    <div class="container mb-5">
        
        <% if (carritoVacio) { %>
            
            <div class="text-center py-5">
                <div class="mb-4 text-muted" style="font-size: 5rem;">
                    <i class="bi bi-cart-x"></i>
                </div>
                <h3 class="fw-bold text-secondary">Tu carrito está vacío</h3>
                <p class="text-muted mb-4">Parece que aún no has agregado productos médicos a tu lista.</p>
                <a href="productos.jsp" class="btn btn-primary btn-rounded px-4 py-2 shadow">
                    <i class="bi bi-arrow-left"></i> Volver al Catálogo
                </a>
            </div>

        <% } else { %>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="cart-card">
                        <div class="cart-header d-flex justify-content-between align-items-center">
                            <span>Artículos Seleccionados</span>
                            <span class="badge bg-primary rounded-pill"><%= carrito.size() %> Items</span>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-cart table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th class="ps-4">Producto</th>
                                        <th class="text-center">Precio</th>
                                        <th class="text-center">Cantidad</th>
                                        <th class="text-end pe-4">Subtotal</th>
                                        <th class="text-center">Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        for (ItemCarrito item : carrito) { 
                                            total += item.getSubtotal();
                                    %>
                                    <tr>
                                        <td class="ps-4 fw-bold text-dark"><%= item.getNombre() %></td>
                                        <td class="text-center text-muted">$ <%= String.format("%.2f", item.getPrecio()) %></td>
                                        <td class="text-center">
                                            <span class="badge bg-light text-dark border px-3 py-2"><%= item.getCantidad() %></span>
                                        </td>
                                        <td class="text-end pe-4 fw-bold text-primary">$ <%= String.format("%.2f", item.getSubtotal()) %></td>
                                        <td class="text-center">
                                            <a href="quitarItem.jsp?id=<%= item.getId() %>" class="btn btn-outline-danger btn-sm rounded-circle" title="Eliminar">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="p-3 bg-light d-flex justify-content-between align-items-center">
                            <a href="vaciarCarrito.jsp" class="text-danger text-decoration-none small fw-bold">
                                <i class="bi bi-x-circle"></i> Vaciar Carrito
                            </a>
                            <a href="productos.jsp" class="text-secondary text-decoration-none small fw-bold">
                                <i class="bi bi-plus-circle"></i> Seguir Comprando
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="summary-card">
                        <h4 class="fw-bold mb-4">Resumen</h4>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Subtotal</span>
                            <span class="fw-bold">$ <%= String.format("%.2f", total) %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Impuestos (Est.)</span>
                            <span class="text-success">Gratis</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-4 align-items-center">
                            <span class="fs-5 fw-bold">Total</span>
                            <span class="fs-3 fw-bold text-primary">$ <%= String.format("%.2f", total) %></span>
                        </div>

                        <div class="d-grid gap-2">
                            <a href="pago.jsp" class="btn btn-checkout btn-rounded shadow">
                                Proceder al Pago <i class="bi bi-credit-card ms-2"></i>
                            </a>
                        </div>

                        <div class="mt-4 text-center">
                            <small class="text-muted d-block mb-2">Aceptamos</small>
                            <div class="d-flex justify-content-center gap-2 fs-4 text-secondary">
                                <i class="bi bi-credit-card-2-front"></i>
                                <i class="bi bi-cash-coin"></i>
                                <i class="bi bi-paypal"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        <% } %>
    </div>

    <footer>
        <div class="container">
            <p class="mb-0">© 2025 MediVital - Seguridad en tus compras.</p>
            <small>Todos los derechos reservados.</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>