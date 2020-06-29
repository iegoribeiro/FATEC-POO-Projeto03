<%-- 
    Document   : me
    Created on : Jun 8, 2020, 10:48:07 PM
    Author     : iego_
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Exception requestException = null;
    if(request.getParameter("changePassword")!=null){
        try{
            String login = request.getParameter("login");
            String password = request.getParameter("password");
            String new_password = request.getParameter("new_password");
            String new_password2 = request.getParameter("new_password2");
            if(User.getUser(login, password)==null){
                throw new Exception("Login/password incorrect");
            }else if(!new_password.equals(new_password2)){
                throw new Exception("Invalid password confirmation");
            }else{
                User.changePassword(login, new_password);
                response.sendRedirect(request.getRequestURI());
            }
        }catch(Exception ex){
            requestException = ex;
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Meu Perfil - QUIZ</title>
    </head>
    <body>
        <%@include file="/WEB-INF/jspf/menu.jspf" %>
        <%if(session.getAttribute("user.login")==null){%>
            <div class="container">
                <div class="row ml-0 mr-0">
                    <div class="h4">É preciso estar autenticado para acessar o conteúdo desta página.</div>
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
                    <h2 class="font-weight-bold">Meu perfil</h2>
                </div>
                
                <div class="card mb-4 shadow" style="max-width: 18rem;">
                    <div class="card-header h5"><%= session.getAttribute("user.name") %></div>
                    <div>
                        <img class="card-img-top" src="<%= request.getContextPath() %>/images/<%= session.getAttribute("user.role")%>.png" alt="admin">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>LOGIN: </strong><%= session.getAttribute("user.login")%></li>
                            <li class="list-group-item"><strong>ROLE: </strong><%= session.getAttribute("user.role") %></li>
                        </ul>
                    </div>
                </div>              
            
                <div class="shadow rounded mb-5">
                    <form method="post" class="form-group mb-4">
                        <div class="card">
                            <div class="card-header ">
                                <h4>Redefinição de senha</h4>
                            </div>
                            <input type="hidden" name="login" value="<%= session.getAttribute("user.login") %>"/>
                            
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-group fg-float">
                                            <label class="fg-label" for="password">Senha atual</label>
                                            <input class="form-control fg-input" type="password" name="password" id="login" placeholder="Senha atual"/>                                                
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group fg-float">
                                            <label class="fg-label" for="password">Senha nova</label>
                                            <input class="form-control fg-input" type="password" name="new_password" id="login" placeholder="Senha nova"/>                                                
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group fg-float">
                                            <label class="fg-label" for="senha">Confirmação da senha nova</label>
                                            <input class="form-control fg-input" type="password" name="new_password2" id="senha" placeholder="Confirmação da senha nova"/>                                                
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="text-right">
                                            <button class="btn btn-outline-primary" type="submit" name="changePassword">Redefinir</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        <%}%>
        
        <footer>
          <%@include file="/WEB-INF/jspf/rodape.jspf" %>
        </footer>
    </body>
</html>