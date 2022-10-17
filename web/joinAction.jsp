<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.UserDao" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
    if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
            || user.getUserGender() == null || user.getUserEmail() == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력되지 않은 정보가 있습니다.')");
        script.println("history.back()"); // 다시 로그인 페이지로 돌려보냄
        script.println("</script>");
    } else  {
        UserDao userDao = new UserDao();
        int result = userDao.join(user); // join 함수를 통해 우리가 입력받은 회원 가입 정보를 수행할 수 있게 해준다. user라는 인스턴스를 매개변수로 받음

        // 아이디 중복
        if(result == -1) { // db오류 ? 아이디 중복 -> 아이디는 이미 디비에서 프라이머리 키로 설정됐기 때문에 중복될 수 없다. 만약 디비 오류라면 아이디 중복임
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다.')");
            script.println("</script>");

            // 중복 없이 회원가입 완료
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp' ");
            script.println("</script>");
        }
    }



%>

</body>
</html>

