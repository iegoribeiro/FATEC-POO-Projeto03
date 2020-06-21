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
            
    ArrayList<Result> list2 = new ArrayList<>();
    try{
        list2 = Result.getResult("beltrano");
    }catch(Exception ex){
        requestException = ex;
    }
    
    ArrayList<Result> list3 = new ArrayList<>();
    try{
        list3 = Result.getLast();
    }catch(Exception ex){
        requestException = ex;
    }
    
    Integer i = 0;
    long total = 0;
    for(Result r2: list2){
        i = i + 1;
        total = total + r2.getResult();
    }
    long media = total/i;
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
        
        <h1>Últimos testes realizados</h1>
        <table border="1">
            <tr>
                <th>Nome</th>
                <th>Nota</th>
            </tr>
            <%for(Result r3: list3){%>
                <tr>
                    <td><%= r3.getFk_user_login() %></td>
                    <td><%= r3.getResult() %></td>                    
                </tr>
                <%}%>
            </table>
            
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
            <%for(Result r2: list2){%>
                <tr>
                    <td><%= r2.getRowId() %></td>
                    <td><%= r2.getFk_user_login() %></td>
                    <td><%= r2.getResult() %></td>                    
                </tr>
                <%}%>
            </table>
            Sua média de acertos é <%= media %>
        <%}%>
    </body>
</html>
