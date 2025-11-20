<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.productos.negocio.Producto"
%>
<%
    String nombre = request.getParameter("txt_nombre");
    int categoria = Integer.parseInt(request.getParameter("cmb_categoria"));
    double precio = Double.parseDouble(request.getParameter("txt_precio"));
    int cantidad = Integer.parseInt(request.getParameter("txt_cantidad"));

    Producto prod = new Producto();
    String mensaje = prod.ingresarProducto(categoria, nombre, cantidad, precio);

    // Redirigir al listado de productos (puedes pasar mensaje con query si quieres)
    response.sendRedirect("admin_verProductos.jsp");
%>
