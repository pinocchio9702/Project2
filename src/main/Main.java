package main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Multi_boardDAO;
import model.Multi_boardDTO;
import model.Photo_boardDAO;
import model.Photo_boardDTO;
import util.CookieUtil;

@WebServlet("/main/main.do")
public class Main extends HttpServlet{
	@Override
	public void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext application = this.getServletContext();
		//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		//DAO객체 생성 및 커넥션풀을 통한 DB연결
		Multi_boardDAO M_dao = new Multi_boardDAO(drv, url, mid, mpw);
		Photo_boardDAO P_dao = new Photo_boardDAO(drv, url, mid, mpw);
		
		List<Multi_boardDTO> listsNotice = M_dao.selectListNotice();
		List<Multi_boardDTO> listsBoard = M_dao.selectListBoard();
		List<Photo_boardDTO> photoBoard = P_dao.selectListPhotoBoard();
		
		req.setAttribute("listsNotice", listsNotice);
		req.setAttribute("listsBoard", listsBoard);
		req.setAttribute("photoBoard", photoBoard);
		req.getRequestDispatcher("/main/main.jsp").forward(req, resp);
	}
}
