<%@ page import="java.util.*, com.productos.modelo.ItemCarrito" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    double precio = Double.parseDouble(request.getParameter("precio"));

    List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");

    if (carrito == null) carrito = new ArrayList<>();

    boolean existe = false;

    for (ItemCarrito item : carrito) {
        if (item.getId() == id) {
            item.setCantidad(item.getCantidad() + 1);
            existe = true;
            break;
        }
    }

    if (!existe) {
        carrito.add(new ItemCarrito(id, nombre, precio, 1));
    }

    session.setAttribute("carrito", carrito);

    response.sendRedirect("productos.jsp");
%>
