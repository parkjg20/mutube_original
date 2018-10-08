<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="mutube.FreeDAO"%>
<%@ page import="mutube.Free"%>
<%@ page import="mutube.MusicDAO"%>
<%@ page import="mutube.Music"%>
<%@ page import="mutube.NoticeDAO"%>
<%@ page import="mutube.Notice"%>
<%@ page import="mutube.Search"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mutube:</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

</head>
<body>
	<%
		String uid = null;
		if (session.getAttribute("uid") != null) {
			uid = (String) session.getAttribute("uid");
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
			<li><a href="login.jsp"></i>로그인</a></li>
			<li><a href="register.jsp">회원가입</a></li>
		</ul>
		<%
			} else {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="logoutAction.jsp">로그아웃</a></li>
			<li><a href="myPageCheck.jsp">마이페이지</i></a></li>
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
			<li class="select"><a href="main.jsp">홈</a></li>
			<li><a href="notice.jsp">공지사항</a></li>
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
		<!-- Tab panes -->
		<div class="tab-content">
			<div class="tab-pane active" id="home">
				<!-- content -->
				<div class="content" style="overflow: hidden">
					<div id="notice">
						<ul>
							<li class="notice">공지사항
								<hr>
								<div class="notice_board">
									<ul>
										<%
											NoticeDAO noticeDAO = new NoticeDAO();
											ArrayList<Notice> noticeList = noticeDAO.getLate();
											if (noticeList.size() == 0) {
										%>
										<li>최신글이 없습니다.</li>
										<%
											} else {
												for (int i = 0; i < noticeList.size(); i++) {
										%>
										<li><a
											href="noticeView.jsp?pn=<%=noticeList.get(i).getPn()%>"><%=noticeList.get(i).getTitle()%></a><br></li>
										<%
											}
											}
										%>

									</ul>
								</div>
							</li>
						</ul>
					</div>
					<div id="lately">
						<ul>
							<li class="lately">자유게시판 내 최신글
								<hr>
								<div class="free_board">
									<ul>
										<%
											FreeDAO freeDAO = new FreeDAO();
											ArrayList<Free> freeList = freeDAO.getLate();
											if (freeList.size() == 0) {
										%>
										<li>최신글이 없습니다.</li>
										<%
											} else {
												for (int i = 0; i < freeList.size(); i++) {
										%>
										<li><a
											href="freeView.jsp?pn=<%=freeList.get(i).getPn()%>"><%=freeList.get(i).getTitle()%></a><br></li>
										<%
											}
											}
										%>

									</ul>
								</div>
							</li>
							<li class="lately">음악 게시판 내 최신글
								<hr>
								<div class="music_board">
									<ul>
										<%
											MusicDAO musicDAO = new MusicDAO();
											ArrayList<Music> musicList = musicDAO.getLate();
											if (musicList.size() == 0) {
										%>
										<li>최신글이 없습니다.</li>
										<%
											} else {
												for (int i = 0; i < musicList.size(); i++) {
										%>
										<li><a
											href="freeView.jsp?pn=<%=musicList.get(i).getPn()%>"><%=musicList.get(i).getMusic_title()%></a></li>
										<%
											}
											}
										%>

									</ul>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
</body>
</html>