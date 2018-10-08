package mutube;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	Date d = new Date();
	String today = (d.getYear() + 1900) + "-" + (d.getMonth() + 1) + "-" + d.getDate();

	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/mutube?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "mysql";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public User getUser(String uid) {
			
			String SQL = "SELECT * FROM USER WHERE UID = '"+uid+"'";
			System.out.println(SQL);
			User user = new User();
			
			try {
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery(SQL);
				if(rs.next()) {
					user.setUid(rs.getString(1));
					user.setName(rs.getString(2));
					user.setNickname(rs.getString(3));
					user.setPw(rs.getString(4));
					user.setPw_q(rs.getString(5));
					user.setPw_a(rs.getString(6));
					user.setEmail(rs.getString(7));
					user.setRegister_date(rs.getString(8));
					user.setPriv(rs.getBoolean(9));		
				}
				System.out.println(user);
			}catch(Exception e){
				e.printStackTrace();
			}
			return user;
			
		}

	public int login(String uid, String pw) {
		String SQL = "SELECT pw FROM USER WHERE uid = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(pw)) {
					return 1; // 로그인 성공
				} else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 뭔지 추적
		}
		return -2; // 데이터베이스 오류
	}

	public int register(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?, ?,'" + today + "', false)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUid());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getNickname());
			pstmt.setString(4, user.getPw());
			pstmt.setString(5, user.getPw_q());
			pstmt.setString(6, user.getPw_a());
			pstmt.setString(7, user.getEmail());
			System.out.println(today);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
