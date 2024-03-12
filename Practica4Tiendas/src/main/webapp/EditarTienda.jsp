<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="es.studium.MVC.Tienda" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Tienda</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function confirmarActualizacion() {
            return confirm("¿Estás seguro de que deseas actualizar esta tienda?");
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Editar Tienda</h1>
        <form action="ActualizarTiendaServlet" method="post">
            <input type="hidden" name="idTienda" value="${tienda.idTienda}">
            <div class="form-group">
                <label for="nombre">Nombre de la Tienda:</label>
                <input type="text" id="nombre" name="nombreTienda" class="form-control" value="${tienda.nombreTienda}" required>
            </div>
            <button type="submit" class="btn btn-primary" onclick="return confirmarActualizacion()">Actualizar Tienda</button>
        </form>
    </div>
</body>
</html>
