package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class PurchaseDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public PurchaseDAO(String driver, String url, String id, String pw) {
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
	
	
	public int PurchaseInsert(PurchaseDTO dto) {
		int affected = 0;
		
		String sql = " INSERT INTO purchase(  "
				+ "  purchase_information, id, order_name,  "
				+ "  order_address, order_mobile, order_email, "
				+ "  del_name, del_address, del_mobile, del_email,  "
				+ "  del_message, payment_type, total   "
				+ "  ) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)  ";
				
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getPurchase_information());
			psmt.setNString(2, dto.getId());
			psmt.setNString(3, dto.getOrder_name());
			psmt.setNString(4, dto.getOrder_address());
			psmt.setNString(5, dto.getOrder_mobile());
			psmt.setNString(6, dto.getOrder_email());
			psmt.setNString(7, dto.getDel_name());
			psmt.setNString(8, dto.getDel_address());
			psmt.setNString(9, dto.getDel_mobile());
			psmt.setNString(10, dto.getDel_email());
			psmt.setNString(11, dto.getDel_message());
			psmt.setNString(12, dto.getPayment_type());
			psmt.setNString(13, dto.getTotal());
			
			affected = psmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return affected;
	
	}	
	
	public List<PurchaseDTO> selectExperienceList() {

		List<PurchaseDTO> bbs = new Vector<PurchaseDTO>();

		// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
		String sql = "  " 
				+ "     SELECT * FROM purchase ";

		System.out.println("쿼리문 : " + sql);

		try {

			psmt = con.prepareStatement(sql);

			rs = psmt.executeQuery();

			while (rs.next()) {
				PurchaseDTO dto = new PurchaseDTO();

				dto.setPurchase_information(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setOrder_name(rs.getString(3));
				dto.setOrder_address(rs.getString(4));
				dto.setOrder_mobile(rs.getString(5));
				dto.setOrder_email(rs.getString(6));
				dto.setDel_name(rs.getString(7));
				dto.setDel_address(rs.getString(8));
				dto.setDel_mobile(rs.getString(9));
				dto.setDel_email(rs.getString(10));
				dto.setDel_message(rs.getString(11));
				dto.setPayment_type(rs.getString(12));
				dto.setTotal(rs.getString(13));

				bbs.add(dto);
			}

		} catch (Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}

		return bbs;

	}
	
	
}
