<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mutube.Music"%>
<%@ page import="mutube.MusicDAO"%>
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
		if(uid == null){
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('로그인을 하세요.')");
		      script.println("location.href='login.jsp'");
		      script.println("</script>");
		   }
				
		   int pn=0;
		   if(request.getParameter("pn")!=null){
			   pn = Integer.parseInt(request.getParameter("pn"));
		   }               
		   if(pn == 0){
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('유효하지 않은 글입니다.')");
		      script.println("location.href='music.jsp'");
		      script.println("</script>");
		   }
				
		   //작성한 글이 본인인지 확인
		   Music music = new MusicDAO().getMusic(pn);
		   if(!uid.equals(music.getUid())){
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('권한이 없습니다.')");
		      script.println("location.href='music.jsp'");
		      script.println("</script>");
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
		
		<ul class="nav navbar-nav navbar-right">
			<li><a href="logoutAction.jsp">로그아웃</a></li>
			<li><a href="myPageCheck.jsp">마이페이지</a></li>
		</ul>
	</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="musicUpdateAction.jsp?pn=<%=music.getPn()%>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #eeeeee; text-align: center;">음악게시판
								글쓰기 양식</th>

						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="3"><select name="cat" onselect="check()"
								class="form-control">
									<option name="" value="">게시판을 선택하세요</option>
									<option value="free"><a href="freeWrite.jsp">자유게시판</a></option>
									<option selected="" value="music">음악</option>
							</select></td>
						</tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="아티스트 이름을 입력하세요" name="name" value="<%=music.getName()%>"></td>
							<td colspan="2"><input type="text" class="form-control"
								placeholder="글 제목" name="music_title" maxlength="50" value="<%=music.getMusic_title()%>"></td>
						</tr>
						<tr>
							<td><select name="country" class="form-control">
									<option value="">국가를 선택하세요</option>
									<option value="korea">Korea</option>
									<option value="japan">Japan</option>
									<option value="usa">USA</option>
									<option value="germany">Germany</option>
									<option value="china">China</option>
									<option value="spain">Spain</option>
									<option value="england">England</option>
									<option value="france">France</option>
									<option value="russia">Russia</option>
							</select></td>
							<td><select name="genre" class="form-control">
									<option name="" value="">장르를 선택하세요</option>
									<option value="blues">Blues</option>
									<option value="rock">Rock</option>
									<option value="jazz">Jazz</option>
									<option value="r&b">R&B</option>
									<option value="funk">Funk</option>
									<option value="hiphop">HipHop</option>
									<option value="metal">Metal</option>
									<option value="edm">EDM</option>
									<option value="classic">Classic</option>
									<option value="gospel">Gospel</option>
									<option value="band">Band</option>
									<option value="fusion_jazz">Fusion_jazz</option>
							</select></td>
							<td><select name="instrument" class="form-control">
									<option name="" value="">악기를 선택하세요</option>
									<option value="guitar">Guitar</option>
									<option value="bass">Bass</option>
									<option value="vocal">Vocal</option>
									<option value="durm">Drum</option>
									<option value="piano">Piano</option>
									<option value="trumpet">Trumpet</option>
									<option value="saxophone">SaxoPhone</option>
									<option value="trombone">Trombone</option>
									<option value="a_guitar">Acoustic_Guitar</option>
									<option value="contrabass">ContraBass</option>
							</select></td>
						</tr>
						<tr>
							<td colspan="3">비디오 링크<input type="text"
								class="form-control" name="video_link"
								placeholder="Youtube의 비디오 링크를 붙여 넣어 주세요, 한 글당 하나씩 입력 가능합니다." 
								<% if(music.getVideo_link()!=null){ %> value="<%=music.getVideo_link()%>" <%} %>></td>
						</tr>
						<tr>
							<td colspan="3"><textarea class="form-control"
									placeholder="동영상에 대한 간단한 설명을 적어주세요" name="content"
									maxlength="1024" style="height: 350px;"><%=music.getContent() %></textarea></td>
						</tr>

					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>