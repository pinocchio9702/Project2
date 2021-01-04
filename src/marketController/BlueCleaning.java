package marketController;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CleaningDAO;
import model.CleaningDTO;
import model.MembershipDAO;
import smtp.SMTPAuth;

@WebServlet("/market/blueCleaning")
public class BlueCleaning extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String user = req.getParameter("user");
		String location = req.getParameter("location");
		String phone = req.getParameter("phone1") + req.getParameter("phone2") + req.getParameter("phone3");
		String mobile = req.getParameter("mobile1") + req.getParameter("mobile2") + req.getParameter("mobile3");
		String email = req.getParameter("email1") + "@" + req.getParameter("email2");
		String cleantype = req.getParameter("cleantype");
		String area = req.getParameter("area");
		String date = req.getParameter("date");
		String ask = req.getParameter("ask");
		String matters = req.getParameter("matters");
		
		System.out.println("파라미터로 넘어온 사용자 이름 : "+user);
		System.out.println("파라미터로 넘어온 장소 : "+location);
		System.out.println("파라미터로 넘어온 사용자 번호1 : "+phone);
		System.out.println("파라미터로 넘어온 사용자 휴대전화1 : "+mobile);
		System.out.println("파라미터로 넘어온 사용자 이메일1 : "+email);
		System.out.println("파라미터로 넘어온 청소타입 : "+cleantype);
		System.out.println("파라미터로 넘어온 영역 : "+area);
		System.out.println("파라미터로 넘어온 청소 날짜 : "+date);
		System.out.println("파라미터로 넘어온 예약 : "+ask);
		System.out.println("파라미터로 넘어온 특의사항 : "+matters);
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		CleaningDAO dao = new CleaningDAO(drv, url, mid, mpw);
		
		CleaningDTO dto = new CleaningDTO();
		
		HttpSession session = req.getSession(true);
		
		dto.setId(session.getAttribute("USER_ID").toString());
		dto.setUSER(user);
		dto.setLocation(location);
		dto.setPhone(phone);
		dto.setMobile(mobile);
		dto.setCleantype(cleantype);
		dto.setAREA(area);
		dto.setClean_date(date);
		dto.setAsk(ask);
		dto.setMatters(matters);
		dto.setEmail(email);
		
		int result = dao.insertCleaning(dto);
		
		
		
		if(result == 1) {
			System.out.println("블루클리닝 견적의뢰 성공");
			SMTPAuth smtp = new SMTPAuth();
			
			String mailContents = ""
					+"<table border='1'>"
						+"<tr>"
							+"<td>고객명/회사명</td>"
							+"<td>"+user+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>청소할 곳 주소</td>"
							+"<td>"+location+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>연락처</td>"
							+"<td>"+location+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>휴대전화</td>"
							+"<td>"+mobile+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>이메일</td>"
							+"<td>"+email+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>청소 종류</td>"
							+"<td>"+cleantype+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>분양평수/등기평수</td>"
							+"<td>"+area+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>청소 희망 날짜</td>"
							+"<td>"+date+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>접속종류 구분</td>"
							+"<td>"+ask+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>기타특의 사항</td>"
							+"<td>"+matters+"</td>"
						+"</tr>"
					+"</table>";
			
			//메일을 보내기위한 여러가지 폼값을 Map컬렉션에 저장
			Map<String, String> emailContent = new HashMap<String, String>();
			emailContent.put("from", "pinocchio9702@naver.com");
			emailContent.put("to", email);
			emailContent.put("to2", "pinocchio9702@naver.com");
			//emailContent.put("content", request.getParameter("content"));
			emailContent.put("content", mailContents);
			
		
			boolean emailResult = smtp.emailSending(emailContent);
			
			if(emailResult == true){
				System.out.print("메일발송성공");
			}
			else{
				System.out.print("메일발송실패");
			}
			
			req.setAttribute("bluecleaning", "success");
			req.getRequestDispatcher("../main/main.do").forward(req, resp);
		}else {
			System.out.println("블루클리닝 견적의뢰 실패");
			req.setAttribute("bluecleaning", "fail");
			req.getRequestDispatcher("../market/sub03.jsp").forward(req, resp);
		}
		
		
	}
}
