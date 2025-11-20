document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("formCliente");

    form.addEventListener("submit", (e) => {
        // Captura los datos antes de enviar al servidor
        const nombre = document.getElementById("nombre").value;
        const cedula = document.getElementById("cedula").value;
        const estado = document.getElementById("estado").value;
        const residencia = document.querySelector('input[name="rdResidencia"]:checked')?.value;
        const foto = document.getElementById("foto").files[0]?.name || "No se seleccionó archivo";
        const fecha = document.getElementById("fecha").value;
        const color = document.getElementById("color").value;
        const correo = document.getElementById("correo").value;
        const clave = document.getElementById("clave").value;

        const cliente = {
            Nombre: nombre,
            Cedula: cedula,
            EstadoCivil: estado,
            Residencia: residencia,
            Foto: foto,
            FechaNacimiento: fecha,
            ColorFavorito: color,
            Correo: correo,
            Clave: clave
        };

        console.clear();
        console.log("🆕 Datos capturados del formulario:");
        console.table(cliente);
    });
});
