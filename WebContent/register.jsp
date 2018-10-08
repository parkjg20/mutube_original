<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Open+Sans" rel="stylesheet">
</head>
<body>
	
	<div class="login">
		<div class="jumbotron">
			<form method="post" action="registerAction.jsp">
				<h2>회원 가입</h2>
				<div class="form-group">
					<input type="text" name="uid" id="uid" minlength="8" maxlength="20"
						placeholder="아이디" class="form-control"><br> <input
						type="text" name="name" id="name" class="form-control"
						placeholder="이름"><br> <input type="text"
						name="nickname" id="nickname" minlength="2" maxlength="10"
						class="form-control" placeholder="닉네임"><br> <input
						type="password" name="pw" id="pw" class="form-control"
						minlength="8" maxlength="20" placeholder="비밀번호"><br>
					<input type="password" name="pw_ch" id="pw_ch" class="form-control"
						minlength="8" maxlength="20" placeholder="비밀번호 확인"><br>
					<input type="email" name="email" id="email" class="form-control"
						placeholder="이메일"><br> <select name="pw_q" id="pw_q"
						class="form-control">
						<option>비밀번호 확인 질문</option>
						<option name="q1" value="나의 보물1호">나의 보물1호</option>
						<option name="q2" value="처음 키운 애완동물의 종류는?">처음 키운 애완동물의
							종류는?</option>
						<option name="q3" value="가장 좋아하는 음식?">가장 좋아하는 음식?</option>
						<option name="q4" value="가장 좋아하는 색">가장 좋아하는 색</option>
						<option name="q5" value="나의 초등학교 이름은?">나의 초등학교 이름은?</option>
					</select><br> <input type="text" name="pw_a" id="pw_a"
						class="form-control" palceholder="답"><br> <input
						type="submit" class="form-control btn btn-primary"
						onclick="register()" value="회원가입"> <input type="button"
						class="form-control btn btn-alert" onclick="history.back();"
						value="취소">
				</div>
			</form>
		</div>
	</div>
	<script src="js/register.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>