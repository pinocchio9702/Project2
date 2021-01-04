package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class CalendarDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public CalendarDAO(String driver, String url, String id, String pw) {
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
	
	public List<CalendarDTO> selectCalendar(){
		List<CalendarDTO> bbs = new Vector<CalendarDTO>();
		
		String query = " SELECT * FROM calendar";
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				CalendarDTO dto = new CalendarDTO();
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setCal_date(rs.getString(5));
				
				bbs.add(dto);
				
			}
		}catch (Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}

		return bbs;
	}
	
	public CalendarDTO selectView(String num) {
		
		CalendarDTO dto = new CalendarDTO();
		
		String query = " SELECT * FROM calendar "
				+ "	 WHERE num = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setCal_date(rs.getString(5));
				
			}
		}catch (Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public int insertCalendar(CalendarDTO dto) {
		int affected = 0;
		
		try {
			String sql = "INSERT INTO calendar ( " 
					+ "  id, title, content, cal_date)  "
					+ "  VALUES (?, ?, ?, ?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getCal_date());


			affected = psmt.executeUpdate();
			System.out.println(affected);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return affected;
	}
	
	public int delete(String num) {
		int affected = 0;
		try {
			String query = " DELETE FROM calendar  " + "  WHERE num=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);

			affected = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("delecte중 예외발생");
			e.printStackTrace();
		}

		return affected;
	}
	
	public int update(CalendarDTO dto) {
		int affected = 0;

		try {
			String query = "UPDATE calendar SET  " 
					+ "  title=?, content=?, cal_date=?"
					+ "  WHERE num=?";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getCal_date());
			psmt.setString(4, dto.getNum());

			affected = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("update중 예외발생");
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
