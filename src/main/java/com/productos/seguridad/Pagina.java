package com.productos.seguridad;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import com.productos.datos.Conexion;
import java.sql.Connection;

public class Pagina {
    private int id;
    private String nombre;
    private String path;

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }

    /**
     * Construye el menú HTML consultando la base de datos.
     */
    public String mostrarMenu(Integer nperfil) {
        String menu = "";
        String sql = "SELECT pag.path_pag, pag.descripcion_pag FROM tb_pagina pag, tb_perfil per, "
                + "tb_perfilpagina pper "
                + "WHERE pag.id_pag=pper.id_pag AND pper.id_per=per.id_per "
                + "AND pper.id_per= " + nperfil;

        Conexion con = new Conexion();
        Connection cn = null; // Objeto Connection
        Statement st = null;  // Objeto Statement
        ResultSet rs = null;  // Objeto ResultSet
        
        try {
            cn = con.getConexion(); // Obtenemos la conexión
            if (cn != null) {
                st = cn.createStatement(); // Creamos el Statement
                rs = st.executeQuery(sql); // Ejecutamos la consulta

                while (rs.next()) {
                    // Aplicamos el estilo de tu <nav>
                    menu += "<a href=\"" + rs.getString("path_pag") + "\">" 
                         + rs.getString("descripcion_pag") + "</a> ";
                }
            } else {
                System.out.println("Error en mostrarMenu: La conexión es nula.");
                menu = "Error: Sin conexión a BD.";
            }
        } catch (SQLException e) {
            System.out.print("Error en mostrarMenu: " + e.getMessage());
            menu = "Error: " + e.getMessage(); // Muestra el error en el menú
        } finally {
            // --- CERRAMOS TODO (MUY IMPORTANTE) ---
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                System.out.print("Error cerrando recursos: " + e.getMessage());
            }
        }
        return menu;
    }
}