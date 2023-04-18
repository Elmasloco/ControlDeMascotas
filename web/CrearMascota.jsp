
<%-- 
    Document   : CrearMascota
    Created on : 16/04/2023, 11:42:27 a. m.
    Author     : samuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear Mascota</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    </head>
    <body class="p-3">
        <h1 class="fs-1 text-center">Registro de mascotas</h1>
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
        <form class="container" action="Controlador" method="POST">
            <div class="form-floating mb-3">
                <input class="form-control" name="nombre" />
                <label for="nombre">Nombre de la mascota</label>
            </div>
            <div class="form-floating mb-3">
                <select class="form-select" name="tipo" onchange="mostrarInput(this)">
                    <option selected disabled>Seleccione un tipo de mascota</option>
                    <option value="canino">
                        Canino
                    </option>
                    <option value="felino">
                        Felino
                    </option>
                </select>
                <label for="tipo">Tipo de mascota</label>
            </div>
            <div class="form-floating mb-3">
                <input class="form-control" name="raza" />
                <label for="raza">Raza de la mascota</label>
            </div>
            <div class="form-floating mb-3">
                <input class="form-control" name="color" />
                <label for="color">Color de la mascota</label>
            </div>
            <div class="form-floating mb-3">
                <input type="number" class="form-control" name="edad" />
                <label for="edad">Edad de la mascota</label>
            </div>
            <div class="form-check form-switch" id="toxoplasmosisSeccion" style="display: none">
                <input class="form-check-input" type="checkbox" role="switch" name="toxoplasmosis">
                <label class="form-check-label" for="toxoplasmosis">
                    Libre de toxoplasmosis
                </label>
            </div>            
            <div id="nivelEntrenamientoSeccion" style="display: none">
                <div>Nivel de entrenamiento</div>
                <%
                    for(int nivel = 1; nivel <= 10; nivel++){
                        out.print("<div class=\"form-check form-check-inline\">");
                        out.print("<input class=\"form-check-input\" type=\"radio\" name=\"nivelEntrenamiento\" id=\"nive1"+nivel+"\" value=\""+nivel+"\">");
                        out.print("<label class=\"form-check-label\" for=\"nivel"+nivel+"\">"+nivel+"</label>");
                        out.print("</div>");
                    }
                %>
            </div>
            <a type="button" class="btn btn-outline-danger" href="./index.jsp">Cancelar</a>
            <input class=" btn btn-outline-primary" type="submit" name="accion" value="Crear" />
        </form>
        <script>
            function mostrarInput(elemento) {
                let index = elemento.selectedIndex;
                let opcion = elemento.options[index].value;
                if (opcion === "felino") {
                    document.getElementById("toxoplasmosisSeccion").style.display = "block";
                    document.getElementById("nivelEntrenamientoSeccion").style.display = "none";
                } else if (opcion === "canino") {
                    document.getElementById("toxoplasmosisSeccion").style.display = "none";
                    document.getElementById("nivelEntrenamientoSeccion").style.display = "block";
                }
            }
        </script>
    </body>
</html>
