<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Bitacora"
    import="com.productos.negocio.Producto"
%>

<%
    // 1. Validación de seguridad (Solo Admin)
    if (session.getAttribute("perfil") == null || (Integer) session.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }

    // 2. Capturar los datos como String primero
    String idStr = request.getParameter("id");
    String nombre = request.getParameter("nombre");
    String catStr = request.getParameter("categoria");
    String cantStr = request.getParameter("cantidad");
    String precioStr = request.getParameter("precio");

    try {
        // 3. Convertir y Validar
        int id = Integer.parseInt(idStr);
        int idCat = Integer.parseInt(catStr);
        double precio = Double.parseDouble(precioStr);
        
        // Validación especial para cantidad (evitar números gigantes)
        // Usamos Long para ver si cabe, y luego verificamos límites de Integer
        long checkCant = Long.parseLong(cantStr);
        if (checkCant > 2147483647) {
            throw new NumberFormatException("La cantidad es demasiado grande.");
        }
        int cantidad = (int) checkCant;

        // 4. Actualizar en Base de Datos
        Producto p = new Producto();
        String mensaje = p.actualizarProducto(id, nombre, idCat, cantidad, precio);

        // 5. Registrar en Bitácora
        Integer idAdmin = (Integer) session.getAttribute("id_usuario");
        if (idAdmin == null) idAdmin = 0;
        
        Bitacora b = new Bitacora();
        b.registrar(idAdmin, "ACTUALIZAR PRODUCTO", "Actualizó producto ID: " + id);

        // Redirigir éxito
        response.sendRedirect("admin_verProductos.jsp?msg=Producto+actualizado+correctamente");

    } catch (NumberFormatException e) {
        // ERROR DE NÚMEROS: Redirigir al formulario con mensaje de error
        System.out.println("Error de formato al actualizar: " + e.getMessage());
        response.sendRedirect("actualizar.jsp?id=" + idStr + "&error=Error:+Verifique+que+la+cantidad+y+precio+sean+correctos");
        
    } catch (Exception e) {
        // OTROS ERRORES
        System.out.println("Error general al actualizar: " + e.getMessage());
        response.sendRedirect("admin_verProductos.jsp?error=Ocurrio+un+error+al+procesar");
    }
%>