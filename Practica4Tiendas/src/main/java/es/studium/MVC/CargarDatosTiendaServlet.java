package es.studium.MVC;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/CargarDatosTiendaServlet")
public class CargarDatosTiendaServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idTienda = Integer.parseInt(request.getParameter("idTienda"));
            Modelo modelo = new Modelo();
            Tienda tienda = modelo.obtenerTiendaPorId(idTienda);

            request.setAttribute("tienda", tienda);
            RequestDispatcher dispatcher = request.getRequestDispatcher("EditarTienda.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
