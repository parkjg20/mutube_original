<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.MusicDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 자바빈즈 사용 -->
<jsp:useBean id="mutube" class="mutube.Mreply" scope="page" />
<jsp:setProperty name="mutube" property="uid" />
<jsp:setProperty name="mutube" property="content" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mutube: freeWriteAciton</title>
</head>
<body>
	<%
		String uid=null;
		if(session.getAttribute("uid")!=null){
			uid=(String) session.getAttribute("uid");
		}
		
		int pn = 0;
		if(request.getParameter("pn")!=null){
			pn = Integer.parseInt(request.getParameter("pn"));
		}
		if(pn == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		String content = mutube.getContent();
		content = content.replace("\r\n","<br>");
		
		if(uid==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}else{
			if(mutube.getContent()==null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글을 입력하세요.')");
					script.println("history.back()");
					script.println("</script>");
			}else{
				MusicDAO musicDAO = new MusicDAO();
				int result = 0;
				if(mutube.getContent().length() < 4){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글이 너무 짧습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					result = musicDAO.writeReply(pn,uid,content);
				}
				if(result==-1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{					
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='musicView.jsp?pn="+pn+"'");
					script.println("</script>");
				}				
			}		
		}
	%>
</body>
</html>