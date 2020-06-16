<%-- 
    Document   : index
    Created on : Jun 15, 2020, 11:18:33 PM
    Author     : grupo03
--%>

<%@page import="db.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String errorMessage = null;
    ArrayList<User> list = new ArrayList<>();
    try {
            list = User.getList();
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz</title>
    </head>
    <body>
        <h1>Quiz start!</h1>
        <h2>Lista de usuários</h2>
        <table border="1">
            <tr>
                <th>Login</th>
                <th>Nome</th>
            </tr>
            <%for(User user: list){%>
            <tr>
                <td><%= user.getLogin() %></td>
                <td><%= user.getName() %></td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
