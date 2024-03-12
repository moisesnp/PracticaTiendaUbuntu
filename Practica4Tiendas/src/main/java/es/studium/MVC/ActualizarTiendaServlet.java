package es.studium.MVC;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/ActualizarTiendaServlet")
public class ActualizarTiendaServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idTienda = Integer.parseInt(request.getParameter("idTienda"));
            String nombreTienda = request.getParameter("nombreTienda");

            Modelo modelo = new Modelo();
            modelo.actualizarTienda(idTienda, nombreTienda);

            response.sendRedirect("Tiendas.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
