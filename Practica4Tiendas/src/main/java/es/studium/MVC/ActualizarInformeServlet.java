package es.studium.MVC;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ActualizarInformeServlet")
public class ActualizarInformeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idCompra = Integer.parseInt(request.getParameter("idCompra"));
            String fechaCompraStr = request.getParameter("fecha");
            double importeCompra = Double.parseDouble(request.getParameter("importe"));
            int idTiendaSeleccionada = Integer.parseInt(request.getParameter("tienda"));

            // Formatear la fecha si es necesario
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String fechaCompraFormateada = sdf.format(sdf.parse(fechaCompraStr));

            Modelo modelo = new Modelo();
            modelo.modificarCompra(idCompra, fechaCompraFormateada, importeCompra, idTiendaSeleccionada);

            // Actualizar la lista de compras en la sesión y redirigir al usuario
            HttpSession session = request.getSession();
            ArrayList<Compra> compras = modelo.DatosCompra((int) session.getAttribute("usuarioLogueado"));
            session.setAttribute("listadoCompra", compras);
            response.sendRedirect(request.getContextPath() + "/Informe.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al actualizar la compra.");
        }
    }
}
