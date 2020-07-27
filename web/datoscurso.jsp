<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Estudiante</title>
        <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
        <%!
            // Variables globales (Página)
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idcurso;
            String s_nombre;
            String s_codigo;
            String s_estado;
            String s_horas;
            String s_credito;
            

        %>
    </head>
    <body>
        
        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idcurso = request.getParameter("f_idcurso");
                // Primera parte del modificar
                if (s_accion!=null && s_accion.equals("M1")) {
                    consulta =  "   select nombre, codigo, estado, horas, creditos "
                                + " from curso  "
                                + " where  "
                                + " id_curso =  " + s_idcurso;
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
                            
                        
                    %>    
                <form name="EditarcursoForm" action="datoscurso.jsp" method="GET">
                    <table border="0" align="center">
                        <thead>
                            <tr>
                                <th colspan="2">Editar curso</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Nombres:</td>
                                <td><input type="text" name="f_nombre" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="25" /></td>
                            </tr>
                            <tr>
                                <td>Codigo:</td>
                                <td><input type="text" name="f_codigo" value="<% out.print(rs.getString(2)); %>" maxlength="40" size="25"/></td>
                            </tr>
                            <tr>
                                <td>Estado: </td>
                                <td><input type="text" name="f_estado" value="<% out.print(rs.getString(3)); %>" maxlength="8" size="8" /></td>
                            </tr>
                            <tr>
                                <td>Horas: </td>
                                <td><input type="text" name="f_horas" value="<% out.print(rs.getString(4)); %>" maxlength="12" size="15" /></td>
                            </tr>
                            <tr>
                                <td>Credito: </td>
                                <td><input type="text" name="f_credito" value="<% out.print(rs.getString(5)); %>" maxlength="1" size="2" /></td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <input type="submit" value="Editar" name="f_editar" />
                                    <input type="hidden" name="f_accion" value="M2" />
                                    <input type="hidden" name="f_idcurso" value="<%out.print(s_idcurso);%>" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
                 
                    
                    <%
                        }
                }else{
                // Si no se hace la primera parte del modidicar debe mostrar el 
                // formulario de agregar estudiante

        %>
        <form name="AgregarcursoForm" action="datoscurso.jsp" method="GET">
            <table border="0" align="center" class="ecologico" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Estudiante</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombres:</td>
                        <td><input type="text" name="f_nombre" value="" maxlength="30" size="25" /></td>
                    </tr>
                    <tr>
                        <td>Codigo:</td>
                        <td><input type="text" name="f_codigo" value="" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Estado </td>
                        <td><input type="text" name="f_estado" value=""maxlength="8" size="8" /></td>
                    </tr>
                    <tr>
                        <td>Horas: </td>
                        <td><input type="text" name="f_horas" value="" maxlength="12" size="15" /></td>
                    </tr>
                    <tr>
                        <td>Credito: </td>
                        <td><input type="text" name="f_credito" value="" maxlength="1" size="2" /></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Agregar" name="f_agregar" />
                            <input type="hidden" name="f_accion" value="C" />
                            
                        
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <%
            }
        %>
        
        <table border="1" cellpadding ="2" align = "center" class="ecologico" style="margin: auto; display: table" >
            <thead>
                <tr>
                    <th colspan="8">
                        Datos Curso
                    </th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Código</th>
                    <th>Estado</th>
                    <th>Horas</th>
                    <th>Crédito</th>
                    <th colspan="2">Acciones</th>

                </tr>
            </thead>

        
        <%        
                
                
                if (s_accion !=null) {
                    
                    // Ejecutar la eliminación de estudiantes
                    if (s_accion.equals("E")) {
                            consulta =    " delete from curso "
                                        + " where  "
                                        + " id_curso = " + s_idcurso +" ; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    // Sino se elimina registros de estudiantes, 
                    // Pregunta si se va a REGISTRAR UN NUEVO ESTUDIANTE
                    }else if(s_accion.equals("C")){
                            s_nombre = request.getParameter("f_nombre");
                            s_codigo = request.getParameter("f_codigo");
                            s_estado = request.getParameter("f_estado");
                            s_horas = request.getParameter("f_horas");
                            s_credito = request.getParameter("f_credito");
                            
                            consulta =    " insert into "
                                        + " curso (nombre, codigo, estado, horas, credito)"
                                        + " values('"+ s_nombre +"','"+ s_codigo +"','"+ s_estado +"','"+ s_horas+"','"+ s_credito+"');  ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    // Si no se está creando o eliminando registro de estudiante
                    // Pregunta si va a hacer la MODIFICACIÓN DE ESTUDIANTES - Parte 2
                    }else if (s_accion.equals("M2")) {
                            s_nombre = request.getParameter("f_nombre");
                            s_codigo = request.getParameter("f_codigo");
                            s_estado = request.getParameter("f_estado");
                            s_horas= request.getParameter("f_horas");
                            s_credito = request.getParameter("f_credito");
                            consulta =  "   update curso  "
                                        + " set  "
                                        + " nombre = '"+ s_nombre +"', "
                                        + " codigo = '" + s_codigo + "', "
                                        + " estado = '" + s_estado + "', "
                                        + " horas = '" + s_horas + "', "
                                        + " credito = '" + s_credito + "'  "
                                        + " where  "
                                        + " id_curso = " + s_idcurso + "; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    }
                    
                }
                
                // Listar los estudiantes de la TABLA ESTUDIANTE
                consulta= " Select id_curso, nombre, codigo, estado, horas, credito "
                        + " from curso ";
                //out.print(consulta);
                pst = cn.prepareStatement(consulta);
                rs = pst.executeQuery();
                int num = 0;
                String ide;
                while (rs.next()) {    
                    ide = rs.getString(1);
                    num++;
                    %>
                    <tr>
                        <td><%out.print(num);%></td>
                        <td><%out.print(rs.getString(2));%></td>
                        <td><%out.print(rs.getString(3));%></td>
                        <td><%out.print(rs.getString(4));%></td>
                        <td><%out.print(rs.getString(5));%></td>
                        <td><%out.print(rs.getString(6));%></td>
                        <td><a href="datoscurso.jsp?f_accion=E&f_idcurso=<%out.print(ide);%>">Eliminar</a></td>
                        <td><a href="datoscurso.jsp?f_accion=M1&f_idcurso=<%out.print(ide);%>">Editar</a></td>
                        
                    </tr>                    
                    <%
                    }
                    // Se cierra todas las conexiones
                    rs.close();
                    pst.close();
                    cn.close();
            }catch(Exception e){
                out.print("Error SQL");
            }
        
        %>
        </table>
    </body>
</html>

