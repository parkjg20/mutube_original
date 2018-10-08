<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	
<%@ page import="java.io.PrintWriter"%>
<%@ page import="mutube.UserDAO"%>
<%@ page import="mutube.User"%>
<jsp:useBean id="mutube" class="mutube.User" scope="page" />
<jsp:setProperty name="mutube" property="uid" />
<jsp:setProperty name="mutube" property="name" />
<jsp:setProperty name="mutube" property="nickname" />
<jsp:setProperty name="mutube" property="pw" />
<jsp:setProperty name="mutube" property="pw_q" />
<jsp:setProperty name="mutube" property="pw_a" />
<jsp:setProperty name="mutube" property="email" />
<jsp:setProperty name="mutube" property="register_date" />
<jsp:setProperty name="mutube" property="priv" />
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
			<div class="tab-pane active" id="myPage">
				<!-- content -->
				<div class="content">
					<div class="myPage">
						<form>
							<table>
							<% 
								UserDAO userDAO = new UserDAO();
								User user = userDAO.getUser(uid);
							%>
							<tr>
								<td>���̵�</td><td><input type="text" name="uid" id="uid" minlength="8" maxlength="20" placeholder="���̵�" value="<%=uid %>" readonly></td>		
							</tr>
							<tr>
								<td>�̸�</td><td><input type="text" name="name" id="name" placeholder="�̸�" value="<%=user.getName() %>"></td>		
							</tr>
							<tr>
								<td>�г���</td><td><input type="text"name="nickname" id="nickname" minlength="2" maxlength="10"  placeholder="�г���" value="<%=user.getNickname() %>"></td>		
							</tr>
							<tr>
								<td>��й�ȣ</td><td><input type="text" name="pw" id="pw"  minlength="8" maxlength="20" placeholder="��й�ȣ" value="<%=user.getPw() %>"></td>		
							</tr>
							<tr>
								<td>�̸���</td><td><input type="email" name="email" id="email"  placeholder="�̸���" value="<%=user.getEmail() %>"></td>		
							</tr>
							<tr>
								<td>��й�ȣ Ȯ�� ����</td><td><input type="text" name="pw_q" id="pw_q" value="<%=user.getPw_q() %>" readonly>
								</td>
							</tr>
							<tr>
								<td>��й�ȣ Ȯ�� ��</td><td><input type="text" name="pw_a" id="pw_a" palceholder="��" value="<%=user.getPw_a()%>"></td>
							</tr>
							<tr> 
								<td id="myPage__btn" colspan="2">  
									<input type="submit" class="btn btn-primary" value="Ȯ��"> 
									<input type="button" class="btn btn-default" onclick="location.href='main.jsp';" value="���">
								</td>
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