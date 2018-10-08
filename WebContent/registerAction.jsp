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
		if(mutube.getUid()==null || mutube.getPw()==null ||
			mutube.getName()==null || mutube.getNickname()==null || 
			mutube.getPw_a()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.register(mutube);		
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다. ')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
			    session.setAttribute("uid",mutube.getUid());
			    PrintWriter script = response.getWriter();
			    script.println("<script>");
			    script.println("alert('회원가입이 완료되었습니다.')");
			    script.println("location.href='main.jsp'");
			    script.println("</script>");
			}		
		}		
	%>
</body>
</html>