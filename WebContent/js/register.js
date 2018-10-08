function register(){
		var patten1 = /[0-9]/;
		var patten2 = /[a-zA-z]/;
		var patten3 = /[~!@#$%^&*()_+|`\=-]/;
		var uid = document.getElementById('uid');
		//아이디를 입력 하지 않았을 경우
		if(uid.value == ""){
			alert("아이디를 입력하지 않았습니다.")
			uid.focus();
			return false;
		}
		//아이디 유효성 검사(영문과 숫자만 입력가능)
		if(!patten1.test(uid.value)|| !patten2.test(uid.value)){
			alert("아이디는 영문과 숫자만 쓸수 있습니다.");
			uid.focus();
			uid.select();
			return false;
		}
		//아이디에 공백이 있을 시.
		if(uid.value.indexOf(" ") >= 0){
			alert("아이디에 공백을 사용할수 없습니다.")
			uid.focus();
			uid.select();
			return false;
		}
		//아이디 길이가 넘거나 적을때.
		if(uid.value.length < 8 || uid.value.length > 20){
			alert("아이디의 길이는 8자~20자까지 입력 가능합니다.")
			uid.focus();
			uid.select();
			return false;
		}
		
		var name = document.getElementById('name');
		//이름이 공백일 시.
		if(name.value.indexOf == ""){
			alert("이름을 입력하지 않았습니다.");
			name.focus();
			return false;
		}
		//이름 길이 체크
		if(name.value.length < 3 || name.value.length > 4){
			alert("이름은 3자이상 4자 이하로 써주세요.");
			name.focus();
			name.select();
			return false;
		}

		var nick = document.getElementById('nick');
		//닉네임이 공백일 시.
		if(nick.value.indexOf == ""){
			alert("닉네임을 입력하지 않았습니다.");
			nick.focus();
			return false;
		}
		//길이 체크
		if(nick.value.length < 2 || nick.value.length > 10){
			alert("닉네임은 2자 이상 10자 이하로 써주세요.")
			nick.focus();
			nick.select();
			return false;
		}
		//특수문자 체크
		if(patten3.test(nick.value)){
			alert("닉네임에 특수문자를 넣을수 없습니다.")
			nick.focus();
			nick.select();
			return false;
		}	
		
		var pw = document.getElementById('pw');
		var pw_ch = document.getElementById('pw_ch');
		//비밀번호 유효성 체크.
		if(!patten1.test(pw.value)|| !patten2.test(pw.value)|| !patten3.test(pw.value)||pw.value.length < 8 || pw.value.length > 20){
			alert("영문+숫자+특수문자 8자리 이상 20자링 이하로 조합해주세요.");
			pw.focus();
			pw.select();
			return false;
		}
		//비밀번호 입력여부 체크
		if(pw.value.indexOf == ""){
			alert("비밀번호를 입력하지 않으셨습니다.");
			pw.focus();
			return false;
		}
		//아이디와 비밀번호가 같은지 체크
		if(uid.value == pw.value){
			alert("아이디와 비밀번호가 같습니다.");
			pw.focus();
			return false;
		}
		//비밀번호 확인
		if(!(pw.value == pw_ch.value)){
			alert("비밀번호가 다릅니다.");
			pw_ch.focus();
			pw_ch.select();
			return false;
		}

		var email = document.getElementById('email');
		var regex =  /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		//이메일이 공백일 시
		if(email.value.indexOf == ""){
			alert("이메일을 입력하지 않으셨습니다.");
			email.focus();
			return false;
		}
		//이메일 유효성 검사
		if(!regex.test(email.value)){
			alert("이메일 형식이 맞지 않습니다.")
			email.focus();
			email.select();
			return false;
		}

		var pw_a = document.getElementById('pw_a');
		//특수문자 체크
		if(pw_a.value.indexOf == ""){
			alert("답을 쓰지 않았습니다.")
			pw_a.focus();
			return false;
		}
		if(patten3.test(pw_a.value)){
			alert("특수문자는 넣을 수 없습니다.");
			pw_a.focus();
			return false;
		}
	}