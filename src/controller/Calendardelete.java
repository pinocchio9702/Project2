package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CalendarDAO;
import model.CalendarDTO;
import model.Multi_boardDAO;
import model.Multi_boardDTO;
import util.FileUtil;

@WebServlet("/admin/calendarDelete.do")
public class Calendardelete extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");

		String num = req.getParameter("num");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		CalendarDAO dao = new CalendarDAO(drv, url, mid, mpw);
		
		//첨부파일 삭제를 위해 기존의 게시물을 가져와서 DTO객체에 저장
		CalendarDTO dto = dao.selectView(num);
		
		
		int sucOrFail = dao.delete(num);
		
	
		req.getRequestDispatcher("../admin/calendarList.jsp").forward(req, resp);
	}
}
