package com.productos.seguridad;

import java.sql.ResultSet;
import com.productos.datos.Conexion; // Asegúrate que importe tu clase Conexion

public class Producto {
    private Integer id;
    private Integer perfil;
    private int estadoCivil;
    private String cedula;
    private String nombre;
    private String correo;
    private String clave;

    // --- Getters y Setters ---
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
    // --- Fin de Getters y Setters ---

    public boolean verificarUsuario(String ncorreo, String nclave) {
        boolean respuesta = false;
        // IMPORTANTE: Esta consulta es vulnerable a Inyección SQL,
        // pero sigue la guía de la práctica.
        String sentencia = "SELECT * FROM tb_usuario WHERE correo_us='" + ncorreo +
                "' AND clave_us='" + nclave + "';";

        try {
            ResultSet rs;
            Conexion clsCon = new Conexion();
            rs = clsCon.Consulta(sentencia);
            if (rs.next()) {
                respuesta = true;
                this.setCorreo(ncorreo);
                this.setClave(nclave);
                Integer nperfil = (Integer) (rs.getObject("id_per")); // Columna id_per
                this.setPerfil(nperfil);
                this.setNombre(rs.getString("nombre_us")); // Columna nombre_us
            } else {
                respuesta = false;
            }
            rs.close();
            clsCon.getConexion().close(); // Cierra la conexión
        } catch (Exception ex) {
            System.out.println("Error en verificarUsuario: " + ex.getMessage());
        }
        return respuesta;
    }
    public String ingresarUsuario(String nombre, String correo, String clave, int idPer) {
        // Asignamos id_est = 1 (casado) por defecto, como en la práctica.
        int idEst = 1; 
        
        String sql = "INSERT INTO tb_usuario (nombre_us, correo_us, clave_us, id_per, id_est) "
                + "VALUES ('" + nombre + "', '" + correo + "', '" + clave + "', " + idPer + ", " + idEst + ");";
        
        Conexion con = new Conexion();
        String msg = "Error: No se pudo ejecutar.";
        try {
            msg = con.Ejecutar(sql);
            con.getConexion().close();
        } catch (Exception e) {
            msg = "Error al insertar usuario: " + e.getMessage();
        }
        return msg;
    }
}