<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.NoticeDAO"%>
<%@ page import="mutube.Notice"%>
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
		int pn = 0;
		if (request.getParameter("pn") != null) {
			pn = Integer.parseInt(request.getParameter("pn"));
		}
		if (pn == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다. ')");
			script.println("location.href = 'notice.jsp'");
			script.println("</script>");
		}
		Notice notice = new NoticeDAO().getNotice(pn);

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
		<form method="post" action="searchAction.jsp">
			<ul class="nav navbar-nav search">
				<li><input class="form-control" name="keyword" type="text"
					placeholder="검색어를 입력하세요"></li>
				<li><input type="image" class="search-button"
					src="img/search.png"></li>
			</ul>
		</form>
		<%
			if (uid == null) {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="login.jsp">로그인</a></li>
			<li><a href="register.jsp">회원가입</a></li>
		</ul>
		<%
			} else {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="logoutAction.jsp">로그아웃</a></li>
			<li><a href="myPageCheck.jsp">마이페이지</a></li>
		</ul>
		<%
			}
		%>
	</div>
	</nav>
	
	<div class="col-xs-3">
		<!-- required for floating -->
		<!-- Nav tabs -->
		<ul class="nav nav-tabs tabs-left tabs-fixed">
			<li><a href="main.jsp">홈</a></li>
			<li class="select"><a href="notice.jsp">공지사항</a></li>
			<li><a href="free.jsp">자유게시판</a></li>
			<li><a href="" class="sideber__category">음악<i class="caret"></i></a>
				<ul class="sidebar__sub">
					<li><a href="music.jsp">음악 자유 게시판</a></li>
					<li><a href="artist.jsp">아티스트</a></li>
					<li><a href="genre.jsp">장르</a></li>
					<li><a href="country.jsp">국가</a></li>
					<li><a href="instrument.jsp">악기</a></li>
				</ul></li>
		</ul>
	</div>
	
	<div class="col-xs-9">
		<div class="container">
			<div class="row">
				<form method="post" action="writeAction.jsp">
					<table class="table"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="3"
									style="background-color: #eeeeee; text-align: center;">게시판
									글 보기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%">글 제목</td>
								<td colspan="2"><%=notice.getTitle()%></td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="2"><%=notice.getUid()%></td>
							</tr>
							<tr>
								<td>작성일자</td>
								<td colspan="2"><%=notice.getPost_date()%></td>
							</tr>
							<tr>
								<td>내용</td>
								<td colspan="2" style="min-height: 200px; text-align: left;"><%=notice.getContent()%></td>
							</tr>
						</tbody>
					</table>
					<a href="free.jsp" class="btn btn-primary">목록</a>
					<%
						if (uid != null && uid.equals(notice.getUid())) {
					%>
					<a href="update.jsp?pn=<%=pn%>" class="btn btn-primary">수정</a> <a
						onclick="return confirm('정말로 삭제하시겠습니까?')"
						href="deleteAction.jsp?pn=<%=pn%>" class="btn btn-primary">삭제</a>
					<%
						}
					%>
				</form>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>