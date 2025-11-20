<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.productos.seguridad.Bitacora"
    import="com.productos.negocio.Producto"
%>

<%
    String idProd = request.getParameter("id");
    String opcion = request.getParameter("rdOpcion");

    if (opcion != null && opcion.equals("si")) {

        // ==== ELIMINAR PRODUCTO ====
        Producto prod = new Producto();
        prod.eliminarProducto(idProd);

        // ==== REGISTRAR EN BITÁCORA ====
        Integer idAdmin = (Integer) session.getAttribute("id_usuario");
        Bitacora b = new Bitacora();
        b.registrar(idAdmin, "ELIMINAR PRODUCTO", "Producto ID: " + idProd);
    }

    // Redirigir siempre al listado
    response.sendRedirect("productos.jsp");
%>
