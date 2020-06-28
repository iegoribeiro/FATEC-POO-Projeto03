<%-- 
    Document   : index
    Created on : Jun 15, 2020, 11:18:33 PM
    Author     : grupo03
--%>

<%@page import="db.CategoryEnum"%>
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
                        <div class="shadow rounded">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover mb-0">
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
                        </div>
                    </div>

                    <div class="col">
                    <center><h3 class="mt-5 mb-5">Ranking</h3></center>
                    <div class="shadow rounded">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover mb-0">
                                <tr class="thead-light">
                                    <th scope="col" class="text-center">#</th>
                                    <th scope="col" class="text-center">Nome</th>
                                    <th scope="col" class="text-center">Resultado</th>        
                                </tr>
                                <%int j=1;%>
                                <%for (Result result: Result.getRanking()) {%>
                                <tr>
                                    <td scope="row" class="text-center"><%= j %></td>
                                    <td scope="row" class="text-center"><%= result.getUsername() %></td>
                                    <td scope="row" class="text-center"><%= result.getResult() %></td>
                                </tr>
                                <%j++;%>
                                <%}%>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        <%} else {%>
            <div class="container">
                <div class="block-header mb-5">
                    <h2 class="font-weight-bold">Bem vindo, <a href="<%= request.getContextPath() %>/me.jsp"><b><%= session.getAttribute("user.name") %></h3></a></h2>
                </div>
                
                <div class="row">
                    <div class="col-6">
                        <div class="shadow rounded mb-5">
                            <div class="card">
                                <div class="card-header ">
                                    <h5 class="mt-2 mb-2"><strong>PONTUAÇÃO GERAL</strong></h5>
                                </div>
                                <div class="card-body ml-3 mr-3">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <%DecimalFormat df = new DecimalFormat("0.0");%>
                                            <h6 class="mt-2 mb-2"><strong>Média geral: </strong><%= df.format(Result.getMediaByUser((String) session.getAttribute("user.login"))) %>/100 pontos</h6>
                                            <h6 class="mt-2 mb-2"><strong>Pontuação máxima: </strong><%= df.format(Result.getMediaByUser((String) session.getAttribute("user.login"))) %> ponto(s)</h6>
                                            <h6 class="mt-2 mb-2"><strong>Pontuação mínima: </strong><%= df.format(Result.getMediaByUser((String) session.getAttribute("user.login"))) %> ponto(s)</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="shadow rounded mb-5">
                            <div class="card">
                                <div class="card-header ">
                                    <h5 class="mt-2 mb-2"><strong>PONTUAÇÃO POR CATEGORIA</strong></h5>
                                </div>
                                <div class="card-body ml-3 mr-3">
                                    <div class="row">
                                        <div class="col-12">
                                            <%for (CategoryEnum ctg : CategoryEnum.getList()) {
                                                if(Result.getMediaByUserAndCategory((String) session.getAttribute("user.login"), ctg.getId()) > 0) {%>
                                                    <h6 class="mt-2 mb-2"><strong><%=ctg.getName()%>: </strong><%= df.format(Result.getMediaByUserAndCategory((String) session.getAttribute("user.login"), ctg.getId()))%>/100 pontos</h6>                                            
                                                <%}%>
                                            <%}%>                  
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    
                
                <div class="shadow rounded">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover mb-0">
                            <tr class="thead-light">
                                <th scope="col" class="text-center">#</th>
                                <th scope="col" class="text-center">Nome</th>
                                <th scope="col" class="text-center">Resultado</th>        
                            </tr>
                            <%int k=1;%>
                            <%for (Result result: Result.getTenLastQuizzesByUser((String) session.getAttribute("user.login"))) {%>
                            <tr>
                                <td scope="row" class="text-center"><%= k %></td>
                                <td scope="row" class="text-center"><%= result.getUsername() %></td>
                                <td scope="row" class="text-center"><%= result.getResult() %></td>
                            </tr>
                            <%k++;%>
                            <%}%>
                        </table>
                    </div>
                </div>
            </div>
        <%}%>
                
        <footer>
          <%@include file="/WEB-INF/jspf/rodape.jspf" %>
        </footer>
    </body>
</html>
