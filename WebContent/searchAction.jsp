<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="mutube" class="mutube.Search" scope="page" />
<jsp:setProperty name="mutube" property="keyword" />
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

		String keyword = null;
		if (request.getParameter("keyword") != null) {
			keyword = (String)(request.getParameter("keyword"));
		}

		if (keyword == null|| keyword.equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('검색어를 입력하세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='search.jsp?keyword="+keyword+"'");
			script.println("</script>");
		}
	%>
</body>
</html>