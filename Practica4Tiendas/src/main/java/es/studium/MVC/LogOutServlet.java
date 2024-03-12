package es.studium.MVC;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LogOutServlet")
public class LogOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
          throws ServletException, IOException {
        // Invalidar la sesión actual
        request.getSession().invalidate();
        
        // Redireccionar a la página de inicio de sesión
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
          throws ServletException, IOException {
        // Llamar al método doGet para manejar el logout
        doGet(request, response);
    }
}
