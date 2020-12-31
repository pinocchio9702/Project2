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
	
	public boolean checkMembershipId(String id) {
		String query = "SELECT count(id) FROM membership WHERE id=?";
		boolean isFlag = false;
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			rs.next();
			int M_id = rs.getInt(1);
			if(M_id == 0) {
				isFlag = true;
			}
			else {
				isFlag = false;
			}
		}catch (Exception e) {
			//예외가 발생한다면 확인이 불가능함으로 무조건 false를 반환한다.
			e.printStackTrace();
		}
		
		return isFlag;
		
	}
	
	
	public int insertMember(MembershipDTO dto) {
		int affected = 0;
		try {
			String sql = "INSERT INTO membership(id, NAME, PASSWORD, telephone, phoneNumber, email, address, open_email)  "
					+ "   VALUES(?,?,?,?,?,?,?,?)";
					
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getPassword());
			psmt.setString(4, dto.getTelephone());
			psmt.setString(5, dto.getPhoneNumber());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getAddress());
			psmt.setString(8, dto.getOpen_email());

			affected = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return affected;
	}
	
	public int updateAdmin(String name, String email, String pw) {
		int affected = 0;
		try {
			String sql = "UPDATE membership SET grade = 'A'  "
					+ "   WHERE name=? AND email=? AND password=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);
			psmt.setString(3, pw);
			
			affected = psmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return affected;
	}
	
	public void close() {
		try {
			// 연결을 해제하는 것이 아니고 풀에 다시 반납한다.
			if (rs != null)
				rs.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
}
