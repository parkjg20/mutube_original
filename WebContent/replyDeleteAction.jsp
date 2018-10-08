<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.Freply"%>
<%@ page import="mutube.Mreply"%>
<%@ page import="mutube.FreeDAO"%>
<%@ page import="mutube.MusicDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mutube: writeAciton</title>
</head>
<body>
	<%
		String uid = null;
		if (session.getAttribute("uid") != null) {
			uid = (String) session.getAttribute("uid");
		}
		if (uid == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int dn =Integer.parseInt(request.getParameter("dn"));
		
		int pn = Integer.parseInt(request.getParameter("pn"));
		
		String cat = (String) request.getParameter("cat");
		
		
		if(cat.equals("free")){
	    	FreeDAO dao = new FreeDAO();
	    	Freply freply = dao.getFreply(dn);
	    	
	    	// 권한이 없는 사용자라면
			if (!uid.equals(freply.getUid())) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				int result = dao.deleteReply(dn);
			    if(result == -1){
			      PrintWriter script = response.getWriter();
			      script.println("<script>");
			      script.println("alert('댓글 삭제에 실패했습니다.')");
			      script.println("history.back()");
			      script.println("</script>");
			   }else{					
			      PrintWriter script = response.getWriter();
			      script.println("<script>");
			      script.println("location.href = 'freeView.jsp?pn="+pn+"'");
			      script.println("</script>");
			   }						
			}
		}else{
			MusicDAO dao = new MusicDAO();
			Mreply mreply = dao.getMreply(dn);
	    	// 권한이 없는 사용자라면
			if (!uid.equals(mreply.getUid())) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{

				int result = dao.deleteReply(dn);
			    if(result == -1){
			      PrintWriter script = response.getWriter();
			      script.println("<script>");
			      script.println("alert('댓글 삭제에 실패했습니다.')");
			      script.println("history.back()");
			      script.println("</script>");
			   }else{					
			      PrintWriter script = response.getWriter();
			      script.println("<script>");
			      script.println("location.href = 'musicView.jsp?pn="+pn+"'");
			      script.println("</script>");
			   }						
			}
		}
		
				
			%>
</body>
</html>