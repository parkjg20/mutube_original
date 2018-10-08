package mutube;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class NoticeDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	Date d = new Date();
	String today;

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public NoticeDAO() {
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

	public ArrayList<Free> search(String keyword,int pageNumber) {

		String SQL = "Select * from free where pn <= ? AND title like ? AND a = 1 ORDER BY pn DESC LIMIT 5 ";
		ArrayList<Free> list = new ArrayList();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			keyword = "%"+keyword+"%";		
			pstmt.setString(2, keyword);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Free free = new Free();
				free.setPn(rs.getInt(1));
				free.setUid(rs.getString(2));
				free.setTitle(rs.getString(3));
				free.setContent(rs.getString(4));
				free.setPost_date(rs.getString(6));
				list.add(free);
				
			}
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 뭔지 추적
		}
		return list;
	}

	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}

	public int getNext() {
		String SQL = "SELECT pn FROM notice ORDER BY pn DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public ArrayList<Notice> getLate(){
		ArrayList<Notice> list = new ArrayList();
		String SQL = "Select * from notice where a = 1 order by pn desc limit 5";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Notice notice = new Notice();
				notice.setPn(rs.getInt(1));
				notice.setUid(rs.getString(2));
				notice.setTitle(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setPost_date(rs.getString(5));
				list.add(notice);
				
			}
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 뭔지 추적
		}
		return list;
		
	}
	
	public int write(String uid, String title, String content) {
		today = sdf.format(d);

		String SQL = "INSERT INTO notice VALUES (0, ?, ?, ?, '" + today + "', 1)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public Notice getNotice(int pn) {
		String SQL = "SELECT * FROM notice WHERE pn = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pn);
			rs = pstmt.executeQuery();
			System.out.println(pn);
			if (rs.next()) {
				Notice notice = new Notice();
				notice.setPn(rs.getInt(1));
				notice.setUid(rs.getString(2));
				notice.setTitle(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setPost_date(rs.getString(5));
				return notice;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 해당글이 존재하지 않을 때
	}

	public ArrayList<Notice> getList(int pageNumber) {
		String SQL = "SELECT * FROM notice WHERE pn < ? AND a = 1 ORDER BY pn DESC LIMIT 10";
		ArrayList<Notice> list = new ArrayList<Notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Notice notice = new Notice();
				notice.setPn(rs.getInt(1));
				notice.setUid(rs.getString(2));
				notice.setTitle(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setPost_date(rs.getString(5));
				list.add(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM notice WHERE pn < ? AND a = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true; // 다음 페이지가 있다면 true를 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public int update(int pn, String title, String content) {
		String SQL = "UPDATE notice SET title = ?, content = ? WHERE pn = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, pn);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int delete(int pn) {
		String SQL = "UPDATE Notice SET a = 0 WHERE pn = ?"; // a 값을 0으로 변경
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pn);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

}