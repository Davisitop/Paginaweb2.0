<%@ page import="java.sql.*, com.productos.datos.Conexion" %>
<%@ page contentType="text/html; charset=UTF-8" %><%@ page import="com.productos.seguridad.Bitacora" %>


<%
    System.out.println("===== Iniciando registro de cliente =====");

    String nombre = request.getParameter("txtNombre");
    String cedula = request.getParameter("txtCedula");
    String correo = request.getParameter("txtCorreo");
    String clave = request.getParameter("txtClave");
    String estado = request.getParameter("cmbEstado");

    System.out.println("Datos recibidos:");
    System.out.println("Nombre: " + nombre);
    System.out.println("Cedula: " + cedula);
    System.out.println("Correo: " + correo);
    System.out.println("Clave: " + clave);
    System.out.println("Estado: " + estado);

    Conexion cn = new Conexion();
    Connection con = cn.getConexion();
    String mensaje = "";

    try {
        if (con != null) {
            System.out.println("✅ Conexión establecida con la base de datos");

            int idEstado = 1;
            try { idEstado = Integer.parseInt(estado); } catch (Exception ex) {
                System.out.println("⚠️ No se pudo convertir el estado, usando valor 1");
            }

            String sql = "INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, 1);
            ps.setInt(2, idEstado);
            ps.setString(3, nombre);
            ps.setString(4, cedula);
            ps.setString(5, correo);
            ps.setString(6, clave);

            System.out.println("📝 Ejecutando SQL: " + sql);
            int r = ps.executeUpdate();
            mensaje = (r > 0) ? "Registro exitoso" : "Error al registrar";

            ps.close();
            con.close();
            System.out.println("✅ Registro finalizado: " + mensaje);
        } else {
            mensaje = "Error de conexión.";
            System.out.println("❌ No se pudo conectar a la base de datos");
        }
    } catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
        System.out.println("❌ Excepción: " + e.getMessage());
        e.printStackTrace();
    }

    out.println("<script>alert('" + mensaje + "'); window.location='login.jsp';</script>");
%>
