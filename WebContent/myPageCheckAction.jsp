<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 자바빈즈 사용 -->
<jsp:useBean id="mutube" class="mutube.User" scope="page" />
<jsp:setProperty name="mutube" property="pw" />


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String uid = (String) session.getAttribute("uid");
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(uid, mutube.getPw());
		if (result == 1) { //로그인 성공
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'myPage.jsp'");
			script.println("</script>");
		} else if (result == 0) { // 비밀번호 불일치
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if (result == -2) { // 데이터베이스 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다. ')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>