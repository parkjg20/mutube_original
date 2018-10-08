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
		session.invalidate();
	%>
	<script>
		location.href = 'main.jsp';
	</script>
	%>
</body>
</html>