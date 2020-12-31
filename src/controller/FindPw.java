package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MembershipDAO;
import smtp.SMTPAuth;

@WebServlet("/controller/Findpw.do")
public class FindPw extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 한글처리
		req.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("id");
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");

		MembershipDAO memberDAO = new MembershipDAO(drv, url, mid, mpw);
		String pw = memberDAO.findpw(id, name, email);
		System.out.println(pw);
		
		//메일발송을 위한 객체생성
		SMTPAuth smtp = new SMTPAuth();
		
		Map<String, String> emailContent = new HashMap<String, String>();
		emailContent.put("from", "pinocchio9702@naver.com");
		emailContent.put("to", email);
		emailContent.put("subject", "비밀번호를 보냈습니다.");
		emailContent.put("content", pw);
		
		boolean emailResult = smtp.emailSending(emailContent);
		
		resp.setContentType("text/html; charset=euc-kr"); //한글이 인코딩
		PrintWriter out = resp.getWriter(); //선언
		
	
		if(emailResult == false) {
			out.println("<script>");
			out.println("alert('비밀번호 찾기를 실패했습니다.')");
			out.println("location.href='../member/id_pw.jsp'");
			out.println("</script>");
			out.close();
		}else {
			out.println("<script>");
			out.println("alert('비밀번호를 이메일로 보냈습니다.')");
			out.println("location.href='../member/id_pw.jsp'");
			out.println("</script>");
			out.close();
		}
		
		//req.getRequestDispatcher("../member/id_pw.jsp").forward(req, resp);
	}
}
