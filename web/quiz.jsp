<%-- 
    Document   : users
    Created on : Jun 15, 2020, 9:42:48 PM
    Author     : iego_
--%>

<%@page import="db.CategoryEnum"%>
<%@page import="db.Result"%>
<%@page import="java.util.Random"%>
<%@page import="web.DbListener"%>
<%@page import="db.User"%>
<%@page import="db.Question"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Exception requestException = null;
    if(request.getParameter("submitQuiz")!=null){
        try{
            long categoryEnumId = Long.parseLong(request.getParameter("categoryEnumId"));
            long sum = 0;
            
            
            
            String userLogin = (String) session.getAttribute("user.login");
            
            Result result = new Result(sum, userLogin, categoryEnumId);
            result.addResult(sum, userLogin, categoryEnumId);
//            if(t==null){
//                throw new Exception("Categoria não encontrada. Pode ter sido removida da base de dados por outro usuário.");
//            }else{
//                t.updateTransaction(rowId, newDatetime, newDescription, newCategory, newValue, newOrigin);
//                response.sendRedirect(request.getRequestURI());
//            }
        }catch(Exception ex){
            requestException = ex;
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QUIZ</title>
    </head>
    <body>
    <%@include file="WEB-INF/jspf/menu.jspf" %>
        
        <%if(session.getAttribute("user.login")==null){%>
            <div class="container">
                <div class="row">
                    <p>É preciso estar autenticado para acessar o conteúdo desta página.</p>
                </div>
            </div>
        <%}else{%>

            <%if(request.getParameter("submitQuiz")==null){%>
                
                <form method="post">
                    <div class="container">
                        <div class="row">
                            <div class="d-flex">
                                <h4>Escolha a categoria do Quiz:&nbsp;</h4>
                                <select class="ml-2" name="categoryEnumId">
                                    <option value="0">Geral</option>
                                    <%for(CategoryEnum c: CategoryEnum.getList()){%>
                                    <option value="<%= c.getId()%>" <%= request.getParameter("categoryEnumId") != null && c.getId() == Long.parseLong(request.getParameter("categoryEnumId")) ? "selected" : "" %>>
                                            <%= c.getName() %>
                                        </option>
                                    <%}%>
                                </select>
                                <input type="submit" class="btn btn-secondary ml-3 pb-0 pt-0" name="categoria" value="GAME!"/>
                            </div>
                        </div>
                    </div>
                </form>
            
                <%if(request.getParameter("categoryEnumId")!=null){%>
                    <form method="post">
                        <%int i = 1;%>
                        <%for (Question question : Question.getTenQuestionsRandomByCategory(Long.parseLong(request.getParameter("categoryEnumId")))) {%>
                            <div class="container">
                                <div class="shadow-lg p-2 m-4 bg-light rounded">
                                    <p class="ml-4 mt-2 font-weight-bold h3"><%=i%>ª Questão</p>
                                    <hr class="mb-4">
                                    <div class="form-group mb-4">
                                        <p class="ml-4 mt-2 h4"><%= question.getQuestion() %></p>
                                    </div>
                                    <%
                                    Random random = new Random();
                                    ArrayList<Integer> list = new ArrayList<>(3);
                                    while(list.size()<3) {
                                        int n = random.nextInt(3)+1;
                                        if (!list.contains(n)) {
                                            list.add(n);%>

                                            <div class="form-group form-check ml-4 mt-2 h5">
                                                <input class="form-check-input mt-1" style="height: 17px; width: 17px;" type="radio" name="answer<%=i%>" id="answer-<%=i%>-<%=n%>" value="<%=n%>" > 
                                                <label class="form-check-label ml-2" for="answer-<%=i%>-<%=n%>">
                                                    <%= question.getAnswer(n)%>
                                                </label>
                                            </div>
                                        <%}%>
                                    <%}%>
                                </div>
                            </div> 
                        <%i++;%>
                        <%}%>
                    </form>
                <%}%>
            
                <!--Enviar Quiz-->
                <hr class="mb-4">
                <div class="text-right">
                  <button class="col-md-2 mr-4 mb-4 btn btn-primary" type="submit" name="submitQuiz">Enviar</button>
                </div>
            <%}%>
        <%}%>
    </body>
</html>