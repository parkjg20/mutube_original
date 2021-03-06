<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.Free"%>
<%@ page import="mutube.FreeDAO"%>
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
		int pn = 0;
		if (request.getParameter("pn") != null) {
			pn = Integer.parseInt(request.getParameter("pn"));
		}
		if (pn == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='free.jsp'");
			script.println("</script>");
		}

		//데이터베이스 작업
		Free free = new FreeDAO().getFree(pn);
		// 권한이 없는 사용자라면
		if (!uid.equals(free.getUid())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'free.jsp'");
			script.println("</script>");
		} else{  // 권한이 있는 사용자라면   	
		    FreeDAO freeDAO = new FreeDAO();
		    int result = freeDAO.delete(pn);	
		    if(result == -1){
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('글 삭제에 실패했습니다.')");
		      script.println("history.back()");
		      script.println("</script>");
		   }else{					
		      PrintWriter script = response.getWriter();
		      freeDAO.deleteReply(0 ,pn);
		      script.println("<script>");
		      script.println("location.href = 'free.jsp'");
		      script.println("</script>");
		   }						
		}
	%>
</body>
</html>