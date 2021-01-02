package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Multi_boardDAO;
import model.Multi_boardDTO;

@WebServlet("/controller/BoardEdit.do")
public class BoardEdit extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");

		String num = req.getParameter("num");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		//수정폼을 구성하기 위해 게시물의 내용을 가져온다.
		Multi_boardDTO dto = dao.selectView(num);
		
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("../space/sub03_Edit.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		String num = req.getParameter("num");
		String email = req.getParameter("email");
		String name = req.getParameter("name");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		
		Multi_boardDTO dto = new Multi_boardDTO();
		dto.setBoard_email(email);
		dto.setBoard_name(name);
		dto.setContent(content);
		dto.setTitle(title);
		dto.setNum(num);
		
		int result = dao.Boardupdate(dto);
		
		if(result == 1) {
			req.getRequestDispatcher("../space/sub03_list.jsp").forward(req, resp);
		}else {
			req.setAttribute("dto", dto);
			
			req.getRequestDispatcher("../space/sub03_Edit.jsp").forward(req, resp);
		}
		
		
	}
}
