package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MembershipDAO;
import model.MembershipDTO;

@WebServlet("/controller/memberinsert.do")
public class MemberInsert extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		String tel = req.getParameter("tel1") + req.getParameter("tel2") + req.getParameter("tel2");
		String mobile = req.getParameter("mobile1") + req.getParameter("mobile2") + req.getParameter("mobile3");
		String email = req.getParameter("email_1") + '@' + req.getParameter("email_2");
		String open_email = req.getParameter("open_email");// 체크하면 1 체크 안하면 null
		
		if(open_email == null) { 
			open_email = "F"; 
		}else {
			open_email = "T";
		}
		 
		String addr = req.getParameter("addr1") + " " + req.getParameter("addr2");

		System.out.println(name);
		System.out.println(id);
		System.out.println(pass);
		System.out.println(tel);
		System.out.println(mobile);
		System.out.println(email);
		System.out.println(open_email);
		System.out.println(addr);

		
		 MembershipDTO memberDTO = new MembershipDTO(); 
		 memberDTO.setName(name);
		 memberDTO.setId(id); 
		 memberDTO.setPassword(pass);
		 memberDTO.setTelephone(tel); //집번호
		 memberDTO.setPhoneNumber(mobile); //핸드폰번호
		 memberDTO.setEmail(email); 
		 memberDTO.setOpen_email(open_email);
		 memberDTO.setAddress(addr);
		 
		 
		 int result = memberDAO.insertMember(memberDTO);
		 
		 System.out.println(result); 

		 memberDAO.close();
		 
		 if(result == 1) {
			 //req.getRequestDispatcher("../main/main.do").forward(req, resp);
			 req.getRequestDispatcher("../Login/LoginProcessMap.jsp?user_id="+id+"&user_pw"+pass).forward(req, resp);
		 }else {
			 resp.sendRedirect("../member/join02.jsp");
		 }

	}
}
