<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="mutube.MusicDAO"%>
<%@ page import="mutube.Music"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
		//현재 페이지 번호 알려주기 위한 처리
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<li><a href="notice.jsp">공지사항</a></li>
			<li><a href="free.jsp">자유게시판</a></li>
			<li><a href="" class="sideber__category">음악<i class="caret"></i></a>
				<ul class="sidebar__sub__fixed">
					<li class="select"><a href="music.jsp">음악 자유 게시판</a></li>
					<li><a href="artist.jsp">아티스트</a></li>
					<li><a href="genre.jsp">장르</a></li>
					<li><a href="country.jsp">국가</a></li>
					<li><a href="instrument.jsp">악기</a></li>
				</ul>
			</li>
		</ul>
	</div>

	<div class="col-xs-9">
		<!-- Tab panes -->
		<div class="tab-content">
			<div class="tab-pane active" id="music">
				<div class="container">
					<div class="row">
						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #eeeeee; text-align: center;">번호</th>
									<th style="background-color: #eeeeee; text-align: center;">제목</th>
									<th style="background-color: #eeeeee; text-align: center;">연주자</th>
									<th style="background-color: #eeeeee; text-align: center;">작성자</th>
									<th style="background-color: #eeeeee; text-align: center;">작성일</th>
								</tr>
							</thead>
							<tbody>
								<%
									MusicDAO musicDAO = new MusicDAO();
									ArrayList<Music> list = musicDAO.getList(pageNumber);
									for (int i = 0; i < list.size(); i++) {
								%>
								<tr>
									<td class="pn"><%=list.get(i).getPn()%></td>
									<td class="title"><a href="musicView.jsp?pn=<%=list.get(i).getPn()%>"><%=list.get(i).getMusic_title()%></a></td>
									<td class="name"><%=list.get(i).getName()%></td>
									<td class="uid"><%=list.get(i).getUid()%></td>
									<td class="date"><%=list.get(i).getDate()%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
						<span class="paging">
						<%
							if(pageNumber != 1){
						%>
						<a href="free.jsp?pageNumber=<%=pageNumber - 1%>"
							class="btn btn-primary btn-arrow-left">Previous</a>
						<%
							} if(musicDAO.nextPage(pageNumber)){
								int i=1;
								while(musicDAO.nextPage(i)){
									if(i==pageNumber){
								%>
						<a href="music.jsp?pageNumber=<%=i %>" class="btn btn-primary"><%=i %></a>
						<%	
									}	else{
										%>
						<a href="music.jsp?pageNumber=<%=i %>" class="btn btn-alert"><%=i %></a>
						<%
								}
									i++;
								}
								
							}
							if(musicDAO.nextPage(pageNumber + 1)){
						%>
						<a href="music.jsp?pageNumber=<%=pageNumber + 1%>"
							class="btn btn-primary btn-arrow-right">Next</a>
						<%
							}
						%>
						</span>
						<a href="musicWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
					</div>

				</div>
			</div>
		</div>

		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
</body>
</html>