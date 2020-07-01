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
    Exception requestException = null;
    if(request.getParameter("insert")!=null){
        try{
            String login = request.getParameter("login");
            String name = request.getParameter("name");
            String role = request.getParameter("role");
            String password = request.getParameter("password");
            User.addUser(login, name, role, password);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception ex){
            requestException = ex;
        }
    }
    
    if(request.getParameter("delete")!=null){
        try{
            String login = request.getParameter("login");
            User.removeUser(login);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception ex){
            requestException = ex;
        }
    }
    
    ArrayList<User> list = new ArrayList<>();
    try{
        list = User.getList();
    }catch(Exception ex){
        requestException = ex;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários - QUIZ</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/menu.jspf" %>
        <%if(session.getAttribute("user.login")==null){%>
            <div class="container">
                <div class="row ml-0 mr-0">
                    <div class="h4">É preciso estar autenticado para acessar o conteúdo desta página.</div>
                </div>
            </div>
        <%}else{%>
            <%if(!session.getAttribute("user.role").equals("ADMIN")){%>
                <div class="container">
                    <div class="row ml-0 mr-0">
                        <div class="h4">É preciso ser administrador para acessar o conteúdo desta página.</div>
                    </div>
                </div>
            <%}else{%>
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
                    <div class="block-header mb-4">
                        <h2 class="font-weight-bold">Usuários</h2>
                    </div>
                    <div class="shadow rounded mb-5">
                        <form method="post" class="form-group mb-4">
                            <div class="card">
                                <div class="card-header ">
                                    <h4>Novo usuário</h4>
                                </div>

                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-sm-3 pr-1">
                                            <div class="form-group fg-float">
                                                <label class="fg-label" for="login">Login</label>
                                                <input class="form-control fg-input" type="text" name="login" required id="login" placeholder="Login"/>                                                
                                            </div>
                                        </div>
                                        <div class="col-sm-3 pr-1">
                                            <div class="form-group fg-float">
                                                <label class="fg-label" for="name">Nome</label>
                                                <input class="form-control fg-input" type="text" name="name" required id="name" placeholder="Nome"/>                                                
                                            </div>
                                        </div>
                                        <div class="col-sm-3 pr-1">
                                            <div class="form-group fg-float">
                                                <label class="fg-label" for="role">Role</label>
                                                <select class="form-control form-control" name="role">
                                                    <option value="ADMIN">ADMIN</option>
                                                    <option value="USER" selected>USER</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group fg-float">
                                                <label class="fg-label" for="senha">Senha</label>
                                                <input class="form-control fg-input" type="password" name="password" required id="senha" placeholder="Senha"/>                                                
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="text-right">
                                                <button class="btn btn-outline-primary" name="insert" type="submit">Inserir</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="shadow rounded">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover mb-0">
                                <tr class="thead-light">
                                    <th scope="col" class="text-center">Login</th>
                                    <th scope="col" class="text-center">Nome</th>
                                    <th scope="col" class="text-center">Papel</th>
                                    <th scope="col" class="text-center">Comandos</th>                    
                                </tr>
                                <%for(User user: list){%>
                                    <tr>
                                        <td scope="row" class="text-center"><%= user.getLogin()%></td>
                                        <td scope="row" class="text-center"><%= user.getName() %></td>
                                        <td scope="row" class="text-center"><%= user.getRole() %></td>
                                        <td scope="row" class="text-center">
                                            <form method="post">
                                                <input type="hidden" name="login" value="<%=user.getLogin()%>"/>
                                                <input type="submit" class="btn btn-outline-dark btn-sm" name="delete" value="Remover"/>
                                            </form>
                                        </td>
                                    </tr>
                                <%}%>
                            </table>
                        </div>
                    </div>
                </div>
            <%}%>
        <%}%>
        
        <footer>
          <%@include file="/WEB-INF/jspf/rodape.jspf" %>
        </footer>
    </body>
</html>