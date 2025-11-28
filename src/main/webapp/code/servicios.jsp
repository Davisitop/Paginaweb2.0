<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.productos.seguridad.Bitacora" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios - MediVital (VR + Interactivos)</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <script src="https://aframe.io/releases/1.4.2/aframe.min.js"></script>
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

    <style>
        /* --- ESTILOS GENERALES --- */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
            color: #333;
            overflow-x: hidden; /* Evita scroll horizontal accidental */
        }

        /* Navbar (Consistente con Index) */
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
        
        /* Hero Header Simplificado */
        .page-header {
            background: linear-gradient(135deg, #404040, #6e6e6e);
            color: white;
            padding: 80px 0 50px;
            text-align: center;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .page-header h1 { font-weight: 700; font-size: 2.5rem; }
        .page-header p { opacity: 0.9; font-size: 1.1rem; }

        /* Contenedores y Tarjetas */
        .section-title {
            color: #007bff;
            font-weight: 700;
            margin-bottom: 20px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .vr-container {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            border: 4px solid white;
            background: #000;
            position: relative;
        }

        .model-card {
            background: white;
            border-radius: 15px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            overflow: hidden;
            height: 100%;
        }
        .model-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        .model-card model-viewer {
            width: 100%;
            height: 250px;
            background: linear-gradient(180deg, #f8f9fa 0%, #e9ecef 100%);
        }
        .card-body {
            text-align: center;
            padding: 20px;
        }
        .card-title { font-weight: 600; color: #333; }

        /* Chatbot */
        .chat-toggle {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            font-size: 1.8rem;
            cursor: pointer;
            box-shadow: 0 5px 20px rgba(0,123,255,0.4);
            transition: transform 0.3s;
            z-index: 2000;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .chat-toggle:hover { transform: scale(1.1); background-color: #0056b3; }

        .chat-box {
            position: fixed;
            bottom: 100px;
            right: 30px;
            width: 320px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
            display: none;
            flex-direction: column;
            z-index: 2000;
            font-size: 0.95rem;
            border: 1px solid rgba(0,0,0,0.05);
        }
        .chat-header {
            background: linear-gradient(90deg, #007bff, #0056b3);
            color: white;
            padding: 15px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .chat-messages {
            height: 250px;
            overflow-y: auto;
            padding: 15px;
            background-color: #f9f9f9;
        }
        .user-msg { text-align: right; background: #e1f0ff; padding: 8px 12px; border-radius: 12px 12px 0 12px; margin-bottom: 10px; display: inline-block; margin-left: auto; max-width: 80%; }
        .bot-msg { text-align: left; background: white; padding: 8px 12px; border-radius: 12px 12px 12px 0; margin-bottom: 10px; border: 1px solid #eee; display: inline-block; max-width: 80%; }
        
        .chat-input { display: flex; border-top: 1px solid #eee; padding: 10px; background: white; }
        .chat-input input { flex: 1; border: 1px solid #ddd; padding: 8px 12px; border-radius: 20px; outline: none; }
        .chat-input button { background: none; border: none; color: #007bff; font-weight: 600; margin-left: 10px; cursor: pointer; }

        /* Footer */
        footer {
            background-color: #343a40;
            color: rgba(255,255,255,0.6);
            text-align: center;
            padding: 30px 0;
            margin-top: 60px;
        }

        /* Modal Personalizado */
        .modal-backdrop {
            background-color: rgba(0,0,0,0.8);
        }
        
        /* Mascota flotante pequeña */
        .mascota-float {
            position: fixed;
            bottom: 20px;
            left: 20px;
            width: 120px;
            height: 120px;
            z-index: 1500;
            filter: drop-shadow(0 5px 10px rgba(0,0,0,0.2));
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
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link active" href="servicios.jsp">Servicios</a></li>
                    <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                    <li class="nav-item"><a class="nav-link" href="carrito.jsp">🛒 Carrito</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="page-header">
        <div class="container mt-5">
            <h1>Nuestros Servicios</h1>
            <p>Explora la innovación médica: desde realidad virtual hasta modelos interactivos.</p>
        </div>
    </header>

    <div class="container">
        
        <section class="mb-5">
            <h2 class="section-title">Sala de Operaciones VR</h2>
            <p class="text-center text-muted mb-4">
                Haz clic en los puntos de colores para ver información detallada. Si tienes gafas VR, entra en modo inmersivo.
            </p>

            <div class="d-flex justify-content-center gap-3 mb-3">
                <button id="authBtn" class="btn btn-primary rounded-pill px-4">🔑 Autorizar Sensores (VR)</button>
                <button id="focusBtn" class="btn btn-outline-secondary rounded-pill px-4">🎯 Centrar Cámara</button>
            </div>

            <div class="vr-container" style="height: 600px;">
                <a-scene embedded vr-mode-ui="enabled: true" renderer="antialias: true, colorManagement: true" style="width:100%; height:100%;">
                    <a-assets>
                        <a-asset-item id="operRoom" src="../image/charite_university_hospital_-_operating_room.glb"></a-asset-item>
                        <a-asset-item id="service1" src="../image/test_tube_mutations.glb"></a-asset-item>
                        <a-asset-item id="service2" src="../image/bandaged_hand.glb"></a-asset-item>
                        <a-asset-item id="service3" src="../image/medical_x_ray_image_viewer_200_uploads.glb"></a-asset-item>
                    </a-assets>

                    <a-entity light="type: ambient; intensity: 1.2"></a-entity>
                    <a-entity light="type: directional; intensity: 0.8" position="-1 10 5"></a-entity>

                    <a-entity id="operatingRoom" gltf-model="#operRoom" position="0 0 0" scale="1 1 1"></a-entity>

                    <a-entity id="hotspot-1" class="hotspot" geometry="primitive:sphere;radius:0.15" material="color:#ff5a5a; emissive:#ff0000; emissiveIntensity:0.5; opacity:0.9" position="-1.5 1.1 -2.2"
                              animation="property: scale; to: 1.2 1.2 1.2; dir: alternate; loop: true; dur: 1000"></a-entity>
                    
                    <a-entity id="hotspot-2" class="hotspot" geometry="primitive:sphere;radius:0.15" material="color:#4adf8b; emissive:#00ff00; emissiveIntensity:0.3; opacity:0.9" position="0.6 1.0 -1.0"
                              animation="property: scale; to: 1.2 1.2 1.2; dir: alternate; loop: true; dur: 1200"></a-entity>
                    
                    <a-entity id="hotspot-3" class="hotspot" geometry="primitive:sphere;radius:0.15" material="color:#7aa7ff; emissive:#0000ff; emissiveIntensity:0.3; opacity:0.9" position="2.0 1.2 -2.5"
                              animation="property: scale; to: 1.2 1.2 1.2; dir: alternate; loop: true; dur: 1100"></a-entity>

                    <a-entity id="cameraRig">
                        <a-entity id="mainCamera" camera look-controls position="0 1.6 2">
                            <a-entity cursor="fuse:false;rayOrigin:mouse" raycaster="objects:.hotspot" position="0 0 -0.5"
                                geometry="primitive:ring;radiusInner:0.01;radiusOuter:0.015" material="color:white;shader:flat"></a-entity>
                        </a-entity>
                    </a-entity>
                </a-scene>
            </div>
        </section>

        <section class="py-5">
            <h2 class="section-title">Especialidades Interactivas</h2>
            <p class="text-center text-muted mb-5">Interactúa con los modelos 3D para conocer más sobre nuestros departamentos.</p>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="model-card">
                        <model-viewer src="../image/test_tube_mutations.glb" alt="Exámenes de Sangre" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="card-body">
                            <h5 class="card-title">Laboratorio Clínico</h5>
                            <p class="card-text small text-muted">Análisis de sangre y muestras con tecnología de precisión para diagnósticos rápidos.</p>
                            <button class="btn btn-sm btn-outline-primary rounded-pill mt-2">Ver detalles</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="model-card">
                        <model-viewer src="../image/bandaged_hand.glb" alt="Rehabilitación" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="card-body">
                            <h5 class="card-title">Traumatología</h5>
                            <p class="card-text small text-muted">Recuperación de lesiones y terapias físicas personalizadas para tu movilidad.</p>
                            <button class="btn btn-sm btn-outline-success rounded-pill mt-2">Ver terapias</button>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="model-card">
                        <model-viewer src="../image/medical_x_ray_image_viewer_200_uploads.glb" alt="Rayos X" camera-controls auto-rotate shadow-intensity="1"></model-viewer>
                        <div class="card-body">
                            <h5 class="card-title">Imagenología</h5>
                            <p class="card-text small text-muted">Radiografías, tomografías y resonancias de alta resolución.</p>
                            <button class="btn btn-sm btn-outline-info rounded-pill mt-2">Agendar cita</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <div id="modalBackdrop" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.7); z-index:3000; align-items:center; justify-content:center; backdrop-filter: blur(5px);">
        <div class="bg-white p-4 rounded-4 shadow-lg position-relative" style="width:90%; max-width:800px;">
            <button id="closeModal" class="btn-close position-absolute top-0 end-0 m-3"></button>
            <h3 id="modalTitle" class="text-primary fw-bold mb-3">Título</h3>
            <div class="row align-items-center">
                <div class="col-md-7">
                    <model-viewer id="modalModel" src="" style="width:100%; height:400px; background:#f0f0f0; border-radius:15px;" camera-controls auto-rotate></model-viewer>
                </div>
                <div class="col-md-5">
                    <p id="modalDesc" class="fs-5 mt-3 mt-md-0 text-secondary"></p>
                    <button class="btn btn-primary w-100 mt-3" onclick="document.getElementById('modalBackdrop').style.display='none'">Entendido</button>
                </div>
            </div>
        </div>
    </div>

    <div class="mascota-float d-none d-md-block">
        <model-viewer src="../image/cute_shark_animated_character.glb" alt="Mascota" auto-rotate camera-controls disable-zoom style="width:100%; height:100%;"></model-viewer>
    </div>

    <button class="chat-toggle">💬</button>

    <div class="chat-box" id="chatBox">
        <div class="chat-header">
            <img src="../image/logo.PNG" width="30" height="30" class="rounded-circle bg-white p-1">
            <span>Soporte MediVital</span>
        </div>
        <div class="chat-messages" id="chatMessages">
            <div class="bot-msg">¡Hola! 👋 Soy el asistente virtual de MediVital. ¿En qué puedo ayudarte con nuestros servicios?</div>
        </div>
        <div class="chat-input">
            <input type="text" id="userInput" placeholder="Escribe aquí...">
            <button id="sendBtn">➤</button>
        </div>
    </div>

    <footer>
        <div class="container">
            <p class="mb-0">© 2025 MediVital - Innovación y Salud.</p>
            <small>Todos los derechos reservados.</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // --- Lógica Hotspots VR ---
        const hotspots = {
            'hotspot-1': { title: 'Análisis Clínicos', desc: 'Laboratorio equipado para hematología, microbiología y química sanguínea.', src: '../image/test_tube_mutations.glb' },
            'hotspot-2': { title: 'Rehabilitación Física', desc: 'Área especializada en recuperación motriz con equipos de última generación.', src: '../image/bandaged_hand.glb' },
            'hotspot-3': { title: 'Rayos X Digitales', desc: 'Diagnósticos por imagen con mínima radiación y resultados inmediatos.', src: '../image/medical_x_ray_image_viewer_200_uploads.glb' }
        };

        // Esperar a que A-Frame cargue
        document.querySelector('a-scene').addEventListener('loaded', () => {
            Object.keys(hotspots).forEach(id => {
                const el = document.getElementById(id);
                if(el) {
                    // Evento click en VR/3D
                    el.addEventListener('click', () => openModalFor(id));
                    // Evento para cursor mouse
                    el.addEventListener('mouseenter', () => el.setAttribute('scale', '1.5 1.5 1.5'));
                    el.addEventListener('mouseleave', () => el.setAttribute('scale', '1 1 1'));
                }
            });
        });

        const modalBackdrop = document.getElementById('modalBackdrop');
        const modalModel = document.getElementById('modalModel');
        const modalTitle = document.getElementById('modalTitle');
        const modalDesc = document.getElementById('modalDesc');

        document.getElementById('closeModal').addEventListener('click', () => {
            modalBackdrop.style.display = 'none';
        });

        function openModalFor(id) {
            const d = hotspots[id];
            modalTitle.textContent = d.title;
            modalDesc.textContent = d.desc;
            modalModel.src = d.src;
            modalBackdrop.style.display = 'flex';
        }

        // --- Lógica Chat ---
        const toggleBtn = document.querySelector('.chat-toggle');
        const chatBox = document.getElementById('chatBox');
        
        toggleBtn.addEventListener('click', () => {
            const isHidden = chatBox.style.display === 'none' || chatBox.style.display === '';
            chatBox.style.display = isHidden ? 'flex' : 'none';
        });

        const sendBtn = document.getElementById('sendBtn');
        const userInput = document.getElementById('userInput');
        const chatMessages = document.getElementById('chatMessages');

        function sendMessage() {
            const msg = userInput.value.trim();
            if (!msg) return;
            
            // Mensaje usuario
            chatMessages.innerHTML += `<div class="text-end"><div class="user-msg">${msg}</div></div>`;
            userInput.value = '';
            chatMessages.scrollTop = chatMessages.scrollHeight;

            // Respuesta Bot simulada
            setTimeout(() => {
                chatMessages.innerHTML += `<div><div class="bot-msg">Gracias por tu interés. Un especialista revisará tu consulta sobre "${msg}" y te contactará pronto.</div></div>`;
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }, 1000);
        }

        sendBtn.addEventListener('click', sendMessage);
        userInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') sendMessage();
        });

        // --- Centrar Cámara VR ---
        document.getElementById('focusBtn').addEventListener('click', () => {
            const cam = document.getElementById('mainCamera');
            cam.setAttribute('position', '0 1.6 2');
            cam.setAttribute('rotation', '0 0 0');
        });
        
        // --- Permisos VR (iOS/Android recientes) ---
        document.getElementById('authBtn').addEventListener('click', () => {
            if (DeviceMotionEvent && typeof DeviceMotionEvent.requestPermission === 'function') {
                DeviceMotionEvent.requestPermission()
                    .then(response => {
                        if (response === 'granted') {
                            alert('Permiso concedido. ¡Disfruta la experiencia VR!');
                        } else {
                            alert('Permiso denegado.');
                        }
                    })
                    .catch(console.error);
            } else {
                alert('Tu dispositivo no requiere permiso especial o no es compatible.');
            }
        });
    </script>

</body>
</html>