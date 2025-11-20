public String reporteUsuarios() {
    String sql = "SELECT id_us, nombre_us, correo_us, id_per FROM tb_usuario";
    Conexion con = new Conexion();
    String tabla = "<table class='table table-striped'><thead><tr>"
            + "<th>ID</th><th>Nombre</th><th>Correo</th><th>Perfil</th><th>Acciones</th></tr></thead><tbody>";

    try {
        ResultSet rs = con.Consulta(sql);
        while (rs.next()) {
            tabla += "<tr>"
                 + "<td>"+rs.getInt(1)+"</td>"
                 + "<td>"+rs.getString(2)+"</td>"
                 + "<td>"+rs.getString(3)+"</td>"
                 + "<td>"+rs.getInt(4)+"</td>"
                 + "<td>"
                 + "<a href='admin_editarUsuario.jsp?id="+rs.getInt(1)+"' class='btn btn-warning btn-sm'>Editar</a> "
                 + "<a href='admin_eliminarUsuario.jsp?id="+rs.getInt(1)+"' class='btn btn-danger btn-sm'>Eliminar</a>"
                 + "</td></tr>";
        }
    } catch (Exception e){}

    return tabla + "</tbody></table>";
}
