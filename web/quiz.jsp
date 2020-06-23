<%-- 
    Document   : users
    Created on : Jun 15, 2020, 9:42:48 PM
    Author     : iego_
--%>

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
            long sum = 100;
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
        <link href="<%= request.getContextPath() %>/css/clean-blog.css" rel="stylesheet">
        <title>QUIZ</title>
    </head>
    <body>
        <%@include file="/WEB-INF/jspf/menu.jspf" %>
        <hr/>
            <%if(session.getAttribute("user.login")==null){%>
                <div class="container">
                    <div class="row">
                        <p>É preciso estar autenticado para acessar o conteúdo desta página.</p>
                    </div>
                </div>
            <%}else{%>
            
                <%if(request.getParameter("submitQuiz")==null){%>
                    
                    <!--Definir Categoria input-->
                    Categoria: <select name="categoryEnumId">
                        <option value="0">Geral</option>
                        <option value="1">Esporte</option>
                        <option value="2">Exatas</option>
                        <option value="3">Curiosidades</option>
                    </select>
                
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
                        <form method="post">
                            <%int i = 1;%>
                            <%for (Question question : Question.getTenQuestionsRandomByCategory(1)) {%>
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

                        <!--Enviar Quiz-->
                        <hr class="mb-4">
                        <div class="text-right">
                          <button class="col-md-2 mr-4 mb-4 btn btn-primary" type="submit" name="submitQuiz">Enviar</button>
                        </div>
                    </div>
                <%}%>
            <%}%>
    </body>
</html>