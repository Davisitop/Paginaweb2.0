<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Añadir Producto</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">

    <h3>Añadir Nuevo Producto</h3>
    <hr>

    <form action="insertar_producto.jsp" method="POST">

        <div class="mb-3">
            <label>Nombre del Producto:</label>
            <input type="text" name="txt_nombre" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Categoría:</label>
            <select name="cmb_categoria" class="form-control" required>
                <option value="1">medicina</option>
                <option value="2">uniformes</option>
                <option value="3">implementos medicos</option>
            </select>
        </div>

        <div class="mb-3">
            <label>Precio:</label>
            <input type="number" name="txt_precio" step="0.01" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Cantidad:</label>
            <input type="number" name="txt_cantidad" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="productos_admin.jsp" class="btn btn-secondary">Cancelar</a>

    </form>

</body>
</html>
