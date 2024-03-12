<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tabla de Tiendas</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script>
        // Función para confirmar la eliminación de la tienda
        function confirmarEliminacionTienda(idTienda) {
            var confirmacion = confirm("¿Estás seguro de que deseas eliminar esta tienda?");
            if (confirmacion) {
                // Si el usuario confirma, se envía el formulario de eliminación
                document.getElementById("eliminarTiendaForm" + idTienda).submit();
            }
            // Si el usuario cancela, no se hace nada
        }
    </script>
</head>
<body>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page session="true" import="java.util.*, es.studium.MVC.*" %>

    <form action="LogOutServlet" method="get">
        <input type="submit" value="Cerrar Sesión" class="btn btn-danger">
    </form>
   
    <div class="container">
        <h1>Tabla de Tiendas</h1>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre de Tienda</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% 
                Modelo modelo = new Modelo();
                ArrayList<Tienda> listaTiendas = modelo.listaTiendasTienda();
                for (Tienda tienda : listaTiendas) {
                %>
                <tr>
                    <td><%= tienda.getIdTienda() %></td>
                    <td><%= tienda.getNombreTienda() %></td>
                    <td>
                        <form action="CargarDatosTiendaServlet" method="post" style="display: inline;">
                            <input type="hidden" name="idTienda" value="<%= tienda.getIdTienda() %>">
                            <button type="submit" class="btn btn-primary">Editar</button>
                        </form>
                        <!-- Modificar aquí para incluir el ID en el atributo id del formulario y el evento onclick en el botón -->
                        <form id="eliminarTiendaForm<%= tienda.getIdTienda() %>" action="EliminarTiendaServlet" method="post" style="display: inline;">
                            <input type="hidden" name="idTienda" value="<%= tienda.getIdTienda() %>">
                            <button type="button" onclick="confirmarEliminacionTienda(<%= tienda.getIdTienda() %>)" class="btn btn-danger">Eliminar</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

       <form action="NuevaTiendaServlet" method="post">
            <div class="form-group">
                <label for="nombreTienda">Nombre de la Tienda:</label>
                <input type="text" class="form-control" id="nombreTienda" name="nombreTienda" required>
            </div>
            <button type="submit" class="btn btn-success">Agregar Nueva Tienda</button>
        </form>
        
        <form action="Principal.jsp">
            <button type="submit" class="btn btn-primary">Volver a Principal</button>
        </form>
    </div>
    
    <!-- Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
