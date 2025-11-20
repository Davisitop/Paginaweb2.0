package com.productos.negocio;

import java.sql.ResultSet;
import java.sql.SQLException;
import com.productos.datos.Conexion;
import java.sql.Connection;
import java.sql.Statement;

public class Producto {

    /**
     * Ingresa un nuevo producto (sin foto).
     */
    public String ingresarProducto(int idCat, String nombre, int cantidad, double precio) {
        String sql = "INSERT INTO tb_producto (id_cat, nombre_pr, cantidad_pr, precio_pr) "
                + "VALUES (" + idCat + ", '" + nombre + "', " + cantidad + ", " + precio + ");";
        Conexion con = new Conexion();
        String msg = "Error: No se pudo ejecutar.";
        try {
            msg = con.Ejecutar(sql);
            if(con.getConexion() != null) {
                 con.getConexion().close();
            }
        } catch (Exception e) {
             msg = "Error al insertar producto: " + e.getMessage();
        }
        return msg;
    }

    /**
     * Genera el reporte de productos en una tabla HTML con Bootstrap.
     */
    public String reporteProducto() {
        String sql = "SELECT pr.id_pr, pr.nombre_pr, cat.descripcion_cat, pr.cantidad_pr, pr.precio_pr "
                + "FROM tb_producto pr, tb_categoria cat WHERE pr.id_cat=cat.id_cat";
        Conexion con = new Conexion();
        String tabla = "<table class=\"table table-striped table-hover\">"
                + "<thead><tr>"
                + "<th scope=\"col\">ID</th>"
                + "<th scope=\"col\">Descripción</th>"
                + "<th scope=\"col\">Categoría</th>"
                + "<th scope=\"col\">Cantidad</th>"
                + "<th scope=\"col\">Precio</th>"
                + "<th scope=\"col\">Acciones</th>"
                + "</tr></thead>"
                + "<tbody>";

        ResultSet rs = null;
        Connection cn = null;
        Statement st = null;
        
        try {
            cn = con.getConexion();
            if (cn != null) {
                st = cn.createStatement();
                rs = st.executeQuery(sql); // Usamos executeQuery para SELECT
                while (rs.next()) {
                    tabla += "<tr>"
                            + "<th scope=\"row\">" + rs.getInt(1) + "</th>"
                            + "<td>" + rs.getString(2) + "</td>"
                            + "<td>" + rs.getString(3) + "</td>"
                            + "<td>" + rs.getInt(4) + "</td>"
                            + "<td>" + rs.getDouble(5) + "</td>"
                            + "<td>" // Botones de acción
                            + "<a href=\"actualizar.jsp?id=" + rs.getInt(1) + "\" class=\"btn btn-sm btn-warning\">Modificar</a> "
                            + "<a href=\"eliminar.jsp?id=" + rs.getInt(1) + "\" class=\"btn btn-sm btn-danger\">Eliminar</a>"
                            + "</td>"
                            + "</tr>";
                }
            } else {
                tabla = "Error: No se pudo conectar a la base de datos.";
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
            tabla = "Error al consultar: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                System.out.print("Error cerrando recursos: " + e.getMessage());
            }
        }
        tabla += "</tbody></table>";
        return tabla;
    }

    /**
     * Busca un producto por ID para mostrar en la pág de eliminación/actualización.
     */
    public String buscarProductold(String id) {
        String sentencia = "SELECT nombre_pr, precio_pr FROM tb_producto WHERE id_pr=" + id;
        Conexion con = new Conexion();
        ResultSet rs = null;
        String resultado = "<table class=\"table table-info\">"
                + "<thead><tr><th>Descripción</th><th>Precio</th></tr></thead><tbody>";
        
        Connection cn = null;
        Statement st = null;
        
        try {
            cn = con.getConexion();
            if (cn != null) {
                st = cn.createStatement();
                rs = st.executeQuery(sentencia);
                while (rs.next()) {
                    resultado += "<tr><td>" + rs.getString(1) + "</td>"
                            + "<td>" + rs.getDouble(2) + "</td></tr>";
                }
            } else {
                resultado = "Error: No se pudo conectar.";
            }
            resultado += "</tbody></table>";
        } catch (SQLException e) {
            System.out.print(e.getMessage());
            resultado = "Error al buscar: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                System.out.print("Error cerrando recursos: " + e.getMessage());
            }
        }
        return resultado;
    }

    /**
     * Elimina un producto de la base de datos.
     */
    public String eliminarProducto(String id) {
        String sql = "DELETE FROM tb_producto WHERE id_pr=" + id;
        Conexion con = new Conexion();
        String msg = "Error: No se pudo ejecutar.";
        try {
            msg = con.Ejecutar(sql);
            if(con.getConexion() != null) {
                 con.getConexion().close();
            }
        } catch (Exception e) {
            msg = "Error al eliminar producto: " + e.getMessage();
        }
        return msg;
    }
    
    /**
     * Actualiza un producto existente en la base de datos.
     */
    public String actualizarProducto(int id, String nombre, int idCat, int cantidad, double precio) {
        String sql = "UPDATE tb_producto SET "
                + "nombre_pr = '" + nombre + "', "
                + "id_cat = " + idCat + ", "
                + "cantidad_pr = " + cantidad + ", "
                + "precio_pr = " + precio + " "
                + "WHERE id_pr = " + id;
        
        Conexion con = new Conexion();
        String msg = "Error: No se pudo ejecutar.";
        try {
            msg = con.Ejecutar(sql);
            if(con.getConexion() != null) {
                 con.getConexion().close();
            }
        } catch (Exception e) {
            msg = "Error al actualizar producto: " + e.getMessage();
        }
        return msg;
    }
    public ResultSet buscarProductoById(String id) {
        String sql = "SELECT id_pr, nombre_pr, id_cat, cantidad_pr, precio_pr "
                   + "FROM tb_producto WHERE id_pr=" + id;

        Conexion con = new Conexion();
        ResultSet rs = null;
        try {
            rs = con.Consulta(sql);
        } catch (Exception e) {
            System.out.println("Error buscarProductoById: " + e.getMessage());
        }
        return rs;
    }
}