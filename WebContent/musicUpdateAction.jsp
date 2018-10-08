<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.Music"%>
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
		int pn = 0;
		if (request.getParameter("pn") != null) {
			pn = Integer.parseInt(request.getParameter("pn"));
		}
		if (pn == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='music.jsp'");
			script.println("</script>");
		}
		String video_link = null;
		
		if(request.getParameter("video_link")!=null){
			video_link = (String) request.getParameter("video_link");
		}
		
		String content = request.getParameter("content");
		content = content.replace("\r\n","<br>");

		//데이터베이스 작업
		Music music = new MusicDAO().getMusic(pn);
		// 권한이 없는 사용자라면
		if (!uid.equals(music.getUid())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'music.jsp'");
			script.println("</script>");
		} else { // 권한이 있는 사용자인데 입력이 다 안되었다면  
			if (request.getParameter("music_title") == null || request.getParameter("content") == null
					|| request.getParameter("music_title") == null || request.getParameter("music_title").equals("")
					|| request.getParameter("content").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else { // 정상적으로 입력이 잘 되었다면 
				MusicDAO musicDAO = new MusicDAO();
				int result = 0;
				if(video_link.length() > 10){
					result = musicDAO.update(pn, request.getParameter("music_title"),
						content,request.getParameter("video_link"));
				}else{
					result = musicDAO.update(pn, request.getParameter("music_title"),
							content,null);
				}
				
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'music.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>