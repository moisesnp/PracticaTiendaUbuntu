package es.studium.MVC;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EditarCompraServlet")
public class EditarCompraServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idCompra = Integer.parseInt(request.getParameter("idCompra")); // Asumimos que el id de la compra viene como parámetro

        Modelo modelo = new Modelo();
        Compra compra = modelo.obtenerCompraPorId(idCompra);

        if (compra != null) {
            request.setAttribute("compra", compra);
            request.getRequestDispatcher("/EditarCompra.jsp").forward(request, response);
        } else {
            // Manejo de error: compra no encontrada
            response.sendRedirect("error.jsp");
        }
    }
}
