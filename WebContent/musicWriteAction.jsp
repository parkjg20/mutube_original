<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.MusicDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 자바빈즈 사용 -->
<jsp:useBean id="mutube" class="mutube.Music" scope="page" />
<jsp:setProperty name="mutube" property="name" />
<jsp:setProperty name="mutube" property="music_title" />
<jsp:setProperty name="mutube" property="content" />
<jsp:setProperty name="mutube" property="genre" />
<jsp:setProperty name="mutube" property="country" />
<jsp:setProperty name="mutube" property="instrument" />
<jsp:setProperty name="mutube" property="video_link" />

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
		
		if(uid==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}else{
			if(mutube.getName()==null || mutube.getContent()==null||
					mutube.getMusic_title()==null||mutube.getGenre()==null||
					mutube.getCountry()==null||mutube.getInstrument()==null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
			}else{
				MusicDAO musicDAO = new MusicDAO();
				int result;
				if(mutube.getVideo_link()!=null){
					result = musicDAO.write(uid, mutube.getName(), mutube.getCountry(), mutube.getGenre(), mutube.getInstrument(),
						mutube.getMusic_title(), mutube.getVideo_link(),mutube.getContent());	
				}else{
					result = musicDAO.write(uid, mutube.getName(), mutube.getCountry(), mutube.getGenre(), mutube.getInstrument(),
						mutube.getMusic_title(), mutube.getContent());	
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
					script.println("location.href='music.jsp'");
					script.println("</script>");
				}				
			}		
		}
	%>
</body>
</html>