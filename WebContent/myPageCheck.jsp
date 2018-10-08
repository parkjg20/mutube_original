<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="mutube.UserDAO"%>

<jsp:useBean id="mutube" class="mutube.User" scope="page" />
<jsp:setProperty name="mutube" property="uid" />
<jsp:setProperty name="mutube" property="pw" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Mutube:</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
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
					placeholder="�˻�� �Է��ϼ���"></li>
				<li><input type="image" class="search-button"
					src="img/search.png"></li>
			</ul>
		</form>
		<%
			if (uid == null) {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="login.jsp">�α���</a></li>
			<li><a href="register.jsp">ȸ������</a></li>
		</ul>
		<%
			} else {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="logoutAction.jsp">�α׾ƿ�</a></li>
			<li><a href="myPageCheck.jsp">����������</a></li>
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
			<li><a href="main.jsp">Home</a></li>
			<li><a href="notice.jsp">��������</a></li>
			<li><a href="free.jsp">�����Խ���</a></li>
			<li><a href="" class="sideber__category">����<i class="caret"></i></a>
			<ul class="sidebar__sub">	
				<li><a href="music.jsp">���� ���� �Խ���</a></li>
				<li class="active"><a href="artist.jsp">��Ƽ��Ʈ</a></li>
				<li><a href="genre.jsp">�帣</a></li>
				<li><a href="country.jsp">����</a></li>
				<li><a href="instrument.jsp">�Ǳ�</a></li>
			</ul>			
			</li>
		</ul>
	</div>

	<div class="col-xs-9">
		<!-- Tab panes -->
		<div class="tab-content">
			<div class="tab-pane active" id="mypage_check">
				<!-- content -->
				<div class="content">
					<div class="myPage">
						<form method="post" action="myPageCheckAction.jsp">
							<table>
								<tr>
									<td>��й�ȣ�� �Է����ּ���</td>
									<td><input type="password" name="pw" id="pw"  minlength="8" maxlength="20" placeholder="��й�ȣ"></td>							
									<td><button type="button" id="myPage_ch_btn" class="btn btn-primary">Ȯ��</button></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> <script
		src="js/bootstrap.js"></script>
</body>
</html>