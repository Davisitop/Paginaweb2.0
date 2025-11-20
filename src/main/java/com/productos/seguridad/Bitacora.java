package com.productos.seguridad;

import com.productos.datos.Conexion;
import java.sql.*;

public class Bitacora {

    /**
     * Guarda un registro en la bitácora.
     */
    public void registrar(int idUsuario, String accion, String detalle) {

        String sql = "INSERT INTO tb_bitacora(id_usuario, accion, detalle, fecha) "
                   + "VALUES(" + idUsuario + ", '" + accion + "', '" + detalle + "', NOW())";

        Conexion con = new Conexion();

        try {
            con.Ejecutar(sql);

            if (con.getConexion() != null) {
                con.getConexion().close();
            }

        } catch (Exception e) {
            System.out.println("Error Bitacora.registrar: " + e.getMessage());
        }
    }

    /**
     * Retorna una tabla HTML con el contenido de la bitácora.
     */
    public String reporteBitacora() {

        String html = "<table class='table table-striped table-hover'>"
                + "<thead class='table-dark'>"
                + "<tr>"
                + "<th>ID</th>"
                + "<th>Usuario</th>"
                + "<th>Acción</th>"
                + "<th>Detalle</th>"
                + "<th>Fecha</th>"
                + "</tr></thead><tbody>";

        Conexion con = new Conexion();
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;

        try {

            cn = con.getConexion();
            st = cn.createStatement();

            // Columnas reales de la tabla
            rs = st.executeQuery(
                    "SELECT id_bit, id_usuario, accion, detalle, fecha " +
                    "FROM tb_bitacora ORDER BY fecha DESC"
            );

            while (rs.next()) {
                html += "<tr>"
                        + "<td>" + rs.getInt("id_bit") + "</td>"
                        + "<td>" + rs.getInt("id_usuario") + "</td>"
                        + "<td>" + rs.getString("accion") + "</td>"
                        + "<td>" + rs.getString("detalle") + "</td>"
                        + "<td>" + rs.getTimestamp("fecha") + "</td>"
                        + "</tr>";
            }

        } catch (Exception e) {
            html = "Error al consultar bitácora: " + e.getMessage();

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (st != null) st.close(); } catch (Exception e) {}
            try { if (cn != null) cn.close(); } catch (Exception e) {}
        }

        html += "</tbody></table>";
        return html;
    }
}
