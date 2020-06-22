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

<%@include file="/WEB-INF/jspf/headerIndex.jspf" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz</title>
        <header class="masthead" style="background-image: url('home-bg.jpg')">
            <div class="overlay"></div>
            <div class="container">
              <div class="row">
                <div class="col-lg-8 col-md-10 mx-auto">
                  <div class="site-heading">
                    <h1>QUIZ</h1>
                    <span class="subheading">TP03 - Programação Orientada Objetos</span>
                  </div>
                </div>
              </div>
            </div>
        </header>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        
        <!--10 últimos testes e ranking 10 melhores notas-->
        
        <%if(session.getAttribute("user.login") == null){%>
        
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
                <%DecimalFormat df = new DecimalFormat("0.0");%>
                <h3 class="mt-5 mb-4">Sua média: <%= df.format(Result.getMediaByUser((String) session.getAttribute("user.login"))) %></h3>
                <h3 class="mt-5 mb-4">Seus últimos quizzes</h3>
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
