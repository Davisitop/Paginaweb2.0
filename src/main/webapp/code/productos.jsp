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
    
    // Validación simple para evitar null pointers en la lógica de vista
    boolean esAdmin = (perfil != null && perfil == 1);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos - MediVital</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

    <style>
        /* --- ESTILOS GENERALES --- */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
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

        /* Hero Header */
        .page-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 80px 0 50px;
            text-align: center;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0,123,255,0.2);
            position: relative;
            overflow: hidden;
        }
        /* Círculos decorativos en el header */
        .page-header::before {
            content: '';
            position: absolute;
            top: -50%; left: -10%;
            width: 300px; height: 300px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
        }

        /* Tarjetas (Cards) */
        .custom-card {
            border: none;
            border-radius: 15px;
            background: white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            transition: transform 0.3s;
            overflow: hidden;
        }
        .card-header-custom {
            background: #007bff;
            color: white;
            font-weight: 600;
            padding: 15px;
            border-bottom: none;
        }

        /* Carrusel 3D */
        .carousel-3d-container {
            max-width: 900px;
            margin: 0 auto;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            background: white;
        }
        model-viewer {
            width: 100%;
            height: 500px;
            background: linear-gradient(180deg, #f8f9fa 0%, #e9ecef 100%);
        }
        .carousel-caption {
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(5px);
            border-radius: 15px;
            bottom: 30px;
            padding: 20px;
            max-width: 80%;
            left: 10%;
            right: 10%;
        }

        /* Botones */
        .btn-custom-primary {
            background-color: #007bff;
            color: white;
            border-radius: 50px;
            padding: 10px 25px;
            font-weight: 600;
            border: none;
            transition: all 0.3s;
        }
        .btn-custom-primary:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,123,255,0.3);
        }

        /* Tabla Admin */
        .table-custom thead {
            background-color: #343a40;
            color: white;
        }
        .table-custom th, .table-custom td {
            vertical-align: middle;
        }

        /* Footer */
        footer {
            background-color: #343a40;
            color: rgba(255,255,255,0.6);
            text-align: center;
            padding: 30px 0;
            margin-top: 60px;
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
                    <% if (usuario != null && perfil != null) { %>
                        <li class="nav-item me-3 text-primary fw-bold">
                            👋 ¡Hola, <%= usuario %>!
                        </li>
                        
                        <%
                            Pagina pag = new Pagina();
                            String menu = pag.mostrarMenu(perfil);
                            if (menu.contains("productos.jsp")) {
                                // Adaptación visual simple para marcar activo
                                menu = menu.replace("href=productos.jsp", "href=productos.jsp class='active'");
                            }
                            out.print(menu);
                        %>
                        
                        <li class="nav-item"><a class="nav-link active" href="productos.jsp">Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="carrito.jsp">🛒 Carrito</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="servicios.jsp">Servicios</a></li>
                        <li class="nav-item"><a class="nav-link active" href="productos.jsp">Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="carrito.jsp">🛒 Carrito</a></li>
                        <li class="nav-item ms-2">
                            <a href="index.jsp" class="btn btn-success rounded-pill px-4">Iniciar Sesión</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="page-header">
        <div class="container mt-5">
            <h1 class="display-4 fw-bold">Catálogo Profesional</h1>
            <p class="lead fs-5 opacity-90">Equipamiento médico de alta calidad y tecnología 3D.</p>
        </div>
    </header>

    <section class="container">
        <%
            // LÓGICA DE VISTAS
            if (esAdmin) {
                Producto prod = new Producto();
        %>

        <div class="row g-5">
            
            <div class="col-lg-4">
                <div class="custom-card h-100">
                    <div class="card-header-custom text-center">
                        <i class="bi bi-plus-circle"></i> Nuevo Producto
                    </div>
                    <div class="card-body p-4">
                        <form action="nuevoProducto.jsp" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">NOMBRE DEL PRODUCTO</label>
                                <input type="text" class="form-control bg-light" name="txt_nombre" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">CATEGORÍA</label>
                                <select class="form-select bg-light" name="cmb_categoria" required>
                                    <option disabled selected>Seleccionar...</option>
                                    <option value="1">Equipamiento</option>
                                    <option value="2">Instrumental</option>
                                    <option value="3">Indumentaria</option>
                                </select>
                            </div>
                            <div class="row">
                                <div class="col-6 mb-3">
                                    <label class="form-label text-muted small fw-bold">PRECIO</label>
                                    <input type="number" step="0.01" class="form-control bg-light" name="txt_precio" required>
                                </div>
                                <div class="col-6 mb-3">
                                    <label class="form-label text-muted small fw-bold">STOCK</label>
                                    <input type="number" class="form-control bg-light" name="txt_cantidad" required>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-muted small fw-bold">IMAGEN</label>
                                <input type="file" class="form-control" name="file_foto">
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary rounded-pill">Guardar Producto</button>
                                <button type="reset" class="btn btn-outline-secondary rounded-pill">Limpiar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="custom-card">
                    <div class="card-header-custom bg-dark d-flex justify-content-between align-items-center">
                        <span>Inventario Actual</span>
                        <span class="badge bg-primary rounded-pill">Admin Mode</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <div class="p-3">
                                <%= prod.reporteProducto().replace("table ", "table table-hover table-custom align-middle ") %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <% } else { %>

        <div class="carousel-3d-container">
            <div id="productosCarousel" class="carousel slide" data-bs-ride="carousel">
                
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="0" class="active"></button>
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="1"></button>
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="2"></button>
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="3"></button>
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="4"></button>
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="5"></button>
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="6"></button>
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="7"></button>
                    <button type="button" data-bs-target="#productosCarousel" data-bs-slide-to="8"></button>
                </div>

                <div class="carousel-inner">
                    
                    <div class="carousel-item active">
                        <model-viewer src="../image/hospital_bed_low_poly.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-warning">Camilla de Hospital</h3>
                            <p class="fs-5">Ergonomía y resistencia para el cuidado crítico.</p>
                            <p class="fw-bold fs-4">$250.00</p>
                            <a href="agregarCarrito.jsp?id=101&nombre=Camilla Hospitalaria&precio=250" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <model-viewer src="../image/scaple.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-info">Bisturí Quirúrgico</h3>
                            <p>Precisión milimétrica para procedimientos delicados.</p>
                            <p class="fw-bold fs-4">$15.00</p>
                            <a href="agregarCarrito.jsp?id=102&nombre=Bisturi Quirurgico&precio=15" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <model-viewer src="../image/monitor_with_heart_rate.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-danger">Monitor Cardíaco</h3>
                            <p>Tecnología avanzada de monitoreo vital.</p>
                            <p class="fw-bold fs-4">$350.00</p>
                            <a href="agregarCarrito.jsp?id=103&nombre=Monitor Cardiaco&precio=350" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <model-viewer src="../image/digital-thermometer-2086.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-primary">Termómetro Digital</h3>
                            <p>Lectura instantánea y precisa sin contacto.</p>
                            <p class="fw-bold fs-4">$8.00</p>
                            <a href="agregarCarrito.jsp?id=104&nombre=Termometro Digital&precio=8" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <model-viewer src="../image/human_skeleton_download_free.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-white">Modelo Anatómico</h3>
                            <p>Esqueleto humano a escala real para educación.</p>
                            <p class="fw-bold fs-4">$120.00</p>
                            <a href="agregarCarrito.jsp?id=105&nombre=Esqueleto Humano&precio=120" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <model-viewer src="../image/sci_fi_lab_machine.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-info">Tomógrafo Avanzado</h3>
                            <p>Diagnóstico por imagen de última generación.</p>
                            <p class="fw-bold fs-4">$800.00</p>
                            <a href="agregarCarrito.jsp?id=106&nombre=Tomografo&precio=800" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <model-viewer src="../image/drip_stand.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-white">Soporte de Suero</h3>
                            <p>Acero inoxidable, altura ajustable y ruedas.</p>
                            <p class="fw-bold fs-4">$40.00</p>
                            <a href="agregarCarrito.jsp?id=107&nombre=Bandeja Hospital&precio=40" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <model-viewer src="../image/medicine_wall_cupboard_hospital.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-danger">Botiquín Médico</h3>
                            <p>Gabinete de pared seguro y organizado.</p>
                            <p class="fw-bold fs-4">$55.00</p>
                            <a href="agregarCarrito.jsp?id=108&nombre=Botiquin Medico&precio=55" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <model-viewer src="../image/doctor.glb" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="carousel-caption d-none d-md-block">
                            <h3 class="fw-bold text-primary">Uniforme Médico</h3>
                            <p>Tela antifluido, comodidad y diseño profesional.</p>
                            <p class="fw-bold fs-4">$28.00</p>
                            <a href="agregarCarrito.jsp?id=109&nombre=Uniforme Doctor&precio=28" class="btn btn-custom-primary shadow-lg">
                                Agregar al Carrito 🛒
                            </a>
                        </div>
                    </div>

                </div>

                <button class="carousel-control-prev" type="button" data-bs-target="#productosCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
                    <span class="visually-hidden">Anterior</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#productosCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
                    <span class="visually-hidden">Siguiente</span>
                </button>

            </div>
        </div>
        
        <div class="text-center mt-5">
            <a href="index.jsp" class="btn btn-outline-secondary rounded-pill px-4">
                <i class="bi bi-house-door-fill"></i> 🏠 Regresar al Inicio
            </a>
        </div>

        <% } %>
    </section>

    <footer>
        <div class="container">
            <p class="mb-0">© 2025 MediVital - Tecnología al servicio de la salud.</p>
            <small>Todos los derechos reservados.</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>