<%@ page import="java.sql.*, com.productos.datos.Conexion" %>
<%@ page contentType="text/html; charset=UTF-8" %><%@ page import="com.productos.seguridad.Bitacora" %>

<%! 
    // --- FUNCIÓN JAVA PARA VALIDAR CÉDULA ECUATORIANA ---
    public boolean validarCedula(String cedula) {
        if (cedula == null || cedula.length() != 10) return false;
        try {
            int provincia = Integer.parseInt(cedula.substring(0, 2));
            if ((provincia < 1 || provincia > 24) && provincia != 30) return false;
            
            int tercerDigito = Integer.parseInt(cedula.substring(2, 3));
            if (tercerDigito >= 6) return false;

            int[] coeficientes = {2, 1, 2, 1, 2, 1, 2, 1, 2};
            int suma = 0;
            for (int i = 0; i < 9; i++) {
                int valor = Character.getNumericValue(cedula.charAt(i)) * coeficientes[i];
                if (valor >= 10) valor -= 9;
                suma += valor;
            }
            int digitoVerificador = (int) (Math.ceil((double)suma / 10) * 10) - suma;
            if (digitoVerificador == 10) digitoVerificador = 0;
            
            return digitoVerificador == Character.getNumericValue(cedula.charAt(9));
        } catch (NumberFormatException e) {
            return false;
        }
    }
%>

<%
    System.out.println("===== Iniciando registro de cliente =====");
    String nombre = request.getParameter("txtNombre");
    String cedula = request.getParameter("txtCedula");
    String correo = request.getParameter("txtCorreo");
    String clave = request.getParameter("txtClave");
    String estado = request.getParameter("cmbEstado");

    String mensaje = "";
    
    // --- VALIDACIÓN DE BACKEND ---
    if (!validarCedula(cedula)) {
        mensaje = "Error: La cédula ingresada no es válida en el sistema ecuatoriano.";
    } else {
        // Si la cédula es correcta, procedemos a guardar
        Conexion cn = new Conexion();
        Connection con = cn.getConexion();

        try {
            if (con != null) {
                int idEstado = 1;
                try { idEstado = Integer.parseInt(estado); } catch (Exception ex) { }

                String sql = "INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                
                ps.setInt(1, 2); // Perfil Cliente
                ps.setInt(2, idEstado);
                ps.setString(3, nombre);
                ps.setString(4, cedula);
                ps.setString(5, correo);
                ps.setString(6, clave);

                int r = ps.executeUpdate();
                
                if (r > 0) {
                    mensaje = "Registro exitoso. ¡Ahora puedes iniciar sesión!";
                    Bitacora b = new Bitacora();
                    b.registrar(0, "REGISTRO", "Nuevo cliente registrado: " + correo);
                } else {
                    mensaje = "Error al registrar en base de datos.";
                }

                ps.close();
                con.close();
            } else {
                mensaje = "Error de conexión con la base de datos.";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            e.printStackTrace();
        }
    }

    // Respuesta al usuario
    out.println("<script>");
    out.println("alert('" + mensaje + "');");
    if (mensaje.startsWith("Registro exitoso")) {
        out.println("window.location='login.jsp';");
    } else {
        out.println("window.history.back();");
    }
    out.println("</script>");
%>