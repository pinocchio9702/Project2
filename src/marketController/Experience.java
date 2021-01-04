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
import model.ExperienceDAO;
import model.ExperienceDTO;
import model.MembershipDAO;
import smtp.SMTPAuth;

@WebServlet("/market/experience")
public class Experience extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String user = req.getParameter("user");
		String disability = req.getParameter("disability");
		String disability_type = req.getParameter("disability_type");
		String assisting = req.getParameter("assisting");
		String assisting_name = req.getParameter("assisting_name");
		String phone = req.getParameter("phone1") + req.getParameter("phone2") + req.getParameter("phone3");
		String mobile = req.getParameter("mobile1") + req.getParameter("mobile2") + req.getParameter("mobile3");
		String email = req.getParameter("email1") + "@" + req.getParameter("email2");
		String cake = req.getParameter("cake");
		String cookie = req.getParameter("cookie");
		String experience_date = req.getParameter("experience_date");
		String ask = req.getParameter("ask");
		String matters = req.getParameter("matters");
		
		System.out.println("파라미터로 넘어온 사용자 이름 : "+user);
		System.out.println("파라미터로 넘어온 장애유무: "+disability);
		System.out.println("파라미터로 넘어온 장애타입: "+disability_type);
		System.out.println("파라미터로 넘어온 보후구 유무: "+assisting);
		System.out.println("파라미터로 넘어온 보호구 이름: "+assisting_name);
		System.out.println("파라미터로 넘어온 사용자 번호 : "+phone);
		System.out.println("파라미터로 넘어온 사용자 휴대전화 : "+mobile);
		System.out.println("파라미터로 넘어온 사용자 이메일 : "+email);
		System.out.println("파라미터로 넘어온 케익 : "+cake);
		System.out.println("파라미터로 넘어온 쿠키 : "+ cookie);
		System.out.println("파라미터로 넘어온 청소 날짜 : "+experience_date);
		System.out.println("파라미터로 넘어온 예약 : "+ask);
		System.out.println("파라미터로 넘어온 특의사항 : "+matters);
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		ExperienceDAO dao = new ExperienceDAO(drv, url, mid, mpw);
		
		ExperienceDTO dto = new ExperienceDTO();
		
		HttpSession session = req.getSession(true);
		
		dto.setId(session.getAttribute("USER_ID").toString());
		dto.setUSER(user);
		dto.setDisability(disability);
		dto.setDisability_type(disability_type);
		dto.setAssisting(assisting);
		dto.setAssisting_name(assisting_name);
		dto.setPhone(phone);
		dto.setMobile(mobile);
		dto.setEmail(email);
		dto.setCake(cake);
		dto.setCookie(cookie);
		dto.setExperience_date(experience_date);
		dto.setAsk(ask);
		dto.setMatters(matters);
		
		int result = dao.insertExperience(dto);
		
		
		
		if(result == 1) {
			System.out.println("체험학습 신청 성공 성공");
			SMTPAuth smtp = new SMTPAuth();
			
			String mailContents = ""
					+"<table border='1'>"
						+"<tr>"
							+"<td>고객명/회사명</td>"
							+"<td>"+user+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>장애 유무</td>"
							+"<td>"+disability+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>주요 장애 유영</td>"
							+"<td>"+disability_type+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>보장구 사용유무</td>"
							+"<td>"+assisting+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>보장구 명</td>"
							+"<td>"+assisting_name+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>연락처</td>"
							+"<td>"+phone+"</td>"
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
							+"<td>쿠키 체험</td>"
							+"<td>"+cookie+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>케익체험</td>"
							+"<td>"+cookie+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td>체험 희망 날짜</td>"
							+"<td>"+experience_date+"</td>"
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
			
			req.setAttribute("experience", "success");
			req.getRequestDispatcher("../main/main.do").forward(req, resp);
		}else {
			System.out.println("블루클리닝 견적의뢰 실패");
			req.setAttribute("experience", "fail");
			req.getRequestDispatcher("../market/sub05.jsp").forward(req, resp);
		}
		
		
	}
}
