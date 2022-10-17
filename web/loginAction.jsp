<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.UserDao" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
    UserDao userDao = new UserDao();
    int result = userDao.login(user.getUserID(), user.getUserPassword()); // login.jsp에서 입력받은 아이디와 비밀번호를 가져와서 로그인 함수에서 실행

   if(result == 1) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("location.href = 'main.jsp'");
      script.println("</script>");
    } else  if(result == 0) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('비밀번호가 틀립니다.')");
      script.println("history.back()"); // 다시 로그인 페이지로 돌려보냄
      script.println("</script>");
    } else  if(result == -1) {
     PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('존재하지 않는 아이디입니다.')");
     script.println("history.back()"); // 다시 로그인 페이지로 돌려보냄
     script.println("</script>");
   } else  if(result == -2) {
     PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('데이터베이스 오류입니다.')");
     script.println("history.back()"); // 다시 로그인 페이지로 돌려보냄
     script.println("</script>");
   }


%>

</body>
</html>

