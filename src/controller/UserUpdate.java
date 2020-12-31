package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MembershipDAO;
import model.MembershipDTO;

@WebServlet("/admin/UserUpdate.do")
public class UserUpdate extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
		
		System.out.println(name);
		
		int result = memberDAO.updateUser(name);
		
		List<MembershipDTO> mamberList = memberDAO.membershipList();
		
		req.setAttribute("memberlist", mamberList);
		
		if(result == 1) {
			System.out.println("1");
			req.setAttribute("update", true);
			req.getRequestDispatcher("../admin/member.jsp").forward(req, resp);
		}
		else {
			System.out.println("2");
			//req.setAttribute("update", false);
			resp.sendRedirect("../admin/member.jsp");
		}
	}
}
