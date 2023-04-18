/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.Canino;
import Modelo.Felino;
import Modelo.Mascota;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author samue
 */
@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class ControladorServlet extends HttpServlet {

    private Controlador controlador = new Controlador();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Controlador</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Controlador at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        switch (accion) {
            case "promedio":
                request.setAttribute("edadPromedio", controlador.calcularEdadPromedio());
                break;
            case "total":
                String tipo = request.getParameter("tipo");
                request.setAttribute(tipo + "Total", controlador.contarMascotas(tipo));
                break;
            case "mascotas":
                String idMascota = request.getParameter("idMascota");
                if (idMascota != null) {
                    request.setAttribute("mascota", controlador.consultarMascota(Integer.parseInt(idMascota)));
                } else {
                    ArrayList<HashMap> respuestaMascotas = new ArrayList<>();
                    for (Mascota mascota : controlador.consultarMascotasDisponibles()) {
                        HashMap hashMascota = new HashMap<>();
                        hashMascota.put("idMascota", mascota.getIdMascota());
                        hashMascota.put("nombre", mascota.getNombre());
                        hashMascota.put("tipo", mascota.getTipo());
                        hashMascota.put("raza", mascota.getRaza());
                        hashMascota.put("color", mascota.getColor());
                        hashMascota.put("edad", (Integer) mascota.getEdad());
                        respuestaMascotas.add(hashMascota);
                    }
                    request.setAttribute("mascotas", respuestaMascotas);
                }
                break;

            default:
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);

        String accion = request.getParameter("accion");
        System.out.println("accion: " + accion);

        Mascota mascota;
        String idMascotaString;

        switch (accion) {
            case "Buscar":
                idMascotaString = request.getParameter("idMascota");
                if (idMascotaString.isBlank()) {
                    request.setAttribute("formError", "Complete todos los campos para buscar una mascota");
                    request.getRequestDispatcher("BuscarMascota.jsp").forward(request, response);
                    return;
                }
                int idMascota = Integer.parseInt(idMascotaString);
                mascota = controlador.consultarMascota(idMascota);

                if (mascota == null) {
                    request.setAttribute("formError", "Id de mascota no encontrada");
                    request.getRequestDispatcher("BuscarMascota.jsp").forward(request, response);
                    return;
                }

                HashMap hashMascota = new HashMap();
                hashMascota.put("idMascota", idMascota);
                hashMascota.put("nombre", mascota.getNombre());
                hashMascota.put("tipo", mascota.getTipo());
                hashMascota.put("raza", mascota.getRaza());
                hashMascota.put("color", mascota.getColor());
                hashMascota.put("edad", mascota.getEdad());

                if (mascota.getTipo().equals("Felino")) {
                    hashMascota.put("libreToxoplasmosis", ((Felino) mascota).isLibreToxoplasmosis());
                } else if (mascota.getTipo().equals("Canino")) {
                    hashMascota.put("nivelEntrenamiento", ((Canino) mascota).getNivelEntrenamiento());
                }

                request.setAttribute("mascota", hashMascota);
                request.getRequestDispatcher("BuscarMascota.jsp").forward(request, response);
                break;
            case "Eliminar":
                idMascotaString = request.getParameter("idMascota");

                System.out.println("idMascotaString: " + idMascotaString);

                if (idMascotaString.isBlank()) {
                    request.setAttribute("formError", "Error al eliminar mascota");
                    response.sendRedirect("index.jsp");
                    return;
                }

                mascota = controlador.consultarMascota(Integer.parseInt(idMascotaString));
                controlador.retirarMascota(mascota);

                response.sendRedirect("index.jsp");
                break;
            case "Crear":
                String nombre = request.getParameter("nombre");
                String tipo = request.getParameter("tipo");
                String raza = request.getParameter("raza");
                String color = request.getParameter("color");
                String edadString = request.getParameter("edad");
                String toxoplasmosisString = request.getParameter("toxoplasmosis");
                String nivelEntrenamientoString = request.getParameter("nivelEntrenamiento");

                if (nombre.isBlank() || tipo == null || raza.isBlank() || color.isBlank() || edadString.isBlank() || (tipo.equals("canino") && nivelEntrenamientoString == null)) {
                    request.setAttribute("formError", "Complete todos los campos para registrar una mascota");
                    request.getRequestDispatcher("CrearMascota.jsp").forward(request, response);
                    return;
                }

                int edad = Integer.parseInt(edadString);

                if (tipo.equals("felino")) {
                    boolean toxoplasmosis = false;
                    if (toxoplasmosisString != null) {
                        toxoplasmosis = toxoplasmosisString.equals("on");
                    }
                    mascota = new Felino(toxoplasmosis, nombre, raza, color, edad);
                } else {
                    int nivelEntrenamiento = Integer.parseInt(nivelEntrenamientoString);
                    mascota = new Canino(nivelEntrenamiento, nombre, raza, color, edad);
                }
                controlador.agregarMascota(mascota);
                response.sendRedirect("index.jsp");
                break;

            default:
                break;

        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
