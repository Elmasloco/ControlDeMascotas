/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Canino;
import Modelo.Felino;
import Modelo.Mascota;
import java.util.ArrayList;

/**
 *
 * @author samue
 */
public class Controlador {

    private int ultimoIDMascota;
    private ArrayList<Mascota> mascotas;

    public Controlador() {
        ultimoIDMascota = 0;
        mascotas = new ArrayList<>();
    }

    public void agregarMascota(Mascota mascota) {
        mascota.setIdMascota(++ultimoIDMascota);
        mascotas.add(mascota);
    }

    public ArrayList<Mascota> consultarMascotasDisponibles() {
        return mascotas;
    }

    public Mascota consultarMascota(int id) {
        for (Mascota mascota : mascotas) {
            if (mascota.getIdMascota() == id) {
                return mascota;
            }
        }
        return null;
    }

    public void retirarMascota(Mascota mascota) {
        mascotas.remove(mascota);
    }

    public int contarMascotas(String tipo) {
        int contador = 0;
        for (Mascota mascota : mascotas) {
            if (tipo.equalsIgnoreCase("canino") && mascota instanceof Canino) {
                contador++;
            } else if (tipo.equalsIgnoreCase("felino") && mascota instanceof Felino) {
                contador++;
            }
        }
        return contador;
    }

    public double calcularEdadPromedio() {
        double promedio = 0;

        if (mascotas.isEmpty()) {
            return 0;
        }

        for (Mascota mascota : mascotas) {
            promedio += mascota.getEdad();
        }
        promedio = promedio / mascotas.size();

        return promedio;
    }

}
