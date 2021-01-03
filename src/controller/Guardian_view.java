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

@WebServlet("/controller/guardian_view")
public class Guardian_view extends HttpServlet{
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
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		//조회수를 업데이트하여 visitcount컬럼을 1증가시킴
		dao.updateVisitCount(num);
		
		Multi_boardDTO dto = dao.selectView(num);
		
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		
		req.setAttribute("dto", dto);

		dao.close();
		
		
		req.getRequestDispatcher("../community/sub02_view.jsp").forward(req, resp);
	}
}
