<%-- 
    Document   : index
    Created on : 16/04/2023, 12:09:19 p. m.
    Author     : samuel
--%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="/Controlador?accion=promedio" />
<jsp:include page="/Controlador?accion=total&tipo=felino" />
<jsp:include page="/Controlador?accion=total&tipo=canino" />
<jsp:include page="/Controlador?accion=mascotas" />


<!DOCTYPE html>
<html>
    <head>
        <title>Control de Mascotas</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    </head>
    <body class="p-3">
        <h1 class="fs-1 text-center">Control de Mascotas</h1>
        <section class="container mt-5">
            <div class="row">
                <div class="col">
                    Total Felinos:
                    ${felinoTotal}
                </div>
                <div class="col">
                    Total Caninos:
                    ${caninoTotal}
                </div>
                <div class="col">
                    Edad Promedio:
                    ${edadPromedio}
                </div>
                <div class="col d-grid gap-2">
                    <a type="button" class="btn btn-primary" href="./CrearMascota.jsp">
                        Agregar Mascota
                    </a>
                    <a type="button" class="btn btn-outline-primary" href="./BuscarMascota.jsp">
                        Buscar Mascota
                    </a>
                </div>
            </div>
        </section>
        <section class="container mt-5">
            <table class="table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre</th>
                        <th>Tipo</th>
                        <th>Raza</th>
                        <th>Color</th>
                        <th>Edad</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Contenido -->
                    <%
                        ArrayList<HashMap> mascotas = (ArrayList<HashMap>) request.getAttribute("mascotas");
                        for (HashMap mascota : mascotas) {
                            out.print("<tr>");
                            out.print("<td>"+mascota.get("idMascota")+"</td>");
                            out.print("<td>"+mascota.get("nombre")+"</td>");           
                            out.print("<td>"+mascota.get("tipo")+"</td>");
                            out.print("<td>"+mascota.get("raza")+"</td>");
                            out.print("<td>"+mascota.get("color")+"</td>");
                            out.print("<td>"+mascota.get("edad")+"</td>");
                            out.print("</tr>");
                        }
                    %>
                    <!-- Contenido -->
                </tbody>  
            </table>
        </section>
    </body>
</html>
