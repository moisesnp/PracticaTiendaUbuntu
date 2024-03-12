<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" import="java.util.*, es.studium.MVC.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tabla de Compras</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script>
        // Función para confirmar la eliminación
        function confirmarEliminacion(idCompra) {
            var confirmacion = confirm("¿Estás seguro de que deseas eliminar esta compra?");
            if (confirmacion) {
                // Si el usuario confirma, se envía el formulario de eliminación
                document.getElementById("eliminarForm" + idCompra).submit();
            }
            // Si el usuario cancela, no se hace nada
        }
    </script>
</head>
<body>
    <form action="LogOutServlet" method="get">
        <input type="submit" value="Cerrar Sesión" class="btn btn-danger">
    </form>
    <div class="container">
        <div class="calendar-title">
            <% 
                String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                int mesSeleccionado = 0;
                String parametroFechaSeleccionada = request.getParameter("fechaSeleccionada");
                if (parametroFechaSeleccionada != null && !parametroFechaSeleccionada.isEmpty()) {
                    mesSeleccionado = Integer.parseInt(parametroFechaSeleccionada);
                }
            %>
            <h1>Calendario de Compras - <%= (mesSeleccionado > 0) ? meses[mesSeleccionado - 1] : "" %> </h1>
            <h2>Total de Compras: <%= request.getAttribute("totalCompras") %> </h2>
        </div>
        <!-- Desplegable de fechas -->
        <form action="InformeServlet" method="post">
            <div class="form-group">
                <label for="fechaSeleccionada">Seleccione una fecha:</label>
                <select name="fechaSeleccionada" id="fechaSeleccionada" class="form-control">
                    <%
                        for (int i = 0; i < meses.length; i++) {
                    %>
                            <option value="<%=i+1%>"><%=meses[i]%></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Ver informe</button>
        </form>
        <!-- Tabla de compras -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Fecha de Compra</th>
                    <th>Importe de Compra</th>
                    <th>Nombre de Tienda</th>
                    <th>Editar</th>
                    <th>Eliminar</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Modelo modelo = new Modelo();
                    HttpSession sesion = request.getSession();
                    ArrayList<Compra> listaCompras = modelo.DatosCompraPorMes((int) sesion.getAttribute("usuarioLogueado"), mesSeleccionado);
                    for (Compra compra : listaCompras) {
                %>
                <tr>
                    <td><%= compra.getFechaCompra() %></td>
                    <td><%= compra.getImporteCompra() %></td>
                    <td><%= compra.getNombreTienda() %></td>
                    <td>
                        <form action="EditarInformeServlet" method="post">
                            <input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
                            <input type="submit" value="Editar" class="btn btn-primary">
                        </form>
                    </td>
                    <td>
                        <form id="eliminarForm<%= compra.getIdCompra() %>" action="EliminarInformeServlet" method="post">
                            <input type="hidden" name="idCompra" value="<%= compra.getIdCompra() %>">
                            <button type="button" onclick="confirmarEliminacion(<%= compra.getIdCompra() %>)" class="btn btn-danger">Eliminar</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                <% if (listaCompras.isEmpty()) { %>
                <tr>
                    <td colspan="5">No se encontraron compras para mostrar.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <!-- Botones -->
        <div class="row">
            <div class="col-md-4">
                <form action="NuevaCompraServlet" method="post">
                    <input type="submit" value="Nueva Compra" class="btn btn-success">
                </form>
            </div>
            <form action="Principal.jsp">
                <button type="submit" class="btn btn-primary">Volver a Principal</button>
            </form>
        </div>
    </div>
    <!-- Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
