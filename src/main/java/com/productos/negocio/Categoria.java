package com.productos.negocio;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import com.productos.datos.Conexion;

public class Categoria {
    
    /**
     * Genera el HTML de las <option> para un dropdown,
     * seleccionando la categoría correcta.
     */
    public String getCategoriasOptions(int idCategoriaSeleccionada) {
        String options = "";
        String sql = "SELECT id_cat, descripcion_cat FROM tb_categoria ORDER BY descripcion_cat";
        
        Conexion con = new Conexion();
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            cn = con.getConexion();
            if (cn != null) {
                st = cn.createStatement();
                rs = st.executeQuery(sql);
                
                // Opción por defecto
                options += "<option value=\"\">Seleccione una categoría</option>";
                
                while (rs.next()) {
                    int idCat = rs.getInt("id_cat");
                    String descripcion = rs.getString("descripcion_cat");
                    String selected = "";
                    
                    if (idCat == idCategoriaSeleccionada) {
                        selected = "selected";
                    }
                    
                    options += "<option value=\"" + idCat + "\" " + selected + ">" + descripcion + "</option>";
                }
            } else {
                options = "<option value=\"\">Error: No hay conexión</option>";
            }
        } catch (Exception e) {
            System.out.println("Error en getCategoriasOptions: " + e.getMessage());
            options = "<option value=\"\">Error: " + e.getMessage() + "</option>";
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {}
        }
        
        return options;
    }
}