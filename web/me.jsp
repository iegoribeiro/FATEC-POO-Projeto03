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
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        <h2>Meu perfil</h2>
        <%if(session.getAttribute("user.login")==null){%>
            <p>É preciso estar autenticado para acessar o conteúdo desta página.</p>
        <%}else{%>
            <%if(requestException != null){%>
                <div style="color:red"><%= requestException.getMessage() %></div>
            <%}%>
            <h3>Login:</h3>
            <h4><%= session.getAttribute("user.login") %></h4>
            <h3>Nome</h3>
            <h4><%= session.getAttribute("user.name") %></h4>
            <h3>Role:</h3>
            <h4><%= session.getAttribute("user.role") %></h4>
            <h3>Redefinição de senha:</h3>
            <form method="post">
                <input type="hidden" name="login" value="<%= session.getAttribute("user.login") %>"/>
                Senha atual: <br/><input type="password" name="password"/><br/>
                Senha nova: <br/><input type="password" name="new_password"/><br/>
                Confirmação da senha nova: <br/><input type="password" name="new_password2"/><br/>
                <br/><input type="submit" name="changePassword" value="Redefinir"/>
            </form>
        <%}%>
    </body>
</html>