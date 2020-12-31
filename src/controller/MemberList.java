package controller;

import java.io.IOException;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MembershipDAO;
import model.MembershipDTO;

@WebServlet("/admin/memberList")
public class MemberList extends HttpServlet{
	
	@Override
	public void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");

		MembershipDAO dao = new MembershipDAO(drv, url, mid, mpw);
		
		List<MembershipDTO> mamberList = dao.membershipList();
		
		req.setAttribute("memberlist", mamberList);
		
		
		
		//HttpSession session = req.getSession(true);
		
		//session.setAttribute("memberlist", memberMap);
		
		///서블릿 명 - admin/memberList
		req.getRequestDispatcher("/admin/member.jsp").forward(req, resp);
		
		
	}
}
