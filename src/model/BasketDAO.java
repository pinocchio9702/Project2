package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class BasketDAO {

	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public BasketDAO(String driver, String url, String id, String pw) {
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
	
	
	public List<BasketDTO> selectListPageGoods(String id) {

		List<BasketDTO> bbs = new Vector<BasketDTO>();

		// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
		String sql = "  " 
				+ "     SELECT *  "
				+ "  	FROM basket B  "
				+ "   	INNER JOIN goods G  "
				+ "  	on B.goods_num = G.num "
				+ " 	WHERE id = ? ";
		
		System.out.println("쿼리문 : " + sql);

		try {
				
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();

			while (rs.next()) {
				BasketDTO dto = new BasketDTO();
				

				dto.setGoods_num(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setAmount(rs.getInt(3));
				
				//조인문으로 price을 구해 토탈 가격을 구한다.
				dto.setName(rs.getString(5));
				dto.setImage_path(rs.getString(7));
				dto.setPrice(rs.getInt(8)); 
				dto.setSaved(rs.getInt(9));
				
				dto.setTotal(dto.getAmount() * dto.getPrice());
				
				System.out.println("장바구나 dto에 저장된 상품 일련번호 : " + dto.getGoods_num());
				System.out.println("장바구나 dto에 저장된 상품 아이디 : " + dto.getId());
				System.out.println("장바구나 dto에 저장된 상품 총계 : " + dto.getAmount());
				System.out.println("장바구나 dto에 저장된 상품 상품 이름 : " + dto.getName());
				System.out.println("장바구나 dto에 저장된 상품 이미지 경로 : " + dto.getImage_path());
				System.out.println("장바구나 dto에 저장된 상품 적립금 : " + dto.getSaved());
				System.out.println("장바구나 dto에 저장된 상품 전체금액 : " + dto.getTotal());
				
				bbs.add(dto);
				
			}

		} catch (Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}

		return bbs;

	}
	
	public int insertBasket(BasketDTO dto) {
		int affected = 0;
		
		try {
			String sql = "INSERT INTO basket ( " 
					+ "  goods_num, id, amount)  "
					+ "  VALUES (?, ?, ?)";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, dto.getGoods_num());
			psmt.setString(2, dto.getId());
			psmt.setInt(3, dto.getAmount());


			affected = psmt.executeUpdate();
			System.out.println("insert을 실행한 결과 값 :"+affected);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return affected;
	}
	
	public int basketUpdate(int amount, int goods_num, String id) {
		int affected = 0;
		
		String sql = " UPDATE basket SET amount = ?  "
				+ "  WHERE goods_num = ? AND id = ?  ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, amount);
			psmt.setInt(2, goods_num);
			psmt.setString(3, id);
			
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
