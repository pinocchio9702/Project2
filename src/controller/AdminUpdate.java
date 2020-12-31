package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import model.MembershipDAO;

@WebServlet("/controller/update.do")
public class AdminUpdate extends HttpServlet{
	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		// 한글처리
		req.setCharacterEncoding("UTF-8");

		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");

		MembershipDAO memberDAO = new MembershipDAO(drv, url, mid, mpw);
		
		String name = req.getParameter("name");
		String email = req.getParameter("inputEmail");
		String pw = req.getParameter("inputPassword");
		System.out.println(name);
		System.out.println(email);
		System.out.println(pw);
		
		int result = memberDAO.updateAdmin(name, email, pw);
		
		if(result == 1) {
			req.setAttribute("update", true);
			req.getRequestDispatcher("/admin").forward(req, res);
		}
		else {
			req.setAttribute("update", false);
			req.getRequestDispatcher("/admin/register.jsp").forward(req, res);
			//res.sendRedirect("../member/join02.jsp");
		}
		
		
		
		
		
		
		
		
		
	}
}
