package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MembershipDAO;

@WebServlet("/controller/FindId.do")
public class FoundId extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		
		System.out.println("들어오는지 다시한번 확인");
		
		// 한글처리
		req.setCharacterEncoding("UTF-8");

		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");

		MembershipDAO memberDAO = new MembershipDAO(drv, url, mid, mpw);
		
		String findId = memberDAO.findId(name, email);
		
		System.out.println(findId);
		
		req.setAttribute("id", findId);
		
		//resp.setContentType("text/html; charset=euc-kr"); //한글이 인코딩
		//PrintWriter out = resp.getWriter(); //선언
		
//		out.println("<script>");
//		out.println("alert('회원님의 아아디는'+"+findId +"+'입니다')");
//		out.println("location.href='../member/id_pw.jsp'");
//		out.println("</script>");
//		out.close();
		
		
		req.getRequestDispatcher("../member/id_pw.jsp").forward(req, resp);
	}
}
