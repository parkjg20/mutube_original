package mutube;

import java.sql.Date;

public class User {
	String uid;
	String name;
	String nickname;
	String pw;
	String pw_q;
	String pw_a;
	String email;
	String register_date;
	boolean priv;
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPw_q() {
		return pw_q;
	}
	public void setPw_q(String pw_q) {
		this.pw_q = pw_q;
	}
	public String getPw_a() {
		return pw_a;
	}
	public void setPw_a(String pw_a) {
		this.pw_a = pw_a;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public boolean isPriv() {
		return priv;
	}
	public void setPriv(boolean priv) {
		this.priv = priv;
	}

	
}
