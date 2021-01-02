package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Multi_boardDAO;

@WebServlet("/controller/BoardDelete.do")
public class BoardDelete extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String num = req.getParameter("num");
		System.out.println("num : " + num);
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		int result = dao.delete(num);
		
		if(result == 1) {
			
			req.getRequestDispatcher("../space/sub03_list.jsp").forward(req, resp);			
		}
		else {
			req.setAttribute("delete", "삭제 실패");
			req.getRequestDispatcher("../space/sub03_View.jsp").forward(req, resp);
		}
		
	}
}
