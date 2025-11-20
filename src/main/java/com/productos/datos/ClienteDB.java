package com.productos.datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Types;

public class ClienteDB {

    public String registrarCliente(String nombre, String cedula, String estado, String residencia,
                                   String fecha, String color, String correo, String clave, String foto) {
        String mensaje = "";

        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();

            String sql = "INSERT INTO cliente(nombre, cedula, estado_civil, residencia, fecha_nacimiento, color_favorito, correo, clave, foto) VALUES (?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, cedula);
            ps.setString(3, estado);
            ps.setString(4, residencia);

            if (fecha != null && !fecha.isEmpty()) {
                ps.setDate(5, java.sql.Date.valueOf(fecha + "-01"));
            } else {
                ps.setNull(5, Types.DATE);
            }

            ps.setString(6, color);
            ps.setString(7, correo);
            ps.setString(8, clave);
            ps.setString(9, foto);

            int filas = ps.executeUpdate();
            mensaje = (filas > 0) ? "Cliente registrado correctamente." : "No se pudo registrar el cliente.";

            ps.close();
            con.close();

        } catch (Exception e) {
            mensaje = "Error al registrar cliente: " + e.getMessage();
        }

        return mensaje;
    }
}
