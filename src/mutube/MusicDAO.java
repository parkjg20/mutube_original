package mutube;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class MusicDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	Date d = new Date();
	String today;

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public MusicDAO() {
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

	public ArrayList<Music> search(String keyword,int pageNumber) {

		String SQL = "Select * from music where pn <= ? AND music_title like ? AND a = 1 ORDER BY pn DESC LIMIT 5 ";
		ArrayList<Music> list = new ArrayList();
		try {
			pstmt = conn.prepareStatement(SQL);
			keyword = "%"+keyword+"%";
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Music music = new Music();
				music.setPn(rs.getInt(1));
				music.setUid(rs.getString(2));
				music.setName(rs.getString(3));
				music.setCountry(rs.getString(4));
				music.setGenre(rs.getString(5));
				music.setInstrument(rs.getString(6));
				music.setMusic_title(rs.getString(7));
				music.setDate(rs.getString(11));
				list.add(music);
			}
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 뭔지 추적
		}
		return list;
	}
	public ArrayList<Music> search(String cat,String value,int pageNumber) {
		String SQL=null;
		if(cat.equals("name")) {
			SQL = "Select * from music where pn <= ? AND name like ? AND a = 1 ORDER BY pn DESC LIMIT 5 ";
		}
		else if(cat.equals("genre")) {
			SQL = "Select * from music where pn <= ? AND genre like ? AND a = 1 ORDER BY pn DESC LIMIT 5 ";
		}
		else if(cat.equals("country")) {
			SQL = "Select * from music where pn <= ? AND country like ? AND a = 1 ORDER BY pn DESC LIMIT 5 ";
		}
		else if(cat.equals("instrument")) {
			SQL = "Select * from music where pn <= ? AND instrument like ? AND a = 1 ORDER BY pn DESC LIMIT 5 ";
		}
		
		if(value.equals("혁오")||value.equals("hyukoh")){
			value = "hyuk oh";
		}else if(value.equals("크러쉬")||value.equals("크러시")) {
			value = "crush";
		}else if(value.equals("아이유")||value.equals("i.u")){
			value = "iu"; 
		}
		
		ArrayList<Music> list = new ArrayList();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			pstmt.setString(2, value);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Music music = new Music();
				music.setPn(rs.getInt(1));
				music.setUid(rs.getString(2));
				music.setName(rs.getString(3));
				music.setCountry(rs.getString(4));
				music.setGenre(rs.getString(5));
				music.setInstrument(rs.getString(6));
				music.setMusic_title(rs.getString(7));
				music.setVideo_link(rs.getString(8));
				music.setContent(rs.getString(9));
				music.setDate(rs.getString(11));
				list.add(music);
			}
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 뭔지 추적
		}
		return list;
	}
	public ArrayList<Music> getLate(){
		ArrayList<Music> list = new ArrayList();
		String SQL = "Select * from music where a = 1 order by pn desc limit 5";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Music music = new Music();
				music.setPn(rs.getInt(1));
				music.setUid(rs.getString(2));
				music.setName(rs.getString(3));
				music.setCountry(rs.getString(4));
				music.setGenre(rs.getString(5));
				music.setInstrument(rs.getString(6));
				music.setMusic_title(rs.getString(7));
				music.setVideo_link(rs.getString(8));
				music.setContent(rs.getString(9));
				music.setDate(rs.getString(11));
				list.add(music);
				
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
		String SQL = "SELECT pn FROM music ORDER BY pn DESC";
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

	public int write(String uid, String name, String country, String genre, String instrument, String music_title, String content) {
		today = sdf.format(d);
		System.out.println(today);
		String SQL = "INSERT INTO music VALUES (0, ?, ?, ?, ?, ?, ?, null, ?, 1, '"+today+"')";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			pstmt.setString(2, name);
			pstmt.setString(3, country);
			pstmt.setString(4, genre);
			pstmt.setString(5, instrument);
			pstmt.setString(6, music_title);
			pstmt.setString(7, content);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int write(String uid, String name, String country, String genre, String instrument, String music_title, String video_link, String content) {
		today = sdf.format(d);
		System.out.println(today);

		String SQL = "INSERT INTO music VALUES (0, ?, ?, ?, ?, ?, ?, ?, ?, 1, '"+today+"')";
		if (video_link.length() > 40) {
			boolean em = false;
			for (int i = 0; i < video_link.length(); i++) {
				if (video_link.charAt(i) == '&') {
					em = true;
					break;
				}
			}
			if (!em)
				video_link = video_link.substring(video_link.indexOf("v=") + 2);
			else
				video_link = video_link.substring((video_link.indexOf("v=") + 2), video_link.indexOf('&'));
		}else{
			video_link = video_link.substring(video_link.lastIndexOf('/'));
		}
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			pstmt.setString(2, name);
			pstmt.setString(3, country);
			pstmt.setString(4, genre);
			pstmt.setString(5, instrument);
			pstmt.setString(6, music_title);
			pstmt.setString(7, video_link);
			pstmt.setString(8, content);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public Music getMusic(int pn) {
		String SQL = "SELECT * FROM music WHERE pn = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pn);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				Music music = new Music();
				music.setPn(rs.getInt(1));
				music.setUid(rs.getString(2));
				music.setName(rs.getString(3));
				music.setCountry(rs.getString(4));
				music.setGenre(rs.getString(5));
				music.setInstrument(rs.getString(6));
				music.setMusic_title(rs.getString(7));
				music.setVideo_link(rs.getString(8));
				music.setContent(rs.getString(9));
				music.setDate(rs.getString(11));
				return music;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 해당글이 존재하지 않을 때
	}
	public int writeReply(int pn, String uid, String content) {
		today = sdf.format(d);
		System.out.println(today);

		String SQL = "INSERT INTO mreply VALUES (0, ?, ?, ?, 1 ,'" + today + "')";
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
	public Mreply getMreply(int dn) {
		String SQL = "SELECT * FROM mreply WHERE dn = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, dn);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Mreply mreply = new Mreply();
				mreply.setDn(rs.getInt(1));
				mreply.setPn(rs.getInt(2));
				mreply.setUid(rs.getString(3));
				mreply.setContent(rs.getString(4));
				mreply.setDate(rs.getString(6));
				return mreply;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 해당글이 존재하지 않을 때
	}
	
	public ArrayList<Mreply> getReply(int pageNumber, int pn) {
		String SQL = "SELECT * FROM mreply WHERE dn < ? AND a = 1 AND pn=? ORDER BY pn DESC LIMIT 10";
		ArrayList<Mreply> list = new ArrayList<Mreply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			pstmt.setInt(2, pn);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Mreply mreply = new Mreply();
				mreply.setDn(rs.getInt(1));
				mreply.setPn(rs.getInt(2));
				mreply.setUid(rs.getString(3));
				mreply.setContent(rs.getString(4));
				mreply.setDate(rs.getString(6));
				list.add(mreply);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int deleteReply(int dn) {
		String SQL = "UPDATE mreply SET a = 0 WHERE dn = ?"; // a 값을 0으로 변경
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, dn);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public ArrayList<Music> getList(int pageNumber) {
		String SQL = "SELECT * FROM music WHERE pn < ? AND a = 1 ORDER BY pn DESC LIMIT 10";
		ArrayList<Music> list = new ArrayList<Music>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Music music = new Music();
				music.setPn(rs.getInt(1));
				music.setUid(rs.getString(2));
				music.setName(rs.getString(3));
				music.setCountry(rs.getString(4));
				music.setGenre(rs.getString(5));
				music.setInstrument(rs.getString(6));
				music.setMusic_title(rs.getString(7));
				music.setVideo_link(rs.getString(8));
				music.setContent(rs.getString(9));
				music.setDate(rs.getString(11));
				list.add(music);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM music WHERE pn < ? AND a = 1";
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

	public int update(int pn, String music_title, String content, String video_link) {
		String SQL = "UPDATE Music SET music_title = ?, content = ?, video_link = ? WHERE pn = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, music_title);
			pstmt.setString(2, content);
			pstmt.setString(3, video_link);
			pstmt.setInt(4, pn);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int delete(int pn) {
		String SQL = "UPDATE music SET a = 0 WHERE pn = ?"; // a 값을 0으로 변경
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
