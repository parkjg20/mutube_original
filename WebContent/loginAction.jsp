<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 자바빈즈 사용 -->
<jsp:useBean id="mutube" class="mutube.User" scope="page" />
<jsp:setProperty name="mutube" property="uid" />
<jsp:setProperty name="mutube" property="name" />
<jsp:setProperty name="mutube" property="nickname" />
<jsp:setProperty name="mutube" property="pw" />
<jsp:setProperty name="mutube" property="pw_q" />
<jsp:setProperty name="mutube" property="pw_a" />
<jsp:setProperty name="mutube" property="email" />
<jsp:setProperty name="mutube" property="register_date" />
<jsp:setProperty name="mutube" property="priv" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String uid = null;
		if (session.getAttribute("uid") != null) {
			uid = (String) session.getAttribute("uid");
		}
		if (uid != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(mutube.getUid(), mutube.getPw());
		if (result == 1) { //로그인 성공
			session.setAttribute("uid", mutube.getUid());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if (result == 0) { // 비밀번호 불일치
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -1) { // 아이디 없음
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -2) { // 데이터베이스 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다. ')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>