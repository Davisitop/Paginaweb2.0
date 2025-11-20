package com.productos.datos;
import com.productos.datos.Conexion;
import java.sql.*;

public class Main {
    public static void main(String[] args) {
        Conexion conexion = new Conexion(); // Crear objeto y abrir conexión
        
        if (conexion.getConexion() != null) {
            System.out.println("✅ Conexión establecida correctamente con la base de datos.");
        } else {
            System.out.println("❌ No se pudo establecer la conexión.");
            return;
        }

        // Ejecutar una consulta simple de prueba
        try {
            ResultSet rs = conexion.Consulta("SELECT NOW();"); // Consulta para verificar conexión
            if (rs != null && rs.next()) {
                System.out.println("🕒 Fecha y hora actual del servidor PostgreSQL: " + rs.getString(1));
            } else {
                System.out.println("⚠️ No se obtuvieron resultados de la consulta.");
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        }

        // Cerrar la conexión al final
        try {
            conexion.getConexion().close();
            System.out.println("🔒 Conexión cerrada correctamente.");
        } catch (SQLException e) {
            System.out.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
}
