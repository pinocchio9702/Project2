package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class GoodsDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public GoodsDAO(String driver, String url, String id, String pw) {
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
	
	public int getTotalRecordCountBoard(Map map) {
		// 게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		

		try {
			// 기본쿼리문(전체레코드를 대상으로 함)
			String sql = "SELECT COUNT(*) FROM goods";
			// JSP페이지에서 검색어를 입력한 경우 where절이 동적으로 추가된다.
			if (map.get("Word") != null) {
				sql += "   WHERE  " + map.get("Column") + " " + "  LIKE '%" + map.get("Word") + "%'";
			}

			System.out.println("query=" + sql);

			// 쿼리 실행후 결과값 반환
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
		}

		System.out.println(totalCount);

		return totalCount;
	}
	
	
	public List<GoodsDTO> selectListPageGoods(Map map) {

		List<GoodsDTO> bbs = new Vector<GoodsDTO>();

		// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
		String sql = "  " 
				+ "     SELECT * ,FORMAT(price, 0) FROM goods ";

		if (map.get("Word") != null) {
			sql += " WHERE  " + map.get("Column") + " " + " LIKE '%" + map.get("Word") + "%' ";
		}
		sql += " " + "       ORDER BY num DESC LIMIT ?, ? ";
		System.out.println("쿼리문 : " + sql);

		try {

			psmt = con.prepareStatement(sql);

			// JSP에서 계산한 페이지 범위값을 이용해 인파라미터를 설정함.
			psmt.setInt(1, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));

			rs = psmt.executeQuery();

			while (rs.next()) {
				GoodsDTO dto = new GoodsDTO();

				dto.setNum(rs.getInt(1));
				dto.setNAME(rs.getString(2));
				dto.setImage(rs.getString(3));
				dto.setImage_path(rs.getString(4));
				dto.setPrice(rs.getString(8));
				dto.setSaved(rs.getInt(6));
				dto.setExplan(rs.getString(7));

				bbs.add(dto);
			}

		} catch (Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}

		return bbs;

	}
	
	public GoodsDTO selectView(String num) {
		GoodsDTO dto = new GoodsDTO();
		
		String query = "  SELECT * ,FORMAT(price, 0) FROM goods  "
				+ "  WHERE num = ?";
		
		System.out.println("쿼리 문 : " + query);
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt(1));
				dto.setNAME(rs.getString(2));
				dto.setImage(rs.getString(3));
				dto.setImage_path(rs.getString(4));
				dto.setPrice(rs.getString(8));
				dto.setSaved(rs.getInt(6));
				dto.setExplan(rs.getString(7));
				
				System.out.println("dto에 저장된 일련번호 : " + dto.getNum());
				System.out.println("dto에 저장된 상품 번호 : " + dto.getNAME());
				System.out.println("dto에 저장된 상품 이미지: " + dto.getImage());
				System.out.println("dto에 저장된 상품 이미지 경로 : " + dto.getImage_path());
				System.out.println("dto에 저장된 상품 가격 : " + dto.getPrice());
				System.out.println("dto에 저장된 상품 적립금 : " + dto.getSaved());
				System.out.println("dto에 저장된 상품 설명 : " + dto.getExplan());
				
			}
		}catch (Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}
		
		return dto;
		
		
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
