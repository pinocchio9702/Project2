package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CalendarDAO;
import model.CalendarDTO;

@WebServlet("/admin/calendarWrite.do")
public class CalendarWrite extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		HttpSession session = req.getSession(true);
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String cal_date = req.getParameter("cal_date");
		
		System.out.println("현재 아아디는? : " + session.getAttribute("USER_ID"));
		System.out.println("파라미터로 넘어온 제목은?"+title);
		System.out.println("파라미터로 넘어온 내용은?"+content);
		System.out.println("파라미터로 넘어온 날짜는?"+cal_date);
		
		CalendarDTO dto = new CalendarDTO();
		dto.setId(session.getAttribute("USER_ID").toString());
		dto.setTitle(title);
		dto.setContent(content);
		dto.setCal_date(cal_date);
		
		CalendarDAO dao = new CalendarDAO(drv, url, mid, mpw);
		
		int result = dao.insertCalendar(dto);
		
		if(result ==1) {
			req.getRequestDispatcher("../admin/calendarList.jsp").forward(req, resp);
		}
		else {
			System.out.println("6");
			req.getRequestDispatcher("../admin/calendarWrite.jsp").forward(req, resp);
			
		}
		
		
		
		
		
	}
}
