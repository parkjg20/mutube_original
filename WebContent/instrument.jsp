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
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding|Open+Sans" rel="stylesheet">
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
		<ul class="nav navbar-nav search">
			<li><input class="form-control" type="text"
				placeholder="검색어를 입력하세요"></li>
			<li><input type="image" class="search-button"
				src="img/search.png"></li>
		</ul>
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
					<li class="active"><a href="artist.jsp">아티스트</a></li>
					<li><a href="genre.jsp">장르</a></li>
					<li><a href="country.jsp">국가</a></li>
					<li class="select"><a href="instrument.jsp">악기</a></li>
				</ul>
			</li>
		</ul>
	</div>

	<div class="col-xs-9">
		<!-- Tab panes -->
		<div class="tab-content">
			<div class="tab-pane active" id="instrument">
				<div class="content">
					<h2>악기</h2>
					<br>
					<hr>
					<br> <br>
					<table class="instrument">
						<tr>
							<td><a href="buttonAction.jsp?cat=instrument&value=guitar"><img src="img/instrument/guitar.jpg" alt="sorry" name="value"></a></td>
							<td><a href="buttonAction.jsp?cat=instrument&value=bass"><img src="img/instrument/bass.jpg" alt="sorry" name="value"></a></td>
							<td><a href="buttonAction.jsp?cat=instrument&value=vocal"><img src="img/instrument/vocal.jpg" alt="sorry" name="value"></a></td>
							<td><a href="buttonAction.jsp?cat=instrument&value=drum"><img src="img/instrument/drum.jpg" alt="sorry" name="value"></a></td>
						</tr>
						<tr>
							<td>Guitar</td>
							<td>Bass</td>
							<td>Vocal</td>
							<td>Drum</td>
						</tr>
					</table>
					<br> <br> <br> <br>
					<table class="instrument">
						<tr>
							<td><a href="buttonAction.jsp?cat=instrument&value=piano"><img src="img/instrument/piano.jpg" alt="sorry" name="value"></a></td>
							<td><a href="buttonAction.jsp?cat=instrument&value=trumpet"><img src="img/instrument/trumpet.jpg" alt="sorry" name="value"></a></td>
							<td><a href="buttonAction.jsp?cat=instrument&value=saxophone"><img src="img/instrument/saxophone.jpg" alt="sorry" name="value"></a></td>
							<td><a href="buttonAction.jsp?cat=instrument&value=trombone"><img src="img/instrument/trombone.jpg" alt="sorry" name="value"></a></td>
						</tr>
						<tr>
							<td>Piano</td>
							<td>Trumpet</td>
							<td>SaxoPhone</td>
							<td>Trombone</td>
						</tr>
					</table>
					<br> <br> <br> <br>
					<table class="instrument">
						<tr>
							<td><a href="buttonAction.jsp?cat=instrument&value=acoustic guitar"><img src="img/instrument/acoustic_guitar.jpg" alt="sorry" name="value"></a></td>
							<td><a href="buttonAction.jsp?cat=instrument&value=contrabass"><img src="img/instrument/Contrabass.jpg" alt="sorry" name="value"></a></td>
						</tr>
						<tr>
							<td>Acoustic Guitar</td>
							<td>ContraBass</td>
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