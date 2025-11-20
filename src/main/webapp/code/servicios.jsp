<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.productos.seguridad.Bitacora" %>


<!DOCTYPE html>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Servicios - MediVital (VR + Interactivos)</title>
    <link rel="stylesheet" href="estilos3.css" type="text/css">

```
<!-- Librerías 3D -->
<script src="https://aframe.io/releases/1.4.2/aframe.min.js"></script>
<script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>

<style>
    body { margin:0; font-family:'Segoe UI', sans-serif; background:#f5f5f5; color:#333; }
    header { background:linear-gradient(135deg,#404040,#6e6e6e); color:white; text-align:center; padding:20px 0; }
    header .logo { width:100px; border-radius:50%; margin-bottom:10px; }
    nav { background:#555; text-align:center; padding:10px 0; }
    nav a { color:white; text-decoration:none; padding:12px 20px; margin:0 5px; display:inline-block; font-weight:500; }
    nav a:hover, nav a.active { background:#777; border-radius:8px; }
    section { width:85%; margin:30px auto; text-align:center; background:white; padding:25px; border-radius:12px; box-shadow:0 0 12px rgba(0,0,0,0.2); }
    section h2 { color:#444; }
    section .intro { margin-bottom:20px; font-size:1.05em; color:#555; }
    .controls { margin-top:12px; display:flex; justify-content:center; gap:12px; }
    .btn { padding:8px 12px; border:none; border-radius:8px; cursor:pointer; }
    .btn-primary { background:#4a90e2; color:white; }
    .btn-ghost { background:transparent; border:1px solid #ccc; }
    .modelos { display:flex; flex-wrap:wrap; justify-content:space-around; gap:25px; margin-top:25px; }
    .modelo { width:300px; background-color:#f0f0f0; border-radius:15px; box-shadow:0 0 10px rgba(0,0,0,0.1); text-align:center; padding:15px; transition:transform 0.4s, box-shadow 0.4s; }
    .modelo:hover { transform:scale(1.05); box-shadow:0 0 18px rgba(0,0,0,0.25); }
    model-viewer { width:100%; height:250px; background:linear-gradient(135deg,#ececec,#fafafa); border-radius:10px; }
    footer { background:#444; color:white; text-align:center; padding:15px 0; margin-top:30px; font-size:0.9em; }
    .mascota-container { position:fixed; bottom:20px; right:20px; width:160px; height:160px; z-index:1000; }
    .mascota-container model-viewer { width:160px; height:160px; }
    .chat-box { position:fixed; bottom:200px; right:25px; width:260px; background:white; border-radius:12px; box-shadow:0 0 10px rgba(0,0,0,0.3); overflow:hidden; display:none; flex-direction:column; }
    .chat-header { background-color:#4a90e2; color:white; padding:10px; text-align:center; font-weight:bold; }
    .chat-messages { height:180px; overflow-y:auto; padding:10px; font-size:0.9em; }
    .chat-messages div { margin-bottom:8px; }
    .user-msg { text-align:right; color:#333; }
    .bot-msg { text-align:left; color:#4a90e2; }
    .chat-input { display:flex; border-top:1px solid #ddd; }
    .chat-input input { flex:1; border:none; padding:8px; font-size:0.9em; }
    .chat-input button { background-color:#4a90e2; color:white; border:none; padding:8px 12px; cursor:pointer; }
    .chat-input button:hover { background-color:#357ab8; }
    .chat-toggle { position:fixed; bottom:180px; right:45px; background-color:#4a90e2; color:white; border:none; border-radius:50%; width:55px; height:55px; font-size:1.5em; cursor:pointer; box-shadow:0 0 10px rgba(0,0,0,0.3); }
    .chat-toggle:hover { background-color:#357ab8; }
</style>
```

</head>
<body>
<header>
    <img src="../image/logo.PNG" alt="Logo MediVital" class="logo">
    <h1>MediVital</h1>
    <p style="margin:0;color:#ddd;">Explora nuestros servicios dentro de la sala de operaciones o con modelos 3D interactivos.</p>
</header>

<nav>
    <a href="index.jsp">Inicio</a>
    <a class="active" href="servicios.jsp">Servicios</a>
    <a href="productos.jsp">Productos</a>
</nav>

<section>
    <h2>Experiencia VR - Sala de Operaciones 3D</h2>
    <p class="intro">Haz clic en los puntos dentro de la sala para conocer los servicios, o entra en modo VR si tu dispositivo lo permite.</p>
    <div class="controls">
        <button id="authBtn" class="btn btn-primary">Autorizar acceso VR (API)</button>
        <button id="focusBtn" class="btn btn-ghost">Centrar cámara</button>
    </div>
</section>

<!-- Escena VR -->

<a-scene embedded vr-mode-ui="enabled: true" renderer="antialias: true" style="width:100%; height:80vh; display:block;">
    <a-assets>
        <a-asset-item id="operRoom" src="../image/charite_university_hospital_-_operating_room.glb"></a-asset-item>
        <a-asset-item id="service1" src="../image/test_tube_mutations.glb"></a-asset-item>
        <a-asset-item id="service2" src="../image/bandaged_hand.glb"></a-asset-item>
        <a-asset-item id="service3" src="../image/medical_x_ray_image_viewer_200_uploads.glb"></a-asset-item>
    </a-assets>

```
<a-entity light="type: ambient; intensity: 0.8"></a-entity>
<a-entity light="type: directional; intensity: 0.6" position="0 10 2"></a-entity>

<a-entity id="operatingRoom" gltf-model="#operRoom" position="0 0 0" scale="1 1 1"></a-entity>

<a-entity id="hotspot-1" class="hotspot" geometry="primitive:sphere;radius:0.12" material="color:#ff5a5a;opacity:0.9" position="-1.5 1.1 -2.2"></a-entity>
<a-entity id="hotspot-2" class="hotspot" geometry="primitive:sphere;radius:0.12" material="color:#4adf8b;opacity:0.9" position="0.6 1.0 -1.0"></a-entity>
<a-entity id="hotspot-3" class="hotspot" geometry="primitive:sphere;radius:0.12" material="color:#7aa7ff;opacity:0.9" position="2.0 1.2 -2.5"></a-entity>

<a-entity id="cameraRig">
    <a-entity id="mainCamera" camera look-controls position="0 1.6 3">
        <a-entity cursor="fuse:false;rayOrigin:mouse" raycaster="objects:.hotspot" position="0 0 -0.5"
            geometry="primitive:ring;radiusInner:0.01;radiusOuter:0.02" material="color:white;shader:flat"></a-entity>
    </a-entity>
</a-entity>
```

</a-scene>

<!-- Modal model-viewer -->

<div class="modal-backdrop" id="modalBackdrop" style="display:none;align-items:center;justify-content:center;position:fixed;inset:0;background:rgba(0,0,0,0.6);z-index:2000;">
    <div class="modal" style="width:90%;max-width:900px;background:white;border-radius:12px;padding:16px;">
        <header style="display:flex;justify-content:space-between;align-items:center;">
            <h3 id="modalTitle">Servicio</h3>
            <button id="closeModal" class="btn btn-ghost">Cerrar</button>
        </header>
        <div id="modalBody">
            <model-viewer id="modalModel" src="" alt="Servicio 3D" camera-controls auto-rotate ar style="width:100%;height:500px;background:#f6f6f6;border-radius:8px;"></model-viewer>
            <p id="modalDesc" style="margin-top:8px;color:#444;"></p>
        </div>
    </div>
</div>

<section>
    <h2>Servicios 3D Interactivos</h2>
    <p class="intro">Explora nuestros servicios en 3D. Gira, acerca y conoce más sobre nuestras áreas de especialidad.</p>
    <div class="modelos">
        <div class="modelo">
            <model-viewer src="../image/test_tube_mutations.glb" alt="Exámenes de Sangre" camera-controls auto-rotate ar shadow-intensity="1"></model-viewer>
            <h4>Exámenes de Sangre</h4>
            <p>Análisis clínicos con tecnología avanzada para diagnósticos precisos.</p>
        </div>
        <div class="modelo">
            <model-viewer src="../image/bandaged_hand.glb" alt="Rehabilitación" camera-controls auto-rotate ar shadow-intensity="1"></model-viewer>
            <h4>Rehabilitación y Tratamientos</h4>
            <p>Terapias para recuperar movilidad y fuerza con atención personalizada.</p>
        </div>
        <div class="modelo">
            <model-viewer src="../image/medical_x_ray_image_viewer_200_uploads.glb" alt="Rayos X" camera-controls auto-rotate ar shadow-intensity="1"></model-viewer>
            <h4>Rayos X</h4>
            <p>Diagnósticos radiográficos digitales de alta resolución.</p>
        </div>
    </div>
</section>

<div class="mascota-container">
    <model-viewer src="../image/cute_shark_animated_character.glb" alt="Mascota MediVital" auto-rotate camera-controls shadow-intensity="1"></model-viewer>
</div>

<button class="chat-toggle">💬</button>

<div class="chat-box" id="chatBox">
    <div class="chat-header">Asistente MediVital</div>
    <div class="chat-messages" id="chatMessages">
        <div class="bot-msg">¡Hola! 😊 ¿En qué puedo ayudarte hoy?</div>
    </div>
    <div class="chat-input">
        <input type="text" id="userInput" placeholder="Escribe tu mensaje...">
        <button id="sendBtn">Enviar</button>
    </div>
</div>

<footer>
    <p>&copy; 2025 MediVital - Todos los derechos reservados.</p>
</footer>

<script>
// --- Hotspots ---
const hotspots = {
  'hotspot-1': { title:'Exámenes de Sangre', desc:'Análisis clínicos avanzados.', src:'../image/test_tube_mutations.glb' },
  'hotspot-2': { title:'Rehabilitación', desc:'Terapias personalizadas.', src:'../image/bandaged_hand.glb' },
  'hotspot-3': { title:'Rayos X', desc:'Diagnósticos radiográficos digitales.', src:'../image/medical_x_ray_image_viewer_200_uploads.glb' }
};
document.querySelector('a-scene').addEventListener('loaded',()=>{
  Object.keys(hotspots).forEach(id=>{
    const e=document.getElementById(id);
    e.addEventListener('click',()=>openModalFor(id));
  });
});
const modalBackdrop=document.getElementById('modalBackdrop');
const modalModel=document.getElementById('modalModel');
const modalTitle=document.getElementById('modalTitle');
const modalDesc=document.getElementById('modalDesc');
document.getElementById('closeModal').addEventListener('click',()=>modalBackdrop.style.display='none');
function openModalFor(id){
  const d=hotspots[id];
  modalTitle.textContent=d.title;
  modalDesc.textContent=d.desc;
  modalModel.src=d.src;
  modalBackdrop.style.display='flex';
}

// --- Chat ---
const toggleBtn=document.querySelector('.chat-toggle');
const chatBox=document.getElementById('chatBox');
toggleBtn.addEventListener('click',()=>chatBox.style.display=chatBox.style.display==='flex'?'none':'flex');
const sendBtn=document.getElementById('sendBtn');
const userInput=document.getElementById('userInput');
const chatMessages=document.getElementById('chatMessages');
sendBtn.addEventListener('click',()=>{
  const msg=userInput.value.trim();
  if(!msg)return;
  chatMessages.innerHTML+=`<div class="user-msg">${msg}</div>`;
  setTimeout(()=>{
    chatMessages.innerHTML+=`<div class="bot-msg">Gracias por tu mensaje 😊, pronto te atenderemos.</div>`;
    chatMessages.scrollTop=chatMessages.scrollHeight;
  },700);
  userInput.value='';
});

// --- Movimiento con teclado ---
document.addEventListener('keydown', function(event) {
    const cam = document.querySelector('#mainCamera');
    if(!cam) return;
    let pos = cam.getAttribute('position');
    const speed = 0.2;
    switch(event.key) {
        case 'ArrowUp':    pos.z -= speed; break;
        case 'ArrowDown':  pos.z += speed; break;
        case 'ArrowLeft':  pos.x -= speed; break;
        case 'ArrowRight': pos.x += speed; break;
    }
    cam.setAttribute('position', pos);
});
</script>

</body>
</html>

