package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import model.Multi_boardDAO;
import model.Multi_boardDTO;
import util.FileUtil;

@WebServlet("/controller/BoardWrite")
public class BoardWrite extends HttpServlet{
	
	//글쓰기 버튼을 눌렀을때 처음에 sub03_write.jsp로 이동한다.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		
		req.getRequestDispatcher("../space/sub03_write.jsp").forward(req, resp);
	}
	
	//게시물 올리기 버튼을 누르면 디비 처리를 해준다.
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");

		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		HttpSession session = req.getSession(true);
		
	
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String id = req.getParameter("id");
		
		System.out.println(id);
		
		Multi_boardDTO dto = new Multi_boardDTO();
		dto.setId(id);
		dto.setBoard_name(name);
		dto.setBoard_email(email);
		dto.setContent(content);
		dto.setTitle(title);
		
		//DAO객체 생성 및 연결...insert처리
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		//파일 업로드 성공 및 insert성공시...
		int result = dao.insertBoard(dto);
		
		dao.close();
		
		if(result ==1) {
			System.out.println("5");
			resp.sendRedirect("../space/sub03_list.jsp");
		}
		else {
			System.out.println("6");
			req.getRequestDispatcher("../space/sub03_write.jsp").forward(req, resp);
			
		}
		
		
	}
}
