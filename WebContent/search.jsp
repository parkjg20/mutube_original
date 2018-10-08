<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="mutube.FreeDAO"%>
<%@ page import="mutube.Free"%>
<%@ page import="mutube.MusicDAO"%>
<%@ page import="mutube.Music"%>
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
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Open+Sans"
	rel="stylesheet">
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
		String keyword = null;
		if (request.getParameter("keyword") != null) {
			keyword = (String) (request.getParameter("keyword"));
		}

		String cat = null;
		if (request.getParameter("cat") != null) {
			cat = (String) (request.getParameter("cat"));
		}

		String value = null;
		if (request.getParameter("value") != null) {
			value = (String) (request.getParameter("value"));
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
				<ul class="sidebar__sub">
					<li><a href="music.jsp">음악 자유 게시판</a></li>
					<li class="active"><a href="artist.jsp">아티스트</a></li>
					<li><a href="genre.jsp">장르</a></li>
					<li><a href="country.jsp">국가</a></li>
					<li><a href="instrument.jsp">악기</a></li>
				</ul></li>
		</ul>
	</div>

	<!-- Tab panes -->
	<div class="tab-content">
		<%
			if (cat == null) {
		%>
		<div class="container">
			<div class="row">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="4" style="background-color: #eeeeee; text-align: center;">자유게시판
								내 <%=keyword%> 검색 결과
							</th>

						</tr>
					</thead>
					<tbody>
						<%
							FreeDAO freeDAO = new FreeDAO();
								ArrayList<Free> list = freeDAO.search(keyword, pageNumber);
								
									if (list.size() < 1) {
										%>
										<tr>
											<td colspan="4">검색 결과가 없습니다.</td>
										</tr>
										<%
											} else {
												for (int i = 0; i < list.size(); i++) {
						%>
						<tr>
							<td colspan="2"><a
								href="freeView.jsp?pn=<%=list.get(i).getPn()%>"><%=list.get(i).getTitle()%></a></td>
							<td><%=list.get(i).getUid()%></td>
							<td><%=list.get(i).getPost_date()%></td>
						</tr>
						<%
							}}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<br> <br>
		<div class="container">
			<div class="row">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="4" style="background-color: #eeeeee; text-align: center;">음악게시판
								내 <%=keyword%> 검색 결과
							</th>
						</tr>
					</thead>
					<tbody>
						<%
							MusicDAO musicDAO = new MusicDAO();
								ArrayList<Music> list1 = musicDAO.search(keyword, pageNumber);
								if (list1.size() < 1) {
						%>
						<tr>
							<td colspan="4">검색 결과가 없습니다.</td>
						</tr>
						<%
							} else {
									for (int i = 0; i < list1.size(); i++) {
						%>
						<tr>
							<td colspan="2"><a
								href="musicView.jsp?pn=<%=list1.get(i).getPn()%>"><%=list1.get(i).getMusic_title()%></a></td>
							<td><%=list1.get(i).getUid()%></td>
							<td><%=list1.get(i).getDate()%></td>
						</tr>
						<%
							}
								}
						%>
					</tbody>
				</table>
			</div>

		</div>
		<%
			} else {
		%>
		<div>
			<div class="container">
				<div class="row">
					<table class="table table-striped"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #eeeeee; text-align: center;"><%=value%>에
									대한 <%=cat%>검색 결과</th>

							</tr>
						</thead>
						<tbody>
							<%
								MusicDAO musicDAO = new MusicDAO();
									ArrayList<Music> list1 = musicDAO.search(cat, value, pageNumber);
									if (list1.size() == 0) {
							%>
							<tr>
								<td colspan="3">검색 결과가 없습니다.</td>

							</tr>
							<%
								} else {
										for (int i = 0; i < list1.size(); i++) {
							%>
							<tr>
								<td colspan="2"><a
									href="musicView.jsp?pn=<%=list1.get(i).getPn()%>"><%=list1.get(i).getMusic_title()%></a></td>
								<td><%=list1.get(i).getUid()%></td>
								<td><%=list1.get(i).getDate()%></td>
							</tr>
							<%
								}
									}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<%
			}
			value = null;
			cat = null;
		%>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>