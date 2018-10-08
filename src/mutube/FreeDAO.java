package mutube;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class FreeDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	Date d = new Date();
	String today;

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public FreeDAO() {
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
	public ArrayList<Free> getLate(){
		ArrayList<Free> list = new ArrayList();
		String SQL = "Select * from free where a = 1 order by pn desc limit 5";
		try {
			pstmt = conn.prepareStatement(SQL);
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
	public ArrayList<Free> search(String keyword,int pageNumber) {

		String SQL = "Select * from free where pn <= ? AND title like ? AND a = 1 ORDER BY pn DESC LIMIT 7 ";
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
		String SQL = "SELECT pn FROM Free ORDER BY pn DESC";
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

	public int write(String title, String uid, String content) {
		today = sdf.format(d);
		String SQL = "INSERT INTO free VALUES (0, ?, ?, ?, null,'" + today + "', 1)";
	
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
	
	
	public Free getFree(int pn) {
		String SQL = "SELECT * FROM Free WHERE pn = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pn);
			rs = pstmt.executeQuery();
			System.out.println(pn);
			if (rs.next()) {
				Free free = new Free();
				free.setPn(rs.getInt(1));
				free.setUid(rs.getString(2));
				free.setTitle(rs.getString(3));
				free.setContent(rs.getString(4));
				free.setPost_date(rs.getString(6));
				return free;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 해당글이 존재하지 않을 때
	}
	
	public int writeReply(int pn, String uid, String content) {
		today = sdf.format(d);
		System.out.println(today);

		String SQL = "INSERT INTO freply VALUES (0, ?, ?, ?, 1 ,'" + today + "')";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pn);
			pstmt.setString(2, uid);
			pstmt.setString(3, content);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public Freply getFreply(int dn) {
		String SQL = "SELECT * FROM Freply WHERE dn = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, dn);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Freply freply = new Freply();
				freply.setDn(rs.getInt(1));
				freply.setPn(rs.getInt(2));
				freply.setUid(rs.getString(3));
				freply.setContent(rs.getString(4));
				freply.setDate(rs.getString(6));
				return freply;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 해당글이 존재하지 않을 때
	}
	
	public ArrayList<Freply> getReply(int pageNumber, int pn) {
		String SQL = "SELECT * FROM Freply WHERE dn < ? AND a = 1 AND pn=? ORDER BY pn DESC LIMIT 10";
		ArrayList<Freply> list = new ArrayList<Freply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			pstmt.setInt(2, pn);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Freply freply = new Freply();
				freply.setDn(rs.getInt(1));
				freply.setPn(rs.getInt(2));
				freply.setUid(rs.getString(3));
				freply.setContent(rs.getString(4));
				freply.setDate(rs.getString(6));
				list.add(freply);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public int deleteReply(int dn) {
		String SQL = "UPDATE freply SET a = 0 WHERE dn = ?"; // a 값을 0으로 변경
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, dn);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public int deleteReply(int dn, int pn) {
		String SQL = "UPDATE freply SET a = 0 WHERE pn = ?"; // a 값을 0으로 변경
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pn);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public ArrayList<Free> getList(int pageNumber) {
		String SQL = "SELECT * FROM Free WHERE pn < ? AND a = 1 ORDER BY pn DESC LIMIT 10";
		ArrayList<Free> list = new ArrayList<Free>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
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
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM free WHERE pn < ? AND a = 1";
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
		String SQL = "UPDATE Free SET title = ?, content = ? WHERE pn = ? ";
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
		String SQL = "UPDATE free SET a = 0 WHERE pn = ?"; // a 값을 0으로 변경
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
