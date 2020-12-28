package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;


public class MembershipDAO {
	
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public MembershipDAO(String driver, String url, String id, String pw) {

		try {
			// prepare객체를 통해 쿼리문을 전송한다.
			// 생성자에서 연결정보를 저장한 커넥션 객체를 사용함
			Class.forName(driver);
			// DB에 연결된 정보를 맴버변수에 저장
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결 성공(디폴트생성자)");
		} catch (Exception e) {
			System.out.println("DB연결 실패(디폴트생성자)");
			e.printStackTrace();
		}
	}
	
	// 로그인 방법3 : DTO객체 대신 Map컬렉션에 회원정보를 저장후 반환한다.
	public Map<String, String> getMembershipMap(String id, String pwd) {

		// 회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();

		String query = "SELECT id, password, name FROM  " + "  membership WHERE id=? AND password=?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			rs = psmt.executeQuery();

			// 회원정보가 있다면 put()을 통해 정보를 저장한다.
			if (rs.next()) {
				// 결과가 있다면 DTO객체에 정보 저장
				maps.put("id", rs.getString(1));
				maps.put("password", rs.getString("password"));
				maps.put("name", rs.getString(3));
			} else {
				System.out.println("결과 셋이 없습니다.");
			}
		} catch (Exception e) {
			System.out.println("getMembershipDTO오류");
			e.printStackTrace();
		}
		return maps;
	}
	
	
	
	
	
}
