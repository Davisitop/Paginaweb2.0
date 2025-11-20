<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.Producto"
    session="true" import="com.productos.seguridad.Pagina"%><%@ page import="com.productos.seguridad.Bitacora" %>
    
<%
    // Verificación de sesión
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");

    if (usuario == null) {
        response.sendRedirect("login.jsp?error=Debe+registrarse");
        return;
    }
    // Fin Verificación
    
    String idProd = request.getParameter("id");
    Producto prod = new Producto();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Eliminar Producto - MediVital</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-danger text-white">
                        <h3>Eliminar Producto</h3>
                    </div>
                    <div class="card-body">
                        <p><strong>¿Está seguro de eliminar el siguiente producto?</strong></p>
                        
                        <%
                            out.print(prod.buscarProductold(idProd));
                        %>
                        
                        <form action="eliminarProducto.jsp" method="post">
                            <input type="hidden" name="id" value="<%= idProd %>">
                            
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rdOpcion" id="rdSi" value="si" checked>
                                <label class="form-check-label" for="rdSi">
                                    Sí, eliminar
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rdOpcion" id="rdNo" value="no">
                                <label class="form-check-label" for="rdNo">
                                    No, cancelar
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-danger mt-3">Confirmar</button>
                            <a href="productos.jsp" class="btn btn-secondary mt-3">Cancelar</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>