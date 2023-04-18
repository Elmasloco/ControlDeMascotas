<%-- 
    Document   : BuscarMascota
    Created on : 16/04/2023, 11:42:39 a. m.
    Author     : samuel
--%>
<%@page import="java.util.HashMap" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buscar mascota</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    </head>
    <body class="p-5">
        <h1 class="fs-4 text-left">Ingrese el ID de la mascota</h1>
        <% Object formError = request.getAttribute("formError"); %>
        <% if(formError != null) { %>
        <div class="row mt-3">
            <div class="col-4"></div>
            <div class="col-4 alert alert-danger" role="alert">
                <%= ""+formError %>
            </div>
            <div class="col-4"></div>
        </div>
        <% } %>
        <form class="form-floating input-group mb-3" action="Controlador" method="POST">
            <input class="form-control" name="idMascota" id="idMascota" />
            <label for="idMascota">ID de la mascota</label>
            <input class="btn-lg btn btn-outline-info" type="submit" name="accion" value="Buscar"/>
        </form>

        <% HashMap mascota = (HashMap) request.getAttribute("mascota");
           if(mascota != null) { %>
        <div class="card container mt-4 col-lg-4" style="width: 45rem;">
            <ul class="list-group list-group-flush"> 
                <li class="list-group-item">ID: ${mascota["idMascota"]}</li>
                <li class="list-group-item">Nombre: ${mascota["nombre"]}</li>
                <li class="list-group-item">Raza: ${mascota["raza"]}</li>
                <li class="list-group-item">Color: ${mascota["color"]}</li>
                <li class="list-group-item">Edad: ${mascota["edad"]}</li>
                <li class="list-group-item">Tipo: ${mascota["tipo"]}</li>
                    <% if(mascota.get("tipo").equals("Felino")){ %>
                <li class="list-group-item">Libre de Toxoplasmosis: 
                    <% if(mascota.get("libreToxoplasmosis").toString().equals("true")) { %>
                    Si
                    <%  } else { %>
                    No
                    <%  } %>
                </li>
                <% }else if(mascota.get("tipo").equals("Canino")){ %>
                <li class="list-group-item">Nivel de entrenamiento: ${mascota["nivelEntrenamiento"]}</li>
                    <% } %>
            </ul>            
        </div>
        <% } %>

        <form class="text-center p-4" action="Controlador" method="POST">
            <a type="button" class="btn btn-outline-danger" href="./index.jsp">Cancelar</a>
            <%  if(mascota != null) { %>
            <input hidden="true" name="idMascota" value=${mascota["idMascota"]} />
            <input class="btn btn-danger" type="submit" name="accion" value="Eliminar"/>
            <% } %>
        </form>
    </body>
</html>
