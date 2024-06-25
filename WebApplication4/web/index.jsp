<%-- 
    Document   : index
    Created on : 25 jun. 2024, 07:45:50
    Author     : PC
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <form action="index.jsp" method="POST">
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name"><br>
        
        <label for="nameID">Nombre a buscar:</label>
        <input type="text" name="nameID" id="nameID"><br>
        
        <label for="text2">Text2:</label>
        <input type="text" name="text2" id="text2"><br>

        <label for="text3">Text3:</label>
        <input type="text" name="text3" id="text3"><br>
        
        <label for="text4">Text4:</label>
        <input type="text" name="text4" id="text4"><br>

        <input type="submit" value="Enviar">
    </form>
    
    <%
        String nombre = null;
        String text2 = null;
        String text3 = null;
        String ala = null;
        String arl = null;
        List<String> Marco = new ArrayList<>();

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            nombre = request.getParameter("name");
            text2 = request.getParameter("text2");
            text3 = request.getParameter("text3");
            ala = request.getParameter("nameID");
            arl = request.getParameter("text4");
            
            if (nombre != null && text2 != null && text3 != null) {
                String rutaArchivo = "C:/Users/PC/Documents/NetBeansProjects/WebApplication4/src/java/Datos.txt";
                
                // Escritura en el archivo
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(rutaArchivo, true))) {
                    writer.write(nombre + "," + text2 + "," + text3);
                    writer.newLine(); // Para escribir una nueva línea si es necesario
                } catch (IOException e) {
                    e.printStackTrace(); // Manejo de errores
                }
                
                // Lectura del archivo y relleno de la lista Marco con la posición 0 de cada línea
                Marco.clear(); // Limpiar lista antes de llenarla de nuevo
                try (BufferedReader pepe = new BufferedReader(new FileReader(rutaArchivo))) {
                    String linea;
                    while ((linea = pepe.readLine()) != null) {
                        String[] partes = linea.split(",");
                        if (partes.length > 0) {
                            Marco.add(partes[0].trim());
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace(); // Manejo de errores
                }
                
                // Búsqueda y eliminación del registro basado en el nombre proporcionado (ala)
                if (ala != null && !ala.isEmpty()) {
                    boolean encontrado = false;
                    List<String> nuevaMarco = new ArrayList<>();
                    
                    for (String elemento : Marco) {
                        if (!elemento.equals(ala)) {
                            nuevaMarco.add(elemento); // Conservar los elementos que no coinciden
                        } else {
                            encontrado = true;
                        }
                    }
                    
                    if (encontrado) {
                        out.println("Elemento " + ala + " encontrado y eliminado de la lista Marco.<br>");
                    } else {
                        out.println("Elemento " + ala + " no encontrado en la lista Marco.<br>");
                    }
                    
                    // Actualizar la lista Marco con las líneas restantes
                    Marco.clear();
                    Marco.addAll(nuevaMarco);
                    
                    // Mostrar contenido actualizado de la lista Marco
                    out.println("Lista Marco actualizada: " + Marco + "<br>");
                }
                
                // Búsqueda de elemento en la lista Marco (arl)
                if (arl != null && !arl.isEmpty()) {
                    if (Marco.contains(arl)) {
                        out.println("El elemento " + arl + " pertenece a la lista Marco.<br>");
                    } else {
                        out.println("El elemento " + arl + " no pertenece a la lista Marco.<br>");
                    }
                    
                    // Mostrar contenido actualizado de la lista Marco
                    out.println("Lista Marco actualizada: " + Marco + "<br>");
                }

                // Mostrar contenido de la lista Marco
                out.println("Nombre: " + nombre + "<br>");
                out.println("Text2: " + text2 + "<br>");
                out.println("Text3: " + text3 + "<br>");
                out.println("A " + Marco);
            }
        }
    %>
</body>
</html>






