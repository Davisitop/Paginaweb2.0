<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" 
    session="true" 
    import="com.productos.seguridad.Pagina" %>
<%@ page import="com.productos.seguridad.Bitacora" %>
    
<%
    // --- LÓGICA DE SESIÓN ---
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");

    boolean logueado = (usuario != null && perfil != null);

    // Variables de navegación para marcar activo
    String paginaActual = request.getRequestURI();
    boolean esProductos = paginaActual.endsWith("productos.jsp");
    boolean esCarrito = paginaActual.endsWith("carrito.jsp");
    boolean esServicios = paginaActual.endsWith("servicios.jsp");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediVital - Tu Hospital de Confianza</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

    <style>
        /* --- ESTILOS PERSONALIZADOS --- */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            overflow-x: hidden;
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
        .btn-login {
            background-color: #28a745;
            color: white !important;
            border-radius: 50px;
            padding: 8px 25px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-login:hover {
            background-color: #218838;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }
        .btn-logout {
            background-color: #dc3545;
            color: white !important;
            border-radius: 50px;
            padding: 6px 20px;
            border: none;
        }

        /* Hero Section */
        .hero-header {
            background: linear-gradient(135deg, #0062cc, #00c6ff);
            color: white;
            padding: 80px 0 60px;
            border-bottom-left-radius: 50% 30px;
            border-bottom-right-radius: 50% 30px;
            margin-bottom: 50px;
            position: relative;
        }
        .logo-main {
            width: 140px;
            border: 4px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            background: white;
            padding: 5px;
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        /* Cards */
        .custom-card {
            border: none;
            border-radius: 20px;
            background: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
            overflow: hidden;
            height: 100%;
        }
        .custom-card:hover {
            transform: translateY(-5px);
        }
        .map-container iframe {
            border-radius: 15px;
            width: 100%;
            height: 350px;
            border: none;
        }

        /* Mascota Section */
        .mascota-img {
            width: 100%;
            max-width: 350px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            transform: rotate(-2deg);
            transition: transform 0.3s;
        }
        .mascota-img:hover {
            transform: rotate(0deg) scale(1.02);
        }

        /* Footer */
        footer {
            background-color: #343a40;
            color: rgba(255,255,255,0.7);
            padding: 40px 0 20px;
            margin-top: 80px;
        }

        /* Asistente Flotante */
        .spider-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1050;
            filter: drop-shadow(0 5px 15px rgba(0,0,0,0.2));
        }
        .dialogo-box {
            background: white;
            padding: 10px 15px;
            border-radius: 15px 15px 0 15px;
            position: absolute;
            bottom: 140px;
            right: 20px;
            width: 200px;
            font-size: 0.9rem;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            animation: fadeIn 0.5s ease-in-out;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="../image/logo.PNG" alt="Logo" width="40" height="40" class="rounded-circle me-2">
                MediVital
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <% if (logueado) { %>
                        <li class="nav-item me-3 text-primary fw-bold">
                            👋 ¡Hola, <%= usuario %>!
                        </li>
                        
                        <%
                            Pagina pag = new Pagina();
                            String menu = pag.mostrarMenu(perfil);
                            // Pequeña limpieza por si la BD trae hrefs con espacios
                            out.print(menu); 
                        %>

                        <li class="nav-item"><a class="nav-link <%= esServicios ? "active" : "" %>" href="servicios.jsp">Servicios</a></li>
                        <li class="nav-item"><a class="nav-link <%= esProductos ? "active" : "" %>" href="productos.jsp">Productos</a></li>
                        <li class="nav-item"><a class="nav-link <%= esCarrito ? "active" : "" %>" href="carrito.jsp">🛒 Carrito</a></li>
                        
                        <li class="nav-item ms-2">
                            <form action="logout.jsp" method="post" class="d-inline">
                                <button type="submit" class="btn-logout">Salir</button>
                            </form>
                        </li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link active" href="index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link <%= esServicios ? "active" : "" %>" href="servicios.jsp">Servicios</a></li>
                        <li class="nav-item"><a class="nav-link <%= esProductos ? "active" : "" %>" href="productos.jsp">Productos</a></li>
                        <li class="nav-item"><a class="nav-link <%= esCarrito ? "active" : "" %>" href="carrito.jsp">🛒 Carrito</a></li>
                        <li class="nav-item ms-3">
                            <a href="login.jsp" class="btn btn-login">Iniciar Sesión</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-header text-center">
        <div class="container mt-5">
            <img src="../image/logo.PNG" alt="Logo MediVital" class="logo-main">
            <h1 class="display-4 fw-bold">Bienvenido a MediVital</h1>
            <p class="lead fs-4 opacity-75">Innovación médica y calidez humana para tu recuperación.</p>
        </div>
    </header>

    <div class="container">
        
        <div class="row align-items-center mb-5 g-4">
            <div class="col-lg-5">
                <div class="custom-card p-4 h-100 d-flex flex-column justify-content-center">
                    <h3 class="text-primary fw-bold mb-3">Nuestra Misión</h3>
                    <p class="text-muted fs-5">
                        En <strong>MediVital</strong> trabajamos incansablemente para mejorar la calidad de vida de nuestros pacientes. 
                        Combinamos tratamientos personalizados con tecnología de vanguardia y un equipo humano altamente capacitado.
                    </p>
                    <div class="mt-3">
                        <a href="servicios.jsp" class="btn btn-outline-primary rounded-pill">Conoce nuestros servicios</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-7">
                <div class="custom-card p-2 map-container">
                    <iframe src="https://www.google.com/maps/d/embed?mid=1FwoQrdvLqxbV2QAQju9fUbjOLioz6UE&ehbc=2E312F" allowfullscreen="" loading="lazy"></iframe>
                </div>
            </div>
        </div>

        <div class="custom-card p-5 mb-5 bg-white position-relative overflow-hidden">
            <div style="position:absolute; top:-50px; right:-50px; width:200px; height:200px; background:#e9f7ff; border-radius:50%; z-index:0;"></div>
            
            <div class="row align-items-center position-relative" style="z-index:1;">
                <div class="col-md-5 text-center mb-4 mb-md-0">
                    <img src="../image/image.jpg" alt="Mascota MediVital" class="mascota-img">
                </div>
                <div class="col-md-7">
                    <span class="badge bg-info text-dark mb-2">Nuestro Espíritu</span>
                    <h2 class="fw-bold mb-3">Conoce a nuestra mascota</h2>
                    
                    <div class="mb-4">
                        <h5 class="text-primary">Misión</h5>
                        <p class="text-muted small">Brindar atención médica integral y personalizada, utilizando tecnología avanzada para la recuperación y bienestar de nuestros pacientes.</p>
                    </div>
                    
                    <div class="mb-4">
                        <h5 class="text-primary">Visión</h5>
                        <p class="text-muted small">Ser líderes en innovación médica y rehabilitación, creando un entorno seguro, humano y de confianza.</p>
                    </div>

                    <div class="d-flex gap-3">
                        <a href="https://www.instagram.com/davosaurio._/" target="_blank" class="btn btn-primary rounded-pill px-4">
                             Instagram
                        </a>
                        <a href="https://www.facebook.com/share/19zk6vH4eE/" target="_blank" class="btn btn-outline-primary rounded-pill px-4">
                             Facebook
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="spider-container">
        <div class="dialogo-box text-center">
            <strong>Asistente Virtual</strong><br>
            ¿Te puedo ayudar en algo hoy? 😊
        </div>
        <model-viewer 
            src="../image/cute_shark_animated_character.glb" 
            alt="Asistente virtual"
            auto-rotate 
            camera-controls 
            disable-zoom
            style="width: 140px; height: 140px;">
        </model-viewer>
    </div>

    <footer class="text-center">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h5>MediVital - Hospital Privado</h5>
                    <p class="small text-white-50">Comprometidos con tu salud y la de tu familia.</p>
                    <p class="mt-4 mb-0">© 2025 Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>