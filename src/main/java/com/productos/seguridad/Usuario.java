package com.productos.seguridad;

import java.sql.ResultSet;
import com.productos.datos.Conexion; 
import java.sql.Connection;
import java.sql.Statement;

public class Usuario {

    // ======================
    //   ATRIBUTOS
    // ======================
    private Integer id;
    private Integer perfil;
    private int estadoCivil;
    private String cedula;
    private String nombre;
    private String correo;
    private String clave;

    // ======================
    //   GETTERS & SETTERS
    // ======================

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getPerfil() { return perfil; }
    public void setPerfil(Integer perfil) { this.perfil = perfil; }

    public int getEstadoCivil() { return estadoCivil; }
    public void setEstadoCivil(int estadoCivil) { this.estadoCivil = estadoCivil; }

    public String getCedula() { return cedula; }
    public void setCedula(String cedula) { this.cedula = cedula; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }

    // ===================================================
    //   MÉTODO PARA VERIFICAR LOGIN (CORREGIDO)
    // ===================================================

    public boolean verificarUsuario(String ncorreo, String nclave) {
        boolean respuesta = false;

        String sentencia = "SELECT * FROM tb_usuario WHERE correo_us='" + ncorreo +
                           "' AND clave_us='" + nclave + "';";

        Conexion clsCon = new Conexion();
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            cn = clsCon.getConexion();
            st = cn.createStatement();
            rs = st.executeQuery(sentencia);

            if (rs.next()) {
                respuesta = true;

                // ====== CAMPOS CORRECTAMENTE CARGADOS ======
                this.setId(rs.getInt("id_us"));  
                this.setCorreo(ncorreo);
                this.setClave(nclave);
                this.setPerfil(rs.getInt("id_per"));
                this.setNombre(rs.getString("nombre_us"));
                this.setEstadoCivil(rs.getInt("id_est"));
                this.setCedula(rs.getString("cedula_us"));
            } 
        } catch (Exception ex) {
            System.out.println("Error en verificarUsuario: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                System.out.println("Error cerrando recursos: " + e.getMessage());
            }
        }
        return respuesta;
    }

    // ===================================================
    //   MÉTODO PARA CREAR UN NUEVO USUARIO (ADMIN)
    // ===================================================

    public String ingresarUsuario(String nombre, String correo, String clave, int idPer) {

        int idEst = 1; // Estado civil por defecto

        String sql = "INSERT INTO tb_usuario (nombre_us, correo_us, clave_us, id_per, id_est) " +
                     "VALUES ('" + nombre + "', '" + correo + "', '" + clave + "', " + idPer + ", " + idEst + ");";

        Conexion con = new Conexion();
        String msg = "Error: No se pudo ejecutar.";

        try {
            msg = con.Ejecutar(sql);
            if (con.getConexion() != null) {
                con.getConexion().close();
            }
        } catch (Exception e) {
            msg = "Error al insertar usuario: " + e.getMessage();
        }

        return msg;
    }

    // ===================================================
    //   MÉTODO PARA LISTAR USUARIOS (REPORTES)
    // ===================================================

    public String reporteUsuarios() {

        String sql = "SELECT id_us, nombre_us, correo_us, id_per FROM tb_usuario";
        Conexion con = new Conexion();
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;

        String tabla = "<table class='table table-striped'>"
                + "<thead>"
                + "<tr>"
                + "<th>ID</th>"
                + "<th>Nombre</th>"
                + "<th>Correo</th>"
                + "<th>Perfil</th>"
                + "<th>Acciones</th>"
                + "</tr>"
                + "</thead>"
                + "<tbody>";

        try {
            cn = con.getConexion();
            st = cn.createStatement();
            rs = st.executeQuery(sql);

            while (rs.next()) {
                tabla += "<tr>"
                        + "<td>" + rs.getInt("id_us") + "</td>"
                        + "<td>" + rs.getString("nombre_us") + "</td>"
                        + "<td>" + rs.getString("correo_us") + "</td>"
                        + "<td>" + rs.getInt("id_per") + "</td>"
                        + "<td>"
                        + "<a href='admin_editarUsuario.jsp?id=" + rs.getInt("id_us")
                        + "' class='btn btn-warning btn-sm'>Editar</a> "
                        + "<a href='admin_eliminarUsuario.jsp?id=" + rs.getInt("id_us")
                        + "' class='btn btn-danger btn-sm'>Eliminar</a>"
                        + "</td>"
                        + "</tr>";
            }

            tabla += "</tbody></table>";

        } catch (Exception e) {
            tabla = "Error al generar reporte: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                System.out.println("Error cerrando conexión en reporteUsuarios: " + e.getMessage());
            }
        }

        return tabla;
    }
    public String eliminarUsuario(String id) {
        String sql = "DELETE FROM tb_usuario WHERE id_us=" + id;
        Conexion con = new Conexion();
        String msg = "Error al eliminar";

        try {
            msg = con.Ejecutar(sql);
            if (con.getConexion() != null) {
                con.getConexion().close();
            }
        } catch (Exception e) {
            msg = "Error al eliminar usuario: " + e.getMessage();
        }

        return msg;
    }
    public Usuario obtenerUsuarioPorId(String id) {
        Usuario u = null;

        String sql = "SELECT * FROM tb_usuario WHERE id_us=" + id;

        Conexion con = new Conexion();
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            cn = con.getConexion();
            st = cn.createStatement();
            rs = st.executeQuery(sql);

            if (rs.next()) {
                u = new Usuario();
                u.setId(rs.getInt("id_us"));
                u.setNombre(rs.getString("nombre_us"));
                u.setCorreo(rs.getString("correo_us"));
                u.setClave(rs.getString("clave_us"));
                u.setPerfil(rs.getInt("id_per"));
            }

        } catch (Exception e) {
            System.out.println("Error obtenerUsuarioPorId: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (st != null) st.close(); } catch (Exception e) {}
            try { if (cn != null) cn.close(); } catch (Exception e) {}
        }

        return u;
    }

    public String actualizarUsuario(String id, String nombre, String correo, String clave, int perfil) {
        String sql = "UPDATE tb_usuario SET "
                + "nombre_us='" + nombre + "', "
                + "correo_us='" + correo + "', "
                + "clave_us='" + clave + "', "
                + "id_per=" + perfil + " "
                + "WHERE id_us=" + id;

        Conexion con = new Conexion();
        String mensaje = "Error al actualizar";

        try {
            mensaje = con.Ejecutar(sql);
            con.getConexion().close();
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }

        return mensaje;
    }

}
