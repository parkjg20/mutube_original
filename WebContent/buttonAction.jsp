<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="mutube" class="mutube.Search" scope="page" />
<jsp:setProperty name="mutube" property="cat" />
<jsp:setProperty name="mutube" property="value" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mutube: searchAction</title>
</head>
<body>
	<%
		String uid = null;
		if (session.getAttribute("uid") != null) {
			uid = (String) session.getAttribute("uid");
		}
	
		String cat = null;
		if (request.getParameter("cat") != null) {
			cat = (String)(request.getParameter("cat"));
		}
		
		String value = null;
		if (request.getParameter("value") != null) {
			value = (String)(request.getParameter("value"));
		}
		
		if (cat == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('cat검색어를 입력하세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			if (value == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('value검색어를 입력하세요')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='search.jsp?cat="+cat+"&value="+value+"'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>