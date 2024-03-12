<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" import="es.studium.MVC.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Compra</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function confirmarActualizacion() {
            return confirm('¿Estás seguro de que deseas actualizar esta compra?');
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Editar Compra</h1>
        <%
            int idCompra = Integer.parseInt(request.getParameter("idCompra"));
            Modelo modelo = new Modelo();
            Compra compra = modelo.obtenerCompraPorId(idCompra); // Asegúrate de tener implementado este método en tu Modelo.
            ArrayList<Tienda> tiendas = modelo.listaTiendasTienda();
        %>
        <form action="ActualizarInformeServlet" method="post" onsubmit="return confirmarActualizacion()">
            <input type="hidden" name="idCompra" value="<%= idCompra %>">
            <div class="form-group">
                <label for="fecha">Fecha de Compra:</label>
                <input type="date" id="fecha" name="fecha" value="<%= compra.getFechaCompra() %>" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="tienda">Tienda:</label>
                <select id="tienda" name="tienda" class="form-control" required>
                    <%
                        for (Tienda tienda : tiendas) {
                            String selected = tienda.getIdTienda() == compra.getIdTiendaFK() ? " selected" : "";
                    %>
                    <option value="<%= tienda.getIdTienda() %>"<%= selected %>><%= tienda.getNombreTienda() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="importe">Importe:</label>
                <input type="number" id="importe" name="importe" value="<%= compra.getImporteCompra() %>" step="0.01" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Actualizar Informe</button>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
