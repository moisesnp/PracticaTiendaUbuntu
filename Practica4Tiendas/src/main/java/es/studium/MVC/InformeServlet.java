package es.studium.MVC;



import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;



import java.io.IOException;

import java.util.ArrayList;





@WebServlet("/InformeServlet")

public class InformeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;



    

    public InformeServlet() {

        super();

    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {

        String parametroFechaSeleccionada = request.getParameter("fechaSeleccionada");

        int mesSeleccionado = 0;

        

        if (parametroFechaSeleccionada != null && !parametroFechaSeleccionada.isEmpty()) {

            mesSeleccionado = Integer.parseInt(parametroFechaSeleccionada);

        }



        // Llamar al método del modelo para obtener las compras por mes

        Modelo modelo = new Modelo();

        HttpSession sesion = request.getSession();

        ArrayList<Compra> listaCompras = modelo.DatosCompraPorMes((int) sesion.getAttribute("usuarioLogueado"), mesSeleccionado);



        // Calcular el total de compras

        double totalCompras = 0;

        for (Compra compra : listaCompras) {

            totalCompras += compra.getImporteCompra();

        }



        // Colocar la lista de compras y el total en el alcance de la solicitud

        request.setAttribute("listaCompras", listaCompras);

        request.setAttribute("totalCompras", totalCompras);



        RequestDispatcher dispatcher = request.getRequestDispatcher("/Informe.jsp");

        dispatcher.forward(request, response);

    }

}