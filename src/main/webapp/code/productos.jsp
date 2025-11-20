<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true" 
    import="com.productos.seguridad.Pagina" 
    import="com.productos.negocio.Producto"
    import="java.util.*"
%><%@ page import="com.productos.seguridad.Bitacora" %>

<%
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos - MediVital</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        header { background-color: #343a40; color: white; }
        header img { width: 100px; }
        nav.navbar { background: linear-gradient(135deg, #404040, #6e6e6e); }

        nav .nav-link, nav a {
            color: white !important;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background 0.3s, color 0.3s;
            margin: 0 5px;
            text-decoration: none;
        }
        nav .nav-link:hover, nav a:hover {
            background-color: #8a8a8a;
            color: #fff !important;
        }
        nav .nav-link.active, nav a.active {
            background-color: #00bfa6;
            color: #fff !important;
            font-weight: bold;
        }

        model-viewer {
            width: 100%;
            height: 400px;
            background-color: #f0f0f0;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
        }

        footer { background-color: #404040; color: white; padding: 15px 0; }

        .welcome-msg {
            color: #f8f9fa !important;
            font-weight: 500;
            padding: 10px 20px;
            margin: 0 5px;
        }
    </style>
</head>

<body>

<header class="text-center py-4 bg-dark text-white">
    <img src="../image/logo.PNG" alt="Logo MediVital" class="rounded-circle mb-2">
    <h1>MediVital</h1>
    <h2 class="fw-light">Productos profesionales para Doctores</h2>
</header>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container justify-content-center">
        <% if (usuario != null && perfil != null) { %>
            <span class="welcome-msg">👋 Bienvenido, <%= usuario %>!</span>

            <%
                Pagina pag = new Pagina();
                String menu = pag.mostrarMenu(perfil);

                if (menu.contains("productos.jsp")) {
                    menu = menu.replace("href=productos.jsp", "href=productos.jsp class='active'");
                }

                out.print(menu);
            %>

            <a class="nav-link" href="carrito.jsp">🛒 Carrito</a>

        <% } else { %>
            <a class="nav-link" href="index.jsp">Inicio</a>
            <a class="nav-link" href="servicios.jsp">Servicios</a>
            <a class="nav-link active" href="productos.jsp">Productos</a>
            <a class="nav-link" href="carrito.jsp">🛒 Carrito</a>
            <a class="nav-link" href="index.jsp" style="background-color: #28a745; border-radius: 8px;">Iniciar Sesión</a>
        <% } %>
    </div>
</nav>


<section class="container my-5">
    <%
        if (perfil != null && (perfil == 3 || perfil == 1)) {

            Producto prod = new Producto();
    %>

    <div class="row">
        <div class="col-md-4">
            <h3>Registro de Nuevos Productos</h3>

            <form action="nuevoProducto.jsp" method="post" enctype="multipart/form-data">

                <div class="mb-3">
                    <label class="form-label">Nombre</label>
                    <input type="text" class="form-control" name="txt_nombre" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Categoría</label>
                    <select class="form-select" name="cmb_categoria" required>
                        <option disabled selected>Seleccione la categoría</option>
                        <option value="1">Dama</option>
                        <option value="2">Caballero</option>
                        <option value="3">Niño</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Precio</label>
                    <input type="number" step="0.01" class="form-control" name="txt_precio" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Cantidad</label>
                    <input type="number" class="form-control" name="txt_cantidad" required>
                </div>

                <div class="input-group mb-3">
                    <input type="file" class="form-control" name="file_foto">
                    <label class="input-group-text">Subir foto</label>
                </div>

                <button type="submit" class="btn btn-primary">Enviar</button>
                <button type="reset" class="btn btn-secondary">Borrar</button>

            </form>
        </div>

        <div class="col-md-8">
            <h3>Reporte de Productos</h3>
            <%= prod.reporteProducto() %>
        </div>

    </div>

    <% } else { %>

    <!-- =================== CATÁLOGO 3D CON BOTONES DE CARRITO =================== -->

    <h2 class="text-center mb-4">Catálogo de Productos 3D</h2>

    <div id="productosCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            
            <!-- 1. Camilla -->
            <div class="carousel-item active text-center">
                <model-viewer src="../image/hospital_bed_low_poly.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Camilla de Hospital</h5>
                    <p>Camilla ergonómica y resistente para centros médicos.</p>
                    <a href="agregarCarrito.jsp?id=101&nombre=Camilla Hospitalaria&precio=250"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

            <!-- 2. Bisturí -->
            <div class="carousel-item text-center">
                <model-viewer src="../image/scaple.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Bisturí Quirúrgico</h5>
                    <p>Instrumento de precisión para cirugías.</p>
                    <a href="agregarCarrito.jsp?id=102&nombre=Bisturi Quirurgico&precio=15"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

            <!-- 3. Monitor cardíaco -->
            <div class="carousel-item text-center">
                <model-viewer src="../image/monitor_with_heart_rate.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Monitor Cardíaco</h5>
                    <p>Equipo de monitoreo avanzado.</p>
                    <a href="agregarCarrito.jsp?id=103&nombre=Monitor Cardiaco&precio=350"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

            <!-- 4. Termómetro -->
            <div class="carousel-item text-center">
                <model-viewer src="../image/digital-thermometer-2086.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Termómetro Digital</h5>
                    <p>Medición rápida y precisa.</p>
                    <a href="agregarCarrito.jsp?id=104&nombre=Termometro Digital&precio=8"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

            <!-- 5. Esqueleto humano -->
            <div class="carousel-item text-center">
                <model-viewer src="../image/human_skeleton_download_free.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Esqueleto Humano</h5>
                    <p>Modelo anatómico educativo.</p>
                    <a href="agregarCarrito.jsp?id=105&nombre=Esqueleto Humano&precio=120"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

            <!-- 6. Tomógrafo -->
            <div class="carousel-item text-center">
                <model-viewer src="../image/sci_fi_lab_machine.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Tomógrafo Computarizado</h5>
                    <p>Equipo avanzado para diagnóstico.</p>
                    <a href="agregarCarrito.jsp?id=106&nombre=Tomografo&precio=800"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

            <!-- 7. Bandeja -->
            <div class="carousel-item text-center">
                <model-viewer src="../image/drip_stand.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Bandeja de Hospital</h5>
                    <p>Soporte práctico para sueros.</p>
                    <a href="agregarCarrito.jsp?id=107&nombre=Bandeja Hospital&precio=40"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

            <!-- 8. Botiquín -->
            <div class="carousel-item text-center">
                <model-viewer src="../image/medicine_wall_cupboard_hospital.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Botiquín Médico</h5>
                    <p>Armario para primeros auxilios.</p>
                    <a href="agregarCarrito.jsp?id=108&nombre=Botiquin Medico&precio=55"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

            <!-- 9. Uniforme -->
            <div class="carousel-item text-center">
                <model-viewer src="../image/doctor.glb" camera-controls auto-rotate></model-viewer>
                <div class="carousel-caption bg-dark bg-opacity-50 p-2 rounded">
                    <h5>Uniforme de Doctor</h5>
                    <p>Modelo representativo profesional.</p>
                    <a href="agregarCarrito.jsp?id=109&nombre=Uniforme Doctor&precio=28"
                       class="btn btn-success mt-3">🛒 Agregar al carrito</a>
                </div>
            </div>

        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#productosCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>

        <button class="carousel-control-next" type="button" data-bs-target="#productosCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>

    </div>

    <% } %>
</section>

<footer class="text-center">
    <p>&copy; 2025 MediVital - Todos los derechos reservados.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
