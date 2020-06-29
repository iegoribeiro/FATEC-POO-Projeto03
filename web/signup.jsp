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
<%
    boolean cadastroSucesso = false;
    Exception requestException = null;
    if(request.getParameter("cadastrar")!=null){
        try{
            String login = request.getParameter("login");
            String name = request.getParameter("name");
            String role = "USER";
            String password = request.getParameter("password");
            User.addUser(login, name, role, password);
            cadastroSucesso = true;
//            response.sendRedirect(request.getContextPath()+"/index.jsp");
        }catch(Exception ex){
            requestException = ex;
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários - QUIZ</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        
        <%if(requestException != null){%>
            <div class="container">
                <div class="row ml-0 mr-0">
                    <div class="h5">Ah, Não! Ocorreu um erro, contate o administrador do sistema.
                        <div style="color:red"><%= requestException.getMessage() %></div>
                    </div>
                </div>
            </div>
        <%}%>
        
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-5">
                    <div class="shadow rounded mb-1">
                        <div class="card">
                            <div class="card-header text-center">
                                <h3 class="font-weight-bold">Cadastrar-se</h3>
                            </div>
                            <form method="post">
                                <div class="card-body ml-3 mr-3">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group fg-float">
                                                        <label class="fg-label h6" for="login">Login</label>
                                                        <input class="form-control fg-input" type="text" name="login" id="login" placeholder="Login"/>                                                
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group fg-float">
                                                        <label class="fg-label h6" for="name">Nome</label>
                                                        <input class="form-control fg-input" type="text" name="name" id="name" placeholder="Nome"/>                                                
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-12">
                                                    <div class="form-group fg-float">
                                                        <label class="fg-label h6" for="senha">Senha</label>
                                                        <input class="form-control fg-input" type="password" name="password" id="senha" placeholder="Senha"/>                                                
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-12">
                                                    <div class="text-right">
                                                        <button class="btn btn-outline-success btn-block" name="cadastrar" type="submit">Cadastrar-me</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <%if(request.getParameter("cadastrar")!=null && cadastroSucesso){%>
                                                <div class="row mt-3 mb-0">
                                                    <div class="col-sm-12">
                                                        <div class="alert alert-success" role="alert">
                                                            Cadastro realizado com sucesso!
                                                        </div>
                                                    </div>
                                                </div>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
          <%@include file="/WEB-INF/jspf/rodape.jspf" %>
        </footer>
    </body>
</html>