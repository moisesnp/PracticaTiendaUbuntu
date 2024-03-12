package es.studium.MVC;



import java.io.IOException;



import javax.naming.InitialContext;

import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import javax.sql.DataSource;



@WebServlet("/EliminarInformeServlet")

public class EliminarInformeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    

    @Override

    public void init() throws ServletException {

        try {

            InitialContext initContext = new InitialContext();

            @SuppressWarnings("unused")

			DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/aplicacionTienda");

        } catch (Exception e) {

            throw new ServletException("Error al inicializar el pool de conexiones", e);

        }

    }





    protected void doPost(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {

        // Obtener el ID de la compra a eliminar del parámetro enviado desde el formulario

        int idCompra = Integer.parseInt(request.getParameter("idCompra"));



        // Crear una nueva instancia del modelo

        Modelo modelo = new Modelo();



        // Llamar al método para eliminar la compra en la base de datos

		modelo.eliminarCompra(idCompra);



        // Redirigir al usuario de vuelta a la página donde se muestra la lista de compras

        response.sendRedirect("Informe.jsp");

    }

}