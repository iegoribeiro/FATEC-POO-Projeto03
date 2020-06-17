<%-- 
    Document   : transactions
    Created on : Jun 15, 2020, 9:07:32 PM
    Author     : iego_
--%>

<%@page import="db.Transaction"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Exception requestException = null;
    
    if(request.getParameter("cancel")!=null){
        response.sendRedirect(request.getRequestURI());
    }
    if(request.getParameter("insert")!=null){
        try{
            String datetime = request.getParameter("datetime");
            String description = request.getParameter("description");
            double value = Double.parseDouble(request.getParameter("value"));
            String origin = request.getParameter("origin");
            Transaction.addTransaction(datetime, description, value, origin);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception ex){
            requestException = ex;
        }
    }
    if(request.getParameter("update")!=null){
        try{
            long rowId = Long.parseLong(request.getParameter("rowid"));
            String datetime = request.getParameter("datetime");
            String description = request.getParameter("description");
            double value = Double.parseDouble(request.getParameter("value"));
            String origin = request.getParameter("origin");
            Transaction.putTransaction(rowId, datetime, description, value, origin);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception ex){
            requestException = ex;
        }
    }
    if(request.getParameter("delete")!=null){
        try{
            long rowId = Long.parseLong(request.getParameter("rowid"));
            Transaction.removeTransaction(rowId);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception ex){
            requestException = ex;
        }
    }
    
    ArrayList<Transaction> list = new ArrayList<>();
    try{
        list = Transaction.getList();
    }catch(Exception ex){
        requestException = ex;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transações - QUIZ</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        <h2>Transações</h2>
        <%if(requestException!=null){%>
        <div style="color:red"><%= requestException.getMessage() %></div>
        <%}%>
        <hr/>
        <%if(request.getParameter("prepareInsert")!=null){%>
            <fieldset>
                <legend>Inserir Transação</legend>
                <form>
                    <div>
                        Data/hora: <input type="datetime-local" name="datetime"/>
                        Descrição: <input type="text" name="description"/>
                        Valor: <input type="number" step="0.01" name="value"/>
                        Estabelecimento: <input type="text" name="origin"/>
                    </div><br/>
                    <div>
                        <input type="submit" name="insert" value="Inserir"/>
                        <input type="submit" name="cancel" value="Cancelar"/>
                    </div>
                </form>
            </fieldset>
        <%}else if(request.getParameter("prepareUpdate")!=null){%>
            <fieldset>
                <legend>Alterar Transação</legend>
                <form>
                    <% long rowId = Long.parseLong(request.getParameter("rowid")); %>
                    <% Transaction t = Transaction.getTransaction(rowId); %>
                    <div><b>ID: </b><%= rowId %></div>
                    <div>
                        <input type="hidden" name="rowid" value="<%= rowId %>"/>
                        Data/hora: <input type="datetime-local" name="datetime" value="<%= t.getDatetime() %>"/>
                        Descrição: <input type="text" name="description" value="<%= t.getDescription()%>"/>
                        Valor: <input type="number" step="0.01" name="value"  value="<%= t.getValue() %>"/>
                        Estabelecimento: <input type="text" name="origin" value="<%= t.getOrigin() %>"/>
                    </div><br/>
                    <div>
                        <input type="submit" name="update" value="Alterar"/>
                        <input type="submit" name="cancel" value="Cancelar"/>
                    </div>
                </form>
            </fieldset>
        <%}else if(request.getParameter("prepareDelete")!=null){%>
            <fieldset>
                <legend>Remover Transação</legend>
                <form>
                    <% long rowId = Long.parseLong(request.getParameter("rowid")); %>
                    <% Transaction t = Transaction.getTransaction(rowId); %>
                    <input type="hidden" name="rowid" value="<%= rowId %>"/>
                    <div><b>ID: </b><%= rowId %></div>
                    <div><b>Data/hora: </b><%= t.getDatetime() %></div>
                    <div><b>Descrição: </b><%= t.getDescription() %></div>
                    <div><b>Valor: </b><%= t.getValue() %></div>
                    <div><b>Estabelecimento: </b><%= t.getOrigin()%></div>
                    <br/>
                    <div>Você deseja mesmo excluir esta transação?</div>
                    <input type="submit" name="delete" value="Confirmar exclusão"/>
                    <input type="submit" name="cancel" value="Cancelar"/>
                </form>
            </fieldset>
        <%}else {%>
            <form method="post">
                <input type="submit" name="prepareInsert" value="Inserir"/>
            </form>
        <%}%>
        <hr/>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Data/hora</th>
                <th>Descrição</th>
                <th>Valor</th>
                <th>Estabelecimento</th>
                <th>Comandos</th>
            </tr>
            <%for(Transaction t: list){%>
            <tr>
                <td><%= t.getRowId() %></td>
                <td><%= t.getDatetime() %></td>
                <td><%= t.getDescription() %></td>
                <td><%= t.getValue() %></td>
                <td><%= t.getOrigin() %></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="rowid" value="<%= t.getRowId() %>"/>
                        <input type="submit" name="prepareUpdate" value="Alterar"/>
                        <input type="submit" name="prepareDelete" value="Remover"/>
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
    </body>
</html>