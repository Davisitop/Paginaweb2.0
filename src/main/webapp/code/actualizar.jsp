<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"
    session="true"
    import="com.productos.datos.Conexion"
    import="java.sql.ResultSet"
    import="java.sql.Connection"
    import="java.sql.Statement"
%><%@ page import="com.productos.seguridad.Bitacora" %>

<%
    // Protección de Página (Solo Admins)
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) {
        response.sendRedirect("login.jsp?error=Acceso no autorizado");
        return;
    }
    
    // 1. Obtener el ID del producto de la URL
    String id = request.getParameter("id");
    
    // 2. Conectar y buscar datos
    Conexion con = new Conexion();
    Connection cn = con.getConexion();
    Statement st = null;
    ResultSet rs = null;
    
    if (cn == null || id == null || id.isEmpty()) {
        out.println("Error: No se pudo conectar o ID de producto no válido.");
        return;
    }
    
    String sql = "SELECT * FROM tb_producto WHERE id_pr = " + id;
    st = cn.createStatement();
    rs = st.executeQuery(sql); // Usamos executeQuery para SELECT
    
    // 3. Mover el cursor a la primera fila
    if (!rs.next()) {
        out.println("Error: Producto no encontrado.");
        rs.close();
        st.close();
        cn.close();
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Modificar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header">
                        <h3>Modificar Producto (ID: <%= id %>)</h3>
                    </div>
                    <div class="card-body">
                        <form action="admin_procesarActualizacion.jsp" method="post">
                            
                            <input type="hidden" name="id" value="<%= id %>">
                            
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre:</label>
                                <input type="text" class="form-control" id="nombre" name="nombre"
                                    value="<%= rs.getString("nombre_pr") %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="categoria" class="form-label">Categoría:</label>
                                <select class="form-select" name="categoria" id="categoria">
                                    <%-- Hacemos que la categoría correcta esté seleccionada --%>
                                    <option value="1" <%= rs.getInt("id_cat") == 1 ? "selected" : "" %>>Dama</option>
                                    <option value="2" <%= rs.getInt("id_cat") == 2 ? "selected" : "" %>>Caballero</option>
                                    <option value="3" <%= rs.getInt("id_cat") == 3 ? "selected" : "" %>>Niño</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="cantidad" class="form-label">Cantidad:</label>
                                <input type="number" class="form-control" id="cantidad" name="cantidad"
                                    value="<%= rs.getInt("cantidad_pr") %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="precio" class="form-label">Precio:</label>
                                <input type="number" step="0.01" class="form-control" id="precio" name="precio"
                                    value="<%= rs.getDouble("precio_pr") %>" required>
                            </div>
                            
                            <button type="submit" class="btn btn-warning">Guardar Cambios</button>
                            <a href="admin_verProductos.jsp" class="btn btn-secondary">Cancelar</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%
    // Cerramos la conexión
    try {
        rs.close();
        st.close();
        cn.close();
    } catch (Exception e) {}
%>
</body>
</html>