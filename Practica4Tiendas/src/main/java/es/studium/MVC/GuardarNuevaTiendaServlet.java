package es.studium.MVC;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/GuardarNuevaTiendaServlet")
public class GuardarNuevaTiendaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el nombre de la tienda del parámetro enviado desde el formulario
        String nombreTienda = request.getParameter("nombreTienda");

        // Obtener el ID de usuario de la sesión
        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("usuarioLogueado");

        // Verificar si el usuario está logueado
        if (idUsuario != -1) {
            // Crear una nueva instancia del modelo
            Modelo modelo = new Modelo();

            try {
                // Llamar al método para crear una nueva tienda en la base de datos
                modelo.crearNuevaTienda(nombreTienda);

                // Obtener la lista de tiendas actual de la sesión
                @SuppressWarnings("unchecked")
				ArrayList<Tienda> tiendas = (ArrayList<Tienda>) session.getAttribute("tiendas");

                // Inicializar la lista de tiendas si es nula
                if (tiendas == null) {
                    tiendas = new ArrayList<>();
                }

                // Verificar si la nueva tienda ya existe en la lista
                boolean tiendaExiste = false;
                for (Tienda t : tiendas) {
                    if (t.getNombreTienda().equals(nombreTienda)) {
                        tiendaExiste = true;
                        break;
                    }
                }

                // Si la tienda no existe, la agregamos a la lista
                if (!tiendaExiste) {
                    Tienda nuevaTienda = new Tienda(idUsuario, nombreTienda);
                    nuevaTienda.setNombreTienda(nombreTienda);
                    tiendas.add(nuevaTienda);
                }

                // Actualizar la lista de tiendas en la sesión
                session.setAttribute("tiendas", tiendas);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            // Manejar el caso cuando el usuario no está logueado
            // Por ejemplo, redirigir al usuario a la página de inicio de sesión
            response.sendRedirect("Login.jsp");
            return; // Importante para evitar la redirección duplicada
        }

        // Redirigir al usuario de vuelta al listado de tiendas
        response.sendRedirect("Tiendas.jsp");
    }
}
