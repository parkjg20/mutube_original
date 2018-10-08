<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mutube: 로그인</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Open+Sans" rel="stylesheet">
</head>
<body>
	
	<div class="login">
		<div class="jumbotron">
			<form method="post" action="loginAction.jsp">
				<h2>로그인</h2>
				<div class="form-group">
					<input type="text" name="uid" id="uid" minlength="8"
						placeholder="아이디" class="form-control" maxlength="20">
				</div>
				<div class="form-group">
					<input type="password" name="pw" id="pw" minlength="8"
						maxlength="20" placeholder="비밀번호" class="form-control"><br>
					<br> <input type="submit" class="btn btn-primary form-control"
						value="login"> <input type="button"
						class="form-control btn btn-alert" onclick="history.back();"
						value="취소">
				</div>
				<div class="form-group">
					<a href="" style="margin-right: 40px">아이디 찾기</a> <a href="">비밀번호
						찾기</a>
				</div>
			</form>
		</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>