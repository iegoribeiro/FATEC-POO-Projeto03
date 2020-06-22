<%-- 
    Document   : users
    Created on : Jun 15, 2020, 9:42:48 PM
    Author     : iego_
--%>

<%@page import="web.DbListener"%>
<%@page import="db.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%= request.getContextPath() %>/css/clean-blog.css" rel="stylesheet">
        <title>QUIZ</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/menu.jspf" %>
        <hr/>
            <%if(session.getAttribute("user.login")==null){%>
                <div class="container">
                    <div class="row">
                        <p>É preciso estar autenticado para acessar o conteúdo desta página.</p>
                    </div>
                </div>
            <%}else{%>
                <div>
                    <div class="container-fluid">
                      <div class="row">
                        <main role="main" class="col-md-12 ml-sm-auto col-lg-12 pt-3 px-4">
                          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
                            <h1 class="h2">Quiz</h1>
                          </div>
                        </main>
                      </div>
                    </div>
                    <form>
                        <div class="container">
                            <div class="shadow-lg p-2 m-5 bg-light rounded">
                                <p class="ml-4 mt-2 font-weight-bold h4">1ª Questão</p>
                                <hr class="mb-4">
                                <div class="form-group mb-4">
                                      <p class="ml-4 mt-2 h4">Normalmente, quantos litros de sangue uma pessoa tem?</p>
                                </div>
                                <div class="form-group mb-4">
                                    <p class="ml-4 mt-2 h5">Entre 4 a 6 litros.</p>
                                    <p class="ml-4 mt-2 h5">Tem entre 2 a 4 litros.</p>
                                    <p class="ml-4 mt-2 h5">Tem 7 litros.</p>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="shadow-lg p-2 m-5 bg-light rounded">
                                <p class="ml-4 mt-2 font-weight-bold h4">1ª Questão</p>
                                <hr class="mb-4">
                                <div class="form-group mb-4">
                                      <p class="ml-4 mt-2 h4">Normalmente, quantos litros de sangue uma pessoa tem?</p>
                                </div>
                                <div class="form-group mb-4">
                                    <p class="ml-4 mt-2 h5">Entre 4 a 6 litros.</p>
                                    <p class="ml-4 mt-2 h5">Tem entre 2 a 4 litros.</p>
                                    <p class="ml-4 mt-2 h5">Tem 7 litros.</p>
                                </div>
                            </div>
                        </div>
                    </form>
                    
                    <!--Enviar Quiz-->
                    <hr class="mb-4">
                    <div class="text-right">
                      <button class="col-md-2 mr-4 btn btn-primary" type="submit">Enviar</button>
                    </div>
                  </div>
            <%}%>
    </body>
</html>