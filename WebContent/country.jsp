<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					<li><a href="music.jsp">음악 자유 게시판</a></li>
					<li><a href="artist.jsp">아티스트</a></li>
					<li><a href="genre.jsp">장르</a></li>
					<li class="select"><a href="country.jsp">국가</a></li>
					<li><a href="instrument.jsp">악기</a></li>
				</ul>
			</li>
		</ul>
	</div>

	<div class="col-xs-9">
		<!-- Tab panes -->
		<div class="tab-content">
			<div class="tab-pane active" id="country">
				<div class="content">
					<h2>나라</h2>
					<br>
					<hr>
					<br> <br>
					<table class="country">
						<tr>
							<td><a href="buttonAction.jsp?cat=country&value=korea"><img src="img/country/south_korea.png" alt="sorry" country="value"></a></td>
							<td><a href="buttonAction.jsp?cat=country&value=japan"><img src="img/country/japan.png" alt="sorry" country="value"></a></td>
							<td><a href="buttonAction.jsp?cat=country&value=USA"><img src="img/country/USA.png" alt="sorry" country="value"></a></td>
							<td><a href="buttonAction.jsp?cat=country&value=germany"><img src="img/country/germany.png" alt="sorry" country="value"></a></td>
						</tr>
						<tr>
							<td>대한민국</td>
							<td>일본</td>
							<td>미국</td>
							<td>독일</td>
						</tr>
					</table>
					<br> <br> <br> <br>
					<table class="country">
						<tr>
							<td><a href="buttonAction.jsp?cat=country&value=china"><img src="img/country/china.png" alt="sorry" country="value"></a></td>
							<td><a href="buttonAction.jsp?cat=country&value=spain"><img src="img/country/spain.png" alt="sorry" country="value"></a></td>
							<td><a href="buttonAction.jsp?cat=country&value=england"><img src="img/country/England.jpg" alt="sorry" country="value"></a></td>
							<td><a href="buttonAction.jsp?cat=country&value=france"><img src="img/country/france.png" alt="sorry" country="value"></a></td>
						</tr>
						<tr>
							<td>중국</td>
							<td>스페인</td>
							<td>영국</td>
							<td>프랑스</td>
						</tr>
					</table>
					<br> <br> <br> <br>
					<table class="country">
						<tr>
							<td><a href="buttonAction.jsp?cat=country&value=russia"><img src="img/country/russia.png" alt="sorry" country="value"></a></td>
						</tr>
						<tr>
							<td>러시아</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> <script
		src="js/bootstrap.js"></script>
</body>
</html>