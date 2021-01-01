package controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MembershipDAO;

@WebServlet("/admin/Lgoin.do")
public class AdminLogin extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//한글처리
		req.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("Id");
		String pw = req.getParameter("Password");
		
		System.out.println(id);
		System.out.println(pw);
		
		ServletContext application = this.getServletContext();
		//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		MembershipDAO memberDAO = new MembershipDAO(drv, url, mid, mpw);
		
		Map<String, String> memberShipMap = memberDAO.getAdminMembershipMap(id, pw);
		
		HttpSession session = req.getSession(true);

		if (memberShipMap.get("id") != null) {
			session.setAttribute("USER_ID", memberShipMap.get("id"));
			session.setAttribute("USER_PW", memberShipMap.get("pass"));
			session.setAttribute("USER_NAME", memberShipMap.get("name"));
			
			req.getRequestDispatcher("../admin/memberList").forward(req, resp);
		}
		
		else {
			req.setAttribute("ERROR_MSG", "관리자모드에 접속하실 수 업습니다.");
			req.getRequestDispatcher("../admin/login.jsp").forward(req, resp);
		}
		
	}
}
