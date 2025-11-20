<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" 
    session="true" 
    import="com.productos.seguridad.Pagina" %><%@ page import="com.productos.seguridad.Bitacora" %>
    
<%
    // Obtenemos AMBOS atributos de la sesión
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");

    // Bandera para saber si el usuario está logueado
    boolean logueado = (usuario != null && perfil != null);

    // Variables de navegación, se calcularán solo si es necesario.
    String paginaActual = request.getRequestURI();
    boolean esProductos = paginaActual.endsWith("productos.jsp");
    boolean esCarrito = paginaActual.endsWith("carrito.jsp");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>MediVital - HOSPITAL PRIVADO</title>

    <link rel="stylesheet" href="estilos3.css" type="text/css">

    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

    <style>
        /* [ ... Tu CSS existente permanece sin cambios ... ] */
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            color: #333;
        }

        header {
            background: linear-gradient(135deg, #007bff, #00c6ff);
            color: white;
            text-align: center;
            padding: 30px 0;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        header .logo {
            width: 120px;
            border-radius: 50%;
            border: 2px solid white;
            margin-bottom: 10px;
        }
        header h1 { font-size: 2.5em; margin: 0; }
        header h2 { font-size: 1.2em; font-weight: 400; }

        nav {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #ffffff;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            min-height: 60px;
            gap: 15px;
        }
        nav a, nav form button {
            text-decoration: none;
            color: #007bff;
            padding: 15px 25px;
            font-weight: 600;
            transition: all 0.3s;
            background: none;
            border: none;
            font-family: inherit;
            cursor: pointer;
        }
        nav a:hover, nav a.active, nav form button:hover {
            background-color: #007bff;
            color: white;
            border-radius: 8px;
        }
        .login-btn {
            background-color: #28a745;
            color: white !important;
            border-radius: 12px;
            margin-left: 15px;
            transition: all 0.3s;
        }
        .logout-btn {
            background-color: #dc3545;
            color: white !important;
            border-radius: 12px;
            margin-left: 15px;
            transition: all 0.3s;
        }
        .logout-btn:hover { background-color: #a71d2a; }

        .welcome-msg {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-size: 1.1em;
            color: #007bff;
            font-weight: bold;
            margin-left: 20px;
        }

        section, article {
            padding: 40px 20px;
            max-width: 1200px;
            margin: auto;
        }
        h3, h4 { color: #007bff; }
        article p { font-size: 1.1em; line-height: 1.6; }
        .mapa {
            width: 100%;
            max-width: 800px;
            height: 450px;
            border-radius: 15px;
            margin-top: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .mascota-section {
            display: flex; flex-wrap: wrap; justify-content: center; align-items: center;
            background: linear-gradient(135deg, #ffffff, #e9f7ff);
            padding: 60px 20px; margin-top: 40px; border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1); gap: 40px;
        }
        .mascota-section img {
            width: 300px; border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .mascota-text { max-width: 500px; }
        .mascota-text h3 { font-size: 2em; margin-bottom: 20px; }
        .mascota-text p { font-size: 1.1em; line-height: 1.6; }
        .social-links {
            display: flex; gap: 20px; margin-top: 20px;
        }
        .social-links a {
            display: inline-block; background-color: #007bff; color: white;
            padding: 12px 25px; border-radius: 12px;
            font-size: 1.1em; font-weight: 600;
            text-decoration: none; transition: all 0.3s;
        }
        .social-links a:hover { background-color: #0056b3; }
        footer {
            text-align: center; padding: 20px;
            background: #007bff; color: white;
        }
        .spider-container {
            position: fixed; bottom: 20px; right: 20px;
            width: 150px; height: 150px; z-index: 1000;
        }
        .dialogo {
            position: absolute; bottom: 160px; right: 0;
            background-color: #444; color: white;
            padding: 10px 15px; border-radius: 12px;
            font-size: 0.9em; box-shadow: 0 0 10px rgba(0,0,0,0.3);
            width: 180px; text-align: center;
        }
    </style>
</head>
<body>
    <main>
        <header>
            <img src="../image/logo.PNG" alt="Logo MediVital" class="logo">
            <h1>MediVital</h1>
            <h2 class="destacado">Cuidamos tu bienestar y recuperación física</h2>
        </header>

        <nav>
            <% if (logueado) { %>
                <div class="welcome-msg">👋 Bienvenido, <%= usuario %>!</div>
                <%
                    Pagina pag = new Pagina();
                    String menu = pag.mostrarMenu(perfil); // Llama a la BD

                    // Marcar como activo el enlace de index si está presente
                    if (menu.contains("index.jsp")) {
                         menu = menu.replace("href=index.jsp", "href=index.jsp class='active'");
                    }
                    out.print(menu);
                %>
                <a href="productos.jsp" class="nav-link <%= esProductos ? "active" : "" %>">Productos</a>
                <a href="carrito.jsp" class="nav-link <%= esCarrito ? "active" : "" %>">🛒 Carrito</a>

                <form action="logout.jsp" method="post" style="margin-left:auto;">
                    <button type="submit" class="logout-btn">Cerrar sesión</button>
                </form>
            <% } else { %>
                <a href="index.jsp" class="nav-link active">Inicio</a>
                <a href="productos.jsp" class="nav-link <%= esProductos ? "active" : "" %>">Productos</a>
                <a href="carrito.jsp" class="nav-link <%= esCarrito ? "active" : "" %>">🛒 Carrito</a>
                
                <a href="login.jsp" class="login-btn" style="margin-left:auto;">Iniciar Sesión</a>
            <% } %>
        </nav>

        <section>
            <article>
                <h3>Nuestra misión</h3>
                <p>
                    En <strong>MediVital</strong> trabajamos para mejorar la salud física de nuestros pacientes mediante tratamientos personalizados, tecnología avanzada y atención profesional.
                </p>
                <iframe src="https://www.google.com/maps/d/embed?mid=1FwoQrdvLqxbV2QAQju9fUbjOLioz6UE&ehbc=2E312F"
                        class="mapa"></iframe>
            </article>
        </section>

        <section class="mascota-section">
            <img src="../image/image.jpg" alt="Mascota MediVital">
            <div class="mascota-text">
                <h3>Conoce a nuestra mascota</h3>
                <p><strong>Misión:</strong> Brindar atención médica integral y personalizada, utilizando tecnología avanzada para la recuperación y bienestar de nuestros pacientes.</p>
                <p><strong>Visión:</strong> Ser líderes en innovación médica y rehabilitación, creando un entorno seguro, humano y de confianza para todos nuestros pacientes.</p>
                
                <div class="social-links">
                    <a href="https://www.instagram.com/davosaurio._/" target="_blank">Instagram</a>
                    <a href="https://www.facebook.com/share/19zk6vH4eE/" target="_blank">Facebook</a>
                </div>
            </div>
        </section>

        <footer>
            <p>© 2025 MediVital - HOSPITAL PRIVADO</p>
        </footer>

        <div class="spider-container">
            <div class="dialogo">¿Te puedo ayudar en algo?</div>
            <model-viewer src="../image/cute_shark_animated_character.glb" alt="Asistente virtual"
                          auto-rotate camera-controls
                          style="width:150px; height:150px;">
            </model-viewer>
        </div>
    </main>
</body>
</html>