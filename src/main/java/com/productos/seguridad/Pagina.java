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
     * Construye el menú HTML adaptado para la Navbar de Bootstrap.
     * Devuelve elementos <li> en lugar de solo <a>.
     */
    public String mostrarMenu(Integer nperfil) {
        String menu = "";
        String sql = "SELECT pag.path_pag, pag.descripcion_pag FROM tb_pagina pag, tb_perfil per, "
                + "tb_perfilpagina pper "
                + "WHERE pag.id_pag=pper.id_pag AND pper.id_per=per.id_per "
                + "AND pper.id_per= " + nperfil;

        Conexion con = new Conexion();
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            cn = con.getConexion();
            if (cn != null) {
                st = cn.createStatement();
                rs = st.executeQuery(sql);

                while (rs.next()) {
                    // --- CAMBIO AQUÍ ---
                    // Envolvemos el enlace en un <li> con la clase 'nav-item'
                    // Y al enlace <a> le ponemos la clase 'nav-link'
                    menu += "<li class='nav-item'>"
                          + "<a class='nav-link' href='" + rs.getString("path_pag") + "'>" 
                          + rs.getString("descripcion_pag") + "</a>"
                          + "</li>";
                }
            } else {
                System.out.println("Error en mostrarMenu: La conexión es nula.");
                // Opcional: devolver un li de error si quieres verlo en pantalla
                menu = "<li class='nav-item'><span class='nav-link text-danger'>Sin conexión</span></li>";
            }
        } catch (SQLException e) {
            System.out.print("Error en mostrarMenu: " + e.getMessage());
            menu = "<li class='nav-item'><span class='nav-link text-danger'>Error DB</span></li>";
        } finally {
            // Cerrar recursos
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