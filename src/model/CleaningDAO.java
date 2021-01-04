package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class CleaningDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public CleaningDAO(String driver, String url, String id, String pw) {
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
	
	public int insertCleaning(CleaningDTO dto) {
		int affected = 0;
		
		try {
			String sql = "INSERT INTO cleaning ( " 
					+ "  id, USER, location, phone, mobile, cleantype, AREA, clean_date, ask, matters)  "
					+ "  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getUSER());
			psmt.setString(3, dto.getLocation());
			psmt.setString(4, dto.getPhone());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getCleantype());
			psmt.setString(7, dto.getAREA());
			psmt.setString(8, dto.getClean_date());
			psmt.setString(9, dto.getAsk());
			psmt.setString(10, dto.getMatters());


			affected = psmt.executeUpdate();
			System.out.println(affected);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return affected;
	}
	
	public List<CleaningDTO> selectCleaingList() {

		List<CleaningDTO> bbs = new Vector<CleaningDTO>();

		// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
		String sql = "  " 
				+ "     SELECT * FROM cleaning ";

		System.out.println("쿼리문 : " + sql);

		try {

			psmt = con.prepareStatement(sql);

		

			rs = psmt.executeQuery();

			while (rs.next()) {
				CleaningDTO dto = new CleaningDTO();

				dto.setNum(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setUSER(rs.getString(3));
				dto.setLocation(rs.getString(4));
				dto.setPhone(rs.getString(5));
				dto.setMobile(rs.getString(6));
				dto.setCleantype(rs.getString(7));
				dto.setAREA(rs.getString(8));
				dto.setClean_date(rs.getString(9));
				dto.setAsk(rs.getString(10));
				dto.setMatters(rs.getString(11));

				bbs.add(dto);
			}

		} catch (Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}

		return bbs;

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
