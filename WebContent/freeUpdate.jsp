<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.Free"%>
<%@ page import="mutube.FreeDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mutube:</title>

<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Open+Sans" rel="stylesheet">
</head>
<body>
	<%
		String uid = null;
		if (session.getAttribute("uid") != null) {
			uid = (String) session.getAttribute("uid");
		}
		if(uid == null){
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('로그인을 하세요.')");
		      script.println("location.href='login.jsp'");
		      script.println("</script>");
		   }
				
		   int pn=0;
		   if(request.getParameter("pn")!=null){
			   pn = Integer.parseInt(request.getParameter("pn"));
		   }               
		   if(pn == 0){
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('유효하지 않은 글입니다.')");
		      script.println("location.href='free.jsp'");
		      script.println("</script>");
		   }
				
		   //작성한 글이 본인인지 확인
		   Free free = new FreeDAO().getFree(pn);
		   if(!uid.equals(free.getUid())){
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('권한이 없습니다.')");
		      script.println("location.href='free.jsp'");
		      script.println("</script>");
		   }
	%>

	<!-- navigation -->
	<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="main.jsp"> <img class="logo"
			src="img/mutube.PNG">
		</a>
	</div>
	<!-- search box -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav search">
			<li><input class="form-control" type="text"
				placeholder="검색어를 입력하세요"></li>
			<li><input type="image" class="search-button"
				src="img/search.png"></li>
		</ul>
		
		<ul class="nav navbar-nav navbar-right">
			<li><a href="logoutAction.jsp">로그아웃</a></li>
			<li><a href="myPageCheck.jsp">마이페이지</a></li>
		</ul>
	</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?pn=<%=pn%>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">자유게시판
								글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" value="<%=free.getTitle() %>" name="title" maxlength="50"></td>
						</tr>
						<tr>
							<td>이미지 첨부 <input type="file" class="form-control"
								name="img"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" 
									name="content" maxlength="1024" style="height: 350px;"><%= free.getContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>