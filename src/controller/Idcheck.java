package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MembershipDAO;


@WebServlet("/controller/idcheck.do")
public class Idcheck extends HttpServlet{	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//한글처리
		req.setCharacterEncoding("UTF-8");
		String id = req.getParameter("id");


		
		
		ServletContext application = this.getServletContext();
		//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		MembershipDAO memberDAO = new MembershipDAO(drv, url, mid, mpw);
		
		boolean idCheck = memberDAO.checkMembershipId(id);
		
		
		if(idCheck) {
			req.setAttribute("idCheck", idCheck);
		}
		else if(idCheck) {
			req.setAttribute("idCheck", idCheck);
		}

		
		resp.setContentType("text/html; charset=euc-kr"); //한글이 인코딩
		PrintWriter out = resp.getWriter(); //선언
		
		req.setAttribute("idCheck", idCheck);
		
		req.getRequestDispatcher("../member/idCheck.jsp?idCheck="+idCheck).forward(req, resp);
	}
}
