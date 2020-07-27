<%-- 
    Document   : Carrera
    Created on : 27/07/2020, 02:05:53 AM
    Author     : DavidGuiaHurtado
--%>
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
            String s_idcarrera;
            String s_nomcarrera;
            String s_estado;
            String s_cordinador;
             String s_semestres;
              
             

        %>
    </head>
    <body>
        
        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idcarrera = request.getParameter("f_idcarrera");
                // Primera parte del modificar
                if (s_accion!=null && s_accion.equals("M1")) {
                    consulta =  "   select idcarrera, nomcarreara, estado,cordinador, drmrdtres "
                                + " from carrera  "
                                + " where  "
                                + " id_carrera =  " + s_idcarrera;
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
                            
                        
                    %>    
                <form name="EditarcarreraForm" action="datoscarrera.jsp" method="GET">
                    <table border="0" align="center">
                        <thead>
                            <tr>
                                <th colspan="2">Editar curso</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Nombre de carrera:</td>
                                <td><input type="text" name="f_nomcarrera" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="25" /></td>
                            </tr>
                            <tr>
                                <td>Cordinador:</td>
                                <td><input type="text" name="f_cordinador" value="<% out.print(rs.getString(2)); %>" maxlength="40" size="25"/></td>
                            </tr>
                            <tr>
                                <td>Estado: </td>
                                <td><input type="text" name="f_estado" value="<% out.print(rs.getString(3)); %>" maxlength="8" size="8" /></td>
                            </tr>
                            <tr>
                                <td>Semestre: </td>
                                <td><input type="text" name="f_semestres" value="<% out.print(rs.getString(4)); %>" maxlength="12" size="15" /></td>
                            </tr>
                           
                            <tr align="center">
                                <td colspan="2">
                                    <input type="submit" value="Editar" name="f_editar" />
                                    <input type="hidden" name="f_accion" value="M2" />
                                    <input type="hidden" name="f_idcarrera" value="<%out.print(s_idcarrera);%>" />
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
        <form name="AgregarcarreraForm" action="datoscarrera.jsp" method="GET">
            <table border="0" align="center" class="ecologico" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Carrera</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombre de Carrera:</td>
                        <td><input type="text" name="f_nombre" value="" maxlength="30" size="25" /></td>
                    </tr>
                    <tr>
                        <td>Cordinador:</td>
                        <td><input type="text" name="f_cordinador" value="" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Estado </td>
                        <td><input type="text" name="f_estado" value=""maxlength="8" size="8" /></td>
                    </tr>
                    <tr>
                        <td>Semestre: </td>
                        <td><input type="text" name="f_semestres" value="" maxlength="12" size="15" /></td>
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
                    <th>Cordinador</th>
                    <th>Estado</th>
                    <th>Semestre</th>
                  
                    <th colspan="2">Acciones</th>

                </tr>
            </thead>

        
        <%        
                
                
                if (s_accion !=null) {
                    
                    // Ejecutar la eliminación de estudiantes
                    if (s_accion.equals("E")) {
                            consulta =    " delete from curso "
                                        + " where  "
                                        + " id_curso = " + s_idcarrera +" ; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    // Sino se elimina registros de estudiantes, 
                    // Pregunta si se va a REGISTRAR UN NUEVO ESTUDIANTE
                    }else if(s_accion.equals("C")){
                            s_nomcarrera = request.getParameter("f_nombcarrera");
                            s_cordinador = request.getParameter("f_cordinador");
                            s_estado = request.getParameter("f_estado");
                            s_semestres = request.getParameter("f_semestres");
                           
                            
                            consulta =    " insert into "
                                        + " curso (nombre, semestre, estado, cordinador )"
                                        + " values('"+ s_nomcarrera +"','"+ s_semestres +"','"+ s_estado +"','"+ s_cordinador +"',' ');  ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    // Si no se está creando o eliminando registro de estudiante
                    // Pregunta si va a hacer la MODIFICACIÓN DE ESTUDIANTES - Parte 2
                    }else if (s_accion.equals("M2")) {
                            s_nomcarrera = request.getParameter("f_nomcarrera");
                            s_cordinador = request.getParameter("f_cordinador");
                            s_estado = request.getParameter("f_estado");
                             s_semestres = request.getParameter("f_semestres ");
                           
                            consulta =  "   update curso  "
                                        + " set  "
                                        + " nombre = '"+ s_nomcarrera +"', "
                                        + " codigo = '" + s_cordinador + "', "
                                        + " estado = '" + s_estado + "', "
                                        + " horas = '" + s_semestres + "', "
                                        + " where  "
                                        + " id_carrera = " + s_idcarrera + "; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    }
                    
                }
                
                
                consulta= " Select id_carrera, nomcarrera, cordinador, estado, semestre  "
                        + " from carrrera ";
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
                        <td><a href="datoscarrera.jsp?f_accion=E&f_idcarrera=<%out.print(ide);%>">Eliminar</a></td>
                        <td><a href="datoscarrera.jsp?f_accion=M1&f_idcarrera=<%out.print(ide);%>">Editar</a></td>
                        
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

