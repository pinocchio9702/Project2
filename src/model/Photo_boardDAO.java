package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class Photo_boardDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public Photo_boardDAO(String driver, String url, String id, String pw) {
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
	
	
	
	// 게시물을 가져와서 ResultSet형태로 반환
	public List<Photo_boardDTO> selectListPhotoBoard() {
		// 리스트 컬렉션을 생성
		List<Photo_boardDTO> bbs = new Vector<Photo_boardDTO>();
		// 기본 쿼리문
		String sql = "SELECT * FROM photo_board  "
				+ "   ORDER BY NUM DESC LIMIT 6";

		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			// 오라클이 반환해주는 Result의 갯수만큼 반복
			while (rs.next()) {
				// 하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체생성
				Photo_boardDTO dto = new Photo_boardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setPostdate(rs.getDate(4));
				dto.setVisitcount(rs.getInt(5));
				dto.setImage(rs.getString(6));
				dto.setImage_path(rs.getString(7));
				dto.setId(rs.getString(8));


				bbs.add(dto);
				System.out.println("쿼리 토스 성공");
			}
		} catch (Exception e) {
			System.out.println("select시 예외발생");
			e.printStackTrace();
		}

		return bbs;

	}
}
