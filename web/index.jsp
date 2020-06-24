<%-- 
    Document   : index
    Created on : Jun 15, 2020, 11:18:33 PM
    Author     : grupo03
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="db.Result"%>
<%@page import="web.DbListener"%>
<%@page import="db.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz</title>
    </head>
    <body>
    <%@include file="WEB-INF/jspf/menu.jspf" %>
        
        <%if(session.getAttribute("user.login") == null){%>
            <header>
                <div class="overlay">
                    <div class="container">
                        <div class="row">
                            <div>
                                  <div class="site-heading">
                                      <h1>QUIZ</h1>
                                      <span class="subheading">TP03 - Programação Orientada Objetos</span>
                                  </div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <div class="container">
                <div class="row">
                    <div class="col">
                    <center><h3 class="mt-5 mb-5">Últimos quizzes realizados </h3></center>
                    <table class="table table-bordered table-hover">
                        <tr class="thead-light">
                            <th scope="col" class="text-center">#</th>
                            <th scope="col" class="text-center">Nome</th>
                            <th scope="col" class="text-center">Resultado</th>                    
                        </tr>
                        <%int i=1;%>
                        <%for (Result result: Result.getTenLastQuizzes()) {%>
                        <tr>
                            <td scope="row" class="text-center"><%= i %></td>
                            <td scope="row"><%= result.getUsername() %></td>
                            <td scope="row" class="text-center"><%= result.getResult() %></td>
                        </tr>
                        <%i++;%>
                        <%}%>
                    </table>
                    </div>

                    <div class="col">
                    <center><h3 class="mt-5 mb-5">Ranking</h3></center>
                    <table class="table table-bordered table-hover">
                        <tr class="thead-light">
                            <th scope="col" class="text-center">#</th>
                            <th scope="col" class="text-center">Nome</th>
                            <th scope="col" class="text-center">Resultado</th>        
                        </tr>
                        <%int j=1;%>
                        <%for (Result result: Result.getRanking()) {%>
                        <tr>
                            <td scope="row" class="text-center"><%= j %></td>
                            <td scope="row"><%= result.getUsername() %></td>
                            <td scope="row" class="text-center"><%= result.getResult() %></td>
                        </tr>
                        <%j++;%>
                        <%}%>
                    </table>
                    </div>
                </div>
            </div>
        <%} else {%>
            <div class="container">
                <h3 class="mt-5">Bem vindo, <a href="<%= request.getContextPath() %>/me.jsp"><b><%= session.getAttribute("user.name") %></h3></a></b>
                <%DecimalFormat df = new DecimalFormat("0.0");%>
                <h5 class="mt-4 mb-3">Sua média geral nos quizzes é <%= df.format(Result.getMediaByUser((String) session.getAttribute("user.login"))) %>/100 pontos!</h5>
                <h5 class="mt-4 mb-4">Seus últimos quizzes</h5>
                <div class="row">
                    <table class="table table-bordered table-hover">
                        <tr class="thead-light">
                            <th scope="col" class="text-center">#</th>
                            <th scope="col" class="text-center">Nome</th>
                            <th scope="col" class="text-center">Resultado</th>        
                        </tr>
                        <%int k=1;%>
                        <%for (Result result: Result.getTenLastQuizzesByUser((String) session.getAttribute("user.login"))) {%>
                        <tr>
                            <td scope="row" class="text-center"><%= k %></td>
                            <td scope="row"><%= result.getUsername() %></td>
                            <td scope="row" class="text-center"><%= result.getResult() %></td>
                        </tr>
                        <%k++;%>
                        <%}%>
                    </table>
                </div>
            </div>
                    
        
        <%}%>
                
        <footer>
          <%@include file="/WEB-INF/jspf/rodape.jspf" %>
        </footer>
    </body>
</html>
