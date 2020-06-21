<%-- 
    Document   : index
    Created on : Jun 15, 2020, 11:18:33 PM
    Author     : grupo03
--%>

<%@page import="db.Result"%>
<%@page import="web.DbListener"%>
<%@page import="db.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Exception requestException = null;
    ArrayList<Result> list = new ArrayList<>();
    try{
        list = Result.getList();
    }catch(Exception ex){
        requestException = ex;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        <h1>Quiz start!</h1>
        <p>Trabalho 03 - Quiz</p>
        
        <hr/>
        
        <h1>Maiores Notas</h1>
        <table border="1">
            <tr>
                <th>Colocação</th>
                <th>Nome</th>
                <th>Nota</th>
            </tr>
            <%for(Result r: list){%>
                <tr>
                    <td><%= r.getRowId() %></td>
                    <td><%= r.getFk_user_login() %></td>
                    <td><%= r.getResult() %></td>                    
                </tr>
                <%}%>
            </table>
            
        <%if(session.getAttribute("user.login")!=null){%>
        <h1>Seus melhores resultados</h1>
        <table border="1">
            <tr>
                <th>Colocação</th>
                <th>Nome</th>
                <th>Nota</th>
            </tr>
            <%for(Result r: list){%>
                <tr>
                    <td><%= r.getRowId() %></td>
                    <td><%= r.getFk_user_login() %></td>
                    <td><%= r.getResult() %></td>                    
                </tr>
                <%}%>
            </table>
        <%}%>
    </body>
</html>
