package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import model.CalendarDAO;
import model.CalendarDTO;
import model.Multi_boardDAO;
import model.Multi_boardDTO;
import util.FileUtil;

@WebServlet("/admin/calendarEdit.do")
public class CalendarEdit extends HttpServlet{
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
		
		CalendarDAO dao = new CalendarDAO(drv, url, mid, mpw);
		
		//수정폼을 구성하기 위해 게시물의 내용을 가져온다.
		CalendarDTO dto = dao.selectView(num);
		
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("../admin/calendarEdit.jsp").forward(req, resp);
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("여기는 오는가?");
		
		req.setCharacterEncoding("UTF-8");
		
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		CalendarDAO dao = new CalendarDAO(drv, url, mid, mpw);
		
		
		int result;
		
		//멀티파트 객체가 정상적으로 생성되면 나머지 폼값을 받아온다.

		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String cal_date = req.getParameter("cal_date");
		String num = req.getParameter("num");
		
		System.out.println("파라미터로 넘어온 제목 : " + title);
		System.out.println("파라미터로 넘어온 내용 : " + content);
		System.out.println("파라미터로 넘어온 날짜 : " + cal_date);
		System.out.println("파라미터로 넘어온 일련번호 : " + num);

			
			
		CalendarDTO dto = new CalendarDTO();
		dto.setNum(num);
		dto.setContent(content);
		dto.setTitle(title);
		dto.setCal_date(cal_date);
		
		/*
		 레코드의 update가 성공이고 동시에 새로운 파일이 업로드 되었다면
		 기존의 파일은 삭제처리한다.
		 첨부한 파일이 없다면 기존파일은 유지된다.
		 */
		ServletContext app = this.getServletContext();
		result = dao.update(dto);
		
		
		dao.close();
		
		req.getRequestDispatcher("../admin/calendarList.jsp").forward(req, resp);
		
	}
}
