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
    long pontos = 0;
    ArrayList<Integer> questionDrawn = new ArrayList<>();
    if(request.getParameter("submitQuiz")!=null){
        try{
            String userLogin = (String) session.getAttribute("user.login");
            long categoryEnumId = Long.parseLong(request.getParameter("categoriaGame"));
            
            for (int j=1; j<=10; j++) {
                if(request.getParameter("answer-"+ j) !=null) {
                    pontos += Long.parseLong(request.getParameter("answer-"+ j)) == 1 ? 10L : 0L;
                    questionDrawn.add(Integer.parseInt(request.getParameter("question-drawn-"+ j)));
                }
            }
            
            Result result = new Result();
            result.addResult(pontos, userLogin, categoryEnumId);
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
        <script>
            function isValidForm() {
                for (var z=1; z <= 10; z++) {
                    if(document.forms["questionForm"]["answer-"+z].value === "") {
                        document.getElementById("question-"+z).scrollIntoView({block:"center", behavior: 'smooth'});
                        return false;
                    }
                }
                return true;
            }
        </script>
        <%if(request.getParameter("submitQuiz")==null){%>
            <script>
                var progressBar = $('.progress-bar-class');
                var progressNumber = 0;
                
                function millisToMinutesAndSeconds(millis) {
                    var minutes = Math.floor(millis / 60000);
                    var seconds = ((millis % 60000) / 1000).toFixed(0);
                    return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
                }
                
                setInterval(function(){
                    progressNumber++;
                    
                    if(progressNumber === 12000 && document.getElementById("form-questions") !== null) {
                        alert("Tempo esgotado, tente novamente!!");
                        window.location.href = "<%= request.getContextPath() %>/quiz.jsp";
                    }
                    if(progressNumber < 12000 && document.getElementById("form-questions") !== null) {
                        var x = (12000 - (progressNumber))/100;
                        document.getElementById("tempo").innerHTML = millisToMinutesAndSeconds(x*1000);
                        
                        if(progressNumber > 9000) {
                            progressBar.css('background-color', 'red');
                        }
                    }
                    
                    progressBar.css('width', ((progressNumber/100)/1.2) + '%');
                    progressBar.attr('aria-valuenow', progressNumber);
                }, 10);
            </script>
        <%}%>
        <%if(session.getAttribute("user.login")==null){%>
            <div class="container">
                <div class="row">
                    <p>É preciso estar autenticado para acessar o conteúdo desta página.</p>
                </div>
            </div>
        <%}else{%>
            <%if(requestException != null){%>
                <div class="container">
                    <div class="row">
                        <div class="h4">Ah, Não! Ocorreu um erro, contate o administrador do sistema.
                            <div style="color:red" class="h6"><%= requestException.getMessage() %></div>
                        </div>
                    </div>
                </div>
            <%} else {%>
                <%if(request.getParameter("submitQuiz")==null){%>
                    <div class="container">
                        <div class="row">
                            <form method="post">
                                <div class="d-flex">
                                    <h4>Escolha a categoria do Quiz:&nbsp;</h4>
                                    <select class="ml-2" id="categoryEnum" name="categoryEnumId">
                                        <option value="0">Geral</option>
                                        <%for(CategoryEnum c: CategoryEnum.getList()){%>
                                            <option value="<%= c.getId()%>" <%= request.getParameter("categoryEnumId") != null && c.getId() == Long.parseLong(request.getParameter("categoryEnumId")) ? "selected" : "" %>>
                                                <%= c.getName() %>
                                            </option>
                                        <%}%>
                                    </select>
                                    <input type="submit" class="btn btn-outline-primary ml-3 pb-0 pt-0" name="categoria" value="GAME!"/>
                                </div>
                            </form>
                        </div>
                        <div class="row mt-4">
                            <div class="col-sm-10"></div>
                            <div class="col-sm-2">
                                <h4>Tempo: <sapn id="tempo">2:00</sapn></h4>
                            </div>
                        </div>
                    </div>

                    <%if(request.getParameter("categoryEnumId")!=null){%>           
                        <form method="post" id="form-questions" name="questionForm" onsubmit="return isValidForm()">
                            <%int i = 1;%>
                            <%for (Question question : Question.getTenQuestionsRandomByCategory(Long.parseLong(request.getParameter("categoryEnumId")))) {%>
                                <div class="container">
                                    <div class="shadow-lg p-2 m-4 bg-light rounded">
                                        <p class="ml-4 mt-2 font-weight-bold h3"><%=i%>ª Questão</p>
                                        <hr class="mb-4">
                                        <div class="form-group mb-4">
                                            <p class="ml-4 mt-2 h4" id="question-<%=i%>"><%= question.getQuestion() %></p>
                                            <input type="hidden" name="question-drawn-<%=i%>" value="<%=question.getRowId()%>"/>
                                        </div>
                                        <%
                                        Random random = new Random();
                                        ArrayList<Integer> list = new ArrayList<>(3);
                                        while(list.size()<3) {
                                            int n = random.nextInt(3)+1;
                                            if (!list.contains(n)) {
                                                list.add(n);
                                        %>

                                                <% if (!(question.getAnswer(n) == null || question.getAnswer(n) == "null")) {%>
                                                    <div class="form-group form-check ml-4 mt-2 h5">
                                                        <input class="form-check-input mt-1" style="height: 17px; width: 17px;" type="radio" name="answer-<%=i%>" id="answer-<%=i%>-<%=n%>" value="<%=n%>" >
                                                        <label class="form-check-label ml-2" for="answer-<%=i%>-<%=n%>">
                                                            <%= question.getAnswer(n)%>
                                                        </label>
                                                    </div>
                                                <%}%>

                                            <%}%>
                                        <%}%>
                                    </div>
                                </div>                        
                                <%i++;%>
                            <%}%>
                            <!--Enviar Quiz-->
                            <div class="text-right">
                                <input type="hidden" name="categoriaGame" value="<%=request.getParameter("categoryEnumId")%>"/>
                                <button class="col-md-2 mr-4 mb-3 mt-3 btn btn-outline-primary" type="submit" name="submitQuiz">Enviar</button>
                            </div>    
                        </form>
                    <%}%>
                <%} else {%>
                    <div class="container">
                        <%if (pontos < 40) {%>
                            <div class="row justify-content-center mb-3">
                                <p class="font-weight-bold h3">RESULTADO: <%=pontos%>/100 pontos</P>
                            </div>
                            <div class="row justify-content-center mb-5">
                                <img class="img-thumbnail img-quiz" src="<%= request.getContextPath() %>/images/burro.jpg" alt="Você é burro!">                        
                            </div>
                        <%} else if (pontos < 70) {%>
                            <div class="row justify-content-center mb-3">
                                <p class="font-weight-bold h3">RESULTADO: <%=pontos%>/100 pontos</P>
                            </div>
                            <div class="row justify-content-center mb-5">
                                <img class="img-thumbnail img-quiz" src="<%= request.getContextPath() %>/images/mediocre.png" alt="Mais ou menos!" >
                            </div>
                        <%} else {%>
                            <div class="row justify-content-center mb-3">
                                <p class="font-weight-bold h3">RESULTADO: <%=pontos%>/100 pontos</P>
                            </div>
                            <div class="row justify-content-center mb-5">
                                <img class="img-thumbnail img-quiz" src="<%= request.getContextPath() %>/images/einstein.jpg" alt="Einstein!" >
                            </div>
                        <%}%>
                        
                        <div class="row justify-content-center mb-5">
                            <button class="btn btn-outline-primary" type="submit" onclick="showAnswers('answersList')">Ver Respostas</button>
                        </div>
                        
                        <script>
                            function showAnswers(el) {
                                var div = document.getElementById(el);
                                var disp = div.style.display;
                                div.style.display = disp == 'none' ? 'block' : 'none';
                                document.getElementById("answersList").scrollIntoView({block:"nearest", behavior: 'smooth'});
                            }
                        </script>
                        
                        <div id="answersList" style="display:none" class="col-12">
                            <div class="shadow rounded mb-5">
                                <div class="card">
                                    <div class="card-header ">
                                        <h5 class="mt-2 mb-2"><strong>Respostas do Quiz</strong></h5>
                                    </div>
                                    <div class="card-body mt-3 ml-3 mr-3">
                                        <ol>   
                                            <%for (int rowId : questionDrawn) {
                                                Question question = Question.getQuestionAndAnswers(rowId);
                                            %>
                                                <div class="row justify-content-center">
                                                    <div class="col-sm-12">
                                                        <em><li class="h6"><%= question.getQuestion() %></li></em>
                                                        <p class="mb-4 text-danger"><em><strong>R.</strong> <span class="text-secondary"><%= question.getAnswer1() %></span></em></p>
                                                    </div>
                                                </div>
                                            <%}%>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                                        
                    </div>
                <%}%>
            <%}%>
        <%}%>
        
        <footer>
          <%@include file="/WEB-INF/jspf/rodape.jspf" %>
        </footer>
    </body>
</html>