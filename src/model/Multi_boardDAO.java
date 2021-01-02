package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;




public class Multi_boardDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public Multi_boardDAO(String driver, String url, String id, String pw) {
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
	
	// 공지사항게시물의 갯수를 카운트
	public int getTotalRecordCountNotice(Map map) {
		// 게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		

		try {
			// 기본쿼리문(전체레코드를 대상으로 함)
			String sql = "SELECT COUNT(*) FROM multi_board"
					+ "  WHERE check_board = 'N'";

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
	
	// 공지사항게시물의 갯수를 카운트
		public int getTotalRecordCountPhoto(Map map) {
			// 게시물의 갯수는 최초 0으로 초기화
			int totalCount = 0;
			

			try {
				// 기본쿼리문(전체레코드를 대상으로 함)
				String sql = "SELECT COUNT(*) FROM multi_board"
						+ "  WHERE check_board = 'P'";

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
	
	// 공지사항게시물의 갯수를 카운트
	public int getTotalRecordCountBoard(Map map) {
		// 게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		

		try {
			// 기본쿼리문(전체레코드를 대상으로 함)
			String sql = "SELECT COUNT(*) FROM multi_board"
					+ "  WHERE check_board = 'B'";

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
	
	// 공지사항게시물의 갯수를 카운트
	public int getTotalRecordCountData(Map map) {
		// 게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		

		try {
			// 기본쿼리문(전체레코드를 대상으로 함)
			String sql = "SELECT COUNT(*) FROM multi_board"
					+ "  WHERE check_board = 'D'";

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
		
		public List<Multi_boardDTO> selectListPageNotice(Map map) {

			List<Multi_boardDTO> bbs = new Vector<Multi_boardDTO>();

			// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
			String sql = "  " 
					+ "     SELECT * FROM multi_board "
					+ "		WHERE check_board = 'N' ";

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
					Multi_boardDTO dto = new Multi_boardDTO();

					dto.setNum(rs.getString(1));
					dto.setId(rs.getString(2));
					dto.setTitle(rs.getString(3));
					dto.setContent(rs.getString(4));
					dto.setPostdate(rs.getDate(5));
					dto.setFile(rs.getString(6));
					dto.setVisitcount(rs.getInt(7));
					dto.setCheck_board(rs.getString(8));

					bbs.add(dto);
				}

			} catch (Exception e) {
				System.out.println("update중 예외발생");
				e.printStackTrace();
			}

			return bbs;

		}
		
		public List<Multi_boardDTO> AdminselectNoticeList() {

			List<Multi_boardDTO> bbs = new Vector<Multi_boardDTO>();

			// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
			String sql = "  " 
					+ "     SELECT * FROM multi_board "
					+ "		WHERE check_board = 'N' ";

			System.out.println("쿼리문 : " + sql);

			try {

				psmt = con.prepareStatement(sql);

			

				rs = psmt.executeQuery();

				while (rs.next()) {
					Multi_boardDTO dto = new Multi_boardDTO();

					dto.setNum(rs.getString(1));
					dto.setId(rs.getString(2));
					dto.setTitle(rs.getString(3));
					dto.setContent(rs.getString(4));
					dto.setPostdate(rs.getDate(5));
					dto.setFile(rs.getString(6));
					dto.setVisitcount(rs.getInt(7));
					dto.setCheck_board(rs.getString(8));

					bbs.add(dto);
				}

			} catch (Exception e) {
				System.out.println("update중 예외발생");
				e.printStackTrace();
			}

			return bbs;

		}
		
		public List<Multi_boardDTO> selectListPageBoard(Map map) {

			List<Multi_boardDTO> bbs = new Vector<Multi_boardDTO>();

			// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
			String sql = "  " 
					+ "     SELECT * FROM multi_board M "
				    + "     INNER JOIN membership B   "
				    + "  	ON M.id=B.id   "
					+ "		WHERE check_board = 'B' ";

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
					Multi_boardDTO dto = new Multi_boardDTO();

					dto.setId(rs.getString("id"));
					dto.setName(rs.getString("NAME"));
					dto.setEmail(rs.getString("email"));
					dto.setNum(rs.getString("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setPostdate(rs.getDate("postdate"));
					dto.setFile(rs.getString("FILE"));
					dto.setVisitcount(rs.getInt("visitcount"));
					dto.setCheck_board(rs.getString("check_board"));
					dto.setBoard_name(rs.getString("board_name"));

					bbs.add(dto);
				}

			} catch (Exception e) {
				System.out.println("update중 예외발생");
				e.printStackTrace();
			}

			return bbs;

		}
		
		public List<Multi_boardDTO> selectListPageData(Map map) {

			List<Multi_boardDTO> bbs = new Vector<Multi_boardDTO>();

			// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
			String sql = "  " 
					+ "     SELECT * FROM multi_board M "
				    + "     INNER JOIN membership B   "
				    + "  	ON M.id=B.id   "
					+ "		WHERE check_board = 'D' ";

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
					Multi_boardDTO dto = new Multi_boardDTO();

					dto.setId(rs.getString("id"));
					dto.setName(rs.getString("NAME"));
					dto.setEmail(rs.getString("email"));
					dto.setNum(rs.getString("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setPostdate(rs.getDate("postdate"));
					dto.setFile(rs.getString("FILE"));
					dto.setFile_path(rs.getString("file_path"));
					dto.setVisitcount(rs.getInt("visitcount"));
					dto.setCheck_board(rs.getString("check_board"));
					dto.setBoard_name(rs.getString("board_name"));

					bbs.add(dto);
				}

			} catch (Exception e) {
				System.out.println("update중 예외발생");
				e.printStackTrace();
			}

			return bbs;

		}
		
		public List<Multi_boardDTO> selectListPagePhoto(Map map) {

			List<Multi_boardDTO> bbs = new Vector<Multi_boardDTO>();

			// 쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨.
			String sql = "  " 
					+ "     SELECT * FROM multi_board M "
				    + "     INNER JOIN membership B   "
				    + "  	ON M.id=B.id   "
					+ "		WHERE check_board = 'P' ";

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
					Multi_boardDTO dto = new Multi_boardDTO();

					dto.setId(rs.getString("id"));
					dto.setName(rs.getString("NAME"));
					dto.setEmail(rs.getString("email"));
					dto.setNum(rs.getString("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setPostdate(rs.getDate("postdate"));
					dto.setFile(rs.getString("FILE"));
					dto.setVisitcount(rs.getInt("visitcount"));
					dto.setCheck_board(rs.getString("check_board"));
					dto.setBoard_name(rs.getString("board_name"));
					dto.setFile_path(rs.getString("file_path"));

					bbs.add(dto);
				}

			} catch (Exception e) {
				System.out.println("update중 예외발생");
				e.printStackTrace();
			}

			return bbs;

		}
		
		//공지사항 게시물 4개 출력
		public List<Multi_boardDTO> selectListNotice() {
			// 리스트 컬렉션을 생성
			List<Multi_boardDTO> bbs = new Vector<Multi_boardDTO>();
			// 기본 쿼리문
			String sql = "SELECT * FROM multi_board  "
					+ "   WHERE check_board = 'N'"
					+ "   ORDER BY NUM DESC LIMIT 4";

			try {
				psmt = con.prepareStatement(sql);
				rs = psmt.executeQuery();
				// 오라클이 반환해주는 Result의 갯수만큼 반복
				while (rs.next()) {
					// 하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체생성
					Multi_boardDTO dto = new Multi_boardDTO();
					dto.setNum(rs.getString(1));
					dto.setId(rs.getString(2));
					dto.setTitle(rs.getString(3));
					dto.setContent(rs.getString(4));
					dto.setPostdate(rs.getDate(5));
					dto.setFile(rs.getString(6));
					dto.setFile_path(rs.getString(7));
					dto.setVisitcount(rs.getInt(8));
					dto.setCheck_board(rs.getString(9));

					bbs.add(dto);
					System.out.println("쿼리 토스 성공");
				}
			} catch (Exception e) {
				System.out.println("select시 예외발생");
				e.printStackTrace();
			}

			return bbs;

		}
		
		//자유게시판 리스트 4개 출력
		public List<Multi_boardDTO> selectListBoard() {
			// 리스트 컬렉션을 생성
			List<Multi_boardDTO> bbs = new Vector<Multi_boardDTO>();
			// 기본 쿼리문
			String sql = "SELECT * FROM multi_board  "
					+ "   WHERE check_board = 'B'"
					+ "   ORDER BY NUM DESC LIMIT 4";

			try {
				psmt = con.prepareStatement(sql);
				rs = psmt.executeQuery();
				// 오라클이 반환해주는 Result의 갯수만큼 반복
				while (rs.next()) {
					// 하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체생성
					Multi_boardDTO dto = new Multi_boardDTO();
					dto.setNum(rs.getString(1));
					dto.setId(rs.getString(2));
					dto.setTitle(rs.getString(3));
					dto.setContent(rs.getString(4));
					dto.setPostdate(rs.getDate(5));
					dto.setFile(rs.getString(6));
					dto.setFile_path(rs.getString(7));
					dto.setVisitcount(rs.getInt(8));
					dto.setCheck_board(rs.getString(9));

					bbs.add(dto);
					System.out.println("쿼리 토스 성공");
				}
			} catch (Exception e) {
				System.out.println("select시 예외발생");
				e.printStackTrace();
			}

			return bbs;

		}
		
		//사진게시물 가져오기
		public List<Multi_boardDTO> selectListPhotoBoard() {
			// 리스트 컬렉션을 생성
			List<Multi_boardDTO> bbs = new Vector<Multi_boardDTO>();
			// 기본 쿼리문
			String sql = "SELECT * FROM multi_board  "
					+ "   WHERE check_board = 'P'"
					+ "   ORDER BY NUM DESC LIMIT 6";

			try {
				psmt = con.prepareStatement(sql);
				rs = psmt.executeQuery();
				// 오라클이 반환해주는 Result의 갯수만큼 반복
				while (rs.next()) {
					// 하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체생성
					Multi_boardDTO dto = new Multi_boardDTO();
					dto.setNum(rs.getString(1));
					dto.setId(rs.getString(2));
					dto.setTitle(rs.getString(3));
					dto.setContent(rs.getString(4));
					dto.setPostdate(rs.getDate(5));
					dto.setFile(rs.getString(6));
					dto.setFile_path(rs.getString(7));
					dto.setVisitcount(rs.getInt(8));
					dto.setCheck_board(rs.getString(9));


					bbs.add(dto);
					System.out.println("쿼리 토스 성공");
				}
			} catch (Exception e) {
				System.out.println("select시 예외발생");
				e.printStackTrace();
			}

			return bbs;

		}
		
		//게시물 조회수 증가시킴
		public void updateVisitCount(String num) {
			String query = "UPDATE multi_board SET  "
					+ "  visitcount=visitcount+1"
					+ "   WHERE num=?";
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, num);
				/*
				쿼리 실행시 executeQuery() 혹은 executeUpdate()
				둘다 사용가능하다. 단, 두 메소드의 차이는 반환값이 다르다는
				점이다. 반환값이 굳이 필요없는 경우라면 어떤것을 사용해도
				무방하다.
				*/
				psmt.executeQuery();
			}catch (Exception e) {
				System.out.println("조회수 증가시 예외발생");
				e.printStackTrace();
			}
		}
		
		//일련번호에 해당하는 게시물 하나를 가져온다.
		public Multi_boardDTO selectView(String num) {
			
			//게시판 테이블만 사용하여 게시물 조회
			Multi_boardDTO dto = new Multi_boardDTO();
			//String query = "SELECT * FROM board WHERE num=?";
			
			//게시판, 회원테이블을 조인하여 이름까지 가져와서 조회
			String query = "" 
					+ "SELECT  "
				    + "	  	num, title, content, B.id, postdate, visitcount, name, email, file, board_name, board_email, file_path  "
				    + "   FROM membership M INNER JOIN multi_board B   "
				    + "  	ON M.id=B.id   "
				    + "   WHERE num=?   ";
		
			
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, num);
				rs = psmt.executeQuery();
				if(rs.next()) {
					dto.setNum(rs.getString(1));
					dto.setTitle(rs.getString(2));
					dto.setContent(rs.getString("content"));
					dto.setPostdate(rs.getDate("postdate"));
					dto.setId(rs.getString("id"));
					dto.setVisitcount(rs.getInt(6));
					dto.setBoard_email(rs.getString("board_email"));
					dto.setBoard_name(rs.getString("board_name"));
					/*
					member테이블과 join하여 얻어온 name을 DTO에 추가함
					*/
					dto.setName(rs.getString("name"));
					dto.setEmail(rs.getString("email"));
					dto.setFile(rs.getString("file"));
					dto.setFile_path(rs.getString("file_path"));
				}
			}catch (Exception e) {
				System.out.println("상세보기시 예외발생");
				e.printStackTrace();
			}
			
			return dto;
		}
		
		public int insertNotice(Multi_boardDTO dto) {
			int affected = 0;
			
			System.out.println(dto.getFile());
			try {
				String sql = "INSERT INTO multi_board ( " 
						+ "  id, title, content, file, check_board)  "
						+ "  VALUES (?, ?, ?, ?, 'N')";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getTitle());
				psmt.setString(3, dto.getContent());
				psmt.setString(4, dto.getFile());

				affected = psmt.executeUpdate();
				System.out.println(affected);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return affected;
		}
		
		public int insertPhoto(Multi_boardDTO dto) {
			int affected = 0;
			
			System.out.println(dto.getFile());
			try {
				String sql = "INSERT INTO multi_board ( " 
						+ "  id, title, content, file, file_path, check_board)  "
						+ "  VALUES (?, ?, ?, ?, ?, 'P')";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getTitle());
				psmt.setString(3, dto.getContent());
				psmt.setString(4, dto.getFile());
				psmt.setString(5, dto.getFile_path());

				affected = psmt.executeUpdate();
				System.out.println(affected);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return affected;
		}
		
		public int insertData(Multi_boardDTO dto) {
			int affected = 0;
			
			System.out.println(dto.getFile());
			try {
				String sql = "INSERT INTO multi_board ( " 
						+ "  id, title, content, file, file_path, check_board)  "
						+ "  VALUES (?, ?, ?, ?, ?, 'D')";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getTitle());
				psmt.setString(3, dto.getContent());
				psmt.setString(4, dto.getFile());
				psmt.setString(5, dto.getFile_path());

				affected = psmt.executeUpdate();
				System.out.println(affected);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return affected;
		}
		
		public int insertBoard(Multi_boardDTO dto) {
			int affected = 0;
			
			System.out.println(dto.getFile());
			try {
				String sql = "INSERT INTO multi_board ( " 
						+ "  id, board_name, board_email, title, content, check_board)  "
						+ "  VALUES (?, ?, ?, ?, ?, 'B')";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getBoard_name());
				psmt.setString(3, dto.getBoard_email());
				psmt.setString(4, dto.getTitle());
				psmt.setString(5, dto.getContent());

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
				String query = " DELETE FROM multi_board  " + "  WHERE num=?";
				psmt = con.prepareStatement(query);
				psmt.setString(1, num);

				affected = psmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("delecte중 예외발생");
				e.printStackTrace();
			}

			return affected;
		}
		
		public int update(Multi_boardDTO dto) {
			int affected = 0;

			try {
				String query = "UPDATE multi_board SET  " 
						+ "  title=?, content=?, file=?"
						+ "  WHERE num=?";

				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getFile());
				psmt.setString(4, dto.getNum());

				affected = psmt.executeUpdate();

			} catch (Exception e) {
				System.out.println("update중 예외발생");
				e.printStackTrace();
			}

			return affected;
		}
		
		public int Boardupdate(Multi_boardDTO dto) {
			int affected = 0;

			try {
				String query = "UPDATE multi_board SET  " 
						+ "  title=?, content=?, board_name=?, board_email=?"
						+ "  WHERE num=?";
				
				System.out.println("num : " + dto.getNum());
				System.out.println("name : " + dto.getBoard_name());
				System.out.println("title : " + dto.getTitle());
				System.out.println("Content : " + dto.getContent());
				
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getBoard_name());
				psmt.setString(4, dto.getBoard_email());
				psmt.setString(5, dto.getNum());

				affected = psmt.executeUpdate();

			} catch (Exception e) {
				System.out.println("update중 예외발생");
				e.printStackTrace();
			}

			return affected;
		}
		
		public int Photoupdate(Multi_boardDTO dto) {
			int affected = 0;

			try {
				String query = "UPDATE multi_board SET  " 
						+ "  title=?, content=?, file=?, file_path=?  "
						+ "  WHERE num=?";
				
				System.out.println("num : " + dto.getNum());
				System.out.println("file : " + dto.getFile());
				System.out.println("title : " + dto.getTitle());
				System.out.println("Content : " + dto.getContent());
				
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getFile());
				psmt.setString(4, dto.getFile_path());
				psmt.setString(5, dto.getNum());

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
