package marketController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BasketDAO;
import model.BasketDTO;
import model.PurchaseDAO;
import model.PurchaseDTO;

@WebServlet("/market/purchaseInsert.do")
public class PurchaseInsert extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		HttpSession session = req.getSession(true);
		
		String id = session.getAttribute("USER_ID").toString();
		String order_name = req.getParameter("order_name");
		String order_address = req.getParameter("order_address1") + req.getParameter("order_address2") + req.getParameter("order_address3") + req.getParameter("order_address4");
		String order_mobile = req.getParameter("order_mobile1") + req.getParameter("order_mobile2") + req.getParameter("order_mobile3");
		String order_email = req.getParameter("order_email1") + "@" + req.getParameter("order_email2");
		String del_name = req.getParameter("del_name");
		String del_address = req.getParameter("del_address1") + req.getParameter("del_address2") + req.getParameter("del_address3");
		String del_mobile = req.getParameter("del_mobile1") + req.getParameter("del_mobile2") + req.getParameter("del_mobile3");
		String del_email = req.getParameter("del_email1") + "@" + req.getParameter("del_email2");
		String del_message = req.getParameter("del_message");
		String payment_type = req.getParameter("payment_type");
		String total = req.getParameter("total");
		
		/*
		System.out.println("현재 아아디 : " + id);
		System.out.println("파라미터로 넘어온 주문자 이름 : " + order_name);
		System.out.println("파라미터로 넘어온 주문자 주소: " + order_address);
		System.out.println("파라미터로 넘어온 주문자 번호 : " + order_mobile);
		System.out.println("파라미터로 넘어온 주문자 이메일 : " + order_email);
		System.out.println("파라미터로 넘어온 배송자 이름 : " + del_name);
		System.out.println("파라미터로 넘어온 배송자 주소 : " + del_address);
		System.out.println("파라미터로 넘어온 배송자 번호 : " + del_mobile);
		System.out.println("파라미터로 넘어온 배송자 이메일 : " + del_email);
		System.out.println("파라미터로 넘어온 배송자 메세지 : " + del_message);
		System.out.println("파라미터로 넘어온 결제 방식 : " + payment_type);
		System.out.println("파라미터로 넘어온 전체 금액 : " + total);
		*/
		
		String content = "";
		
		BasketDAO Basketdao = new BasketDAO(drv, url, mid, mpw);
		
		List<BasketDTO> basketdaoList = Basketdao.selectListPageGoods(id);
		
		for(BasketDTO basketdto : basketdaoList) {
			content += String.format("%s의 구매 개수는 %d개 입니다.\n", basketdto.getName(), basketdto.getAmount());
		}
		
		PurchaseDTO dto = new PurchaseDTO();
		dto.setPurchase_information(content);
		dto.setId(id);
		dto.setOrder_name(order_name);
		dto.setOrder_address(order_address);
		dto.setOrder_mobile(order_mobile);
		dto.setOrder_email(order_email);
		dto.setDel_name(del_name);
		dto.setDel_address(del_address);
		dto.setDel_mobile(del_mobile);
		dto.setDel_email(del_email);
		dto.setDel_message(del_message);
		dto.setPayment_type(payment_type);
		dto.setTotal(total);
		
		PurchaseDAO dao = new PurchaseDAO(drv, url, mid, mpw);
		
		int result = dao.PurchaseInsert(dto);
		
		if(result == 1) {
			req.setAttribute("Purchase", "true");
			req.getRequestDispatcher("../main/main.do").forward(req, resp);
		}else {
			req.setAttribute("Purchase", "false");
			req.getRequestDispatcher("../market/basket02.jsp").forward(req, resp);
		}
		
		
		
		
		
		
		

	}
}
