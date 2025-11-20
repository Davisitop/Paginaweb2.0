<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.productos.seguridad.Bitacora"
    import="com.productos.negocio.Producto"
%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    int idCat = Integer.parseInt(request.getParameter("categoria"));
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
    double precio = Double.parseDouble(request.getParameter("precio"));

    Producto p = new Producto();
    String mensaje = p.actualizarProducto(id, nombre, idCat, cantidad, precio);

    // ==== REGISTRO EN BITÁCORA ====
    Integer idAdmin = (Integer) session.getAttribute("id_usuario");
    Bitacora b = new Bitacora();
    b.registrar(idAdmin, "ACTUALIZAR PRODUCTO", "Producto ID: " + id);

    response.sendRedirect("admin_verProductos.jsp");
%>
