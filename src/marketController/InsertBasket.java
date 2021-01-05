package marketController;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BasketDAO;
import model.BasketDTO;

@WebServlet("/market/insertBasket.do")
public class InsertBasket extends HttpServlet{
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
		
		int amount = Integer.parseInt(req.getParameter("amount"));
		int goods_num = Integer.parseInt(req.getParameter("goods_num"));
		String id = req.getParameter("id");
		
		System.out.println("insert로 파라미터로 넘어오 수량 : " + amount);
		System.out.println("insert로 파라미터로 넘어오 일련번호 : " + goods_num);
		System.out.println("insert로 파라미터로 넘어오 아이디 : " + id);
		
		BasketDTO dto = new BasketDTO();
		dto.setGoods_num(goods_num);
		dto.setAmount(amount);
		dto.setId(id);
		
		BasketDAO dao = new BasketDAO(drv, url, mid, mpw);
		
		int result = dao.insertBasket(dto);
		
		if(result == 1) {
			req.setAttribute("insert", "true");
			req.getRequestDispatcher("../market/sub01.jsp").forward(req, resp);
		}else {
			req.setAttribute("insert", "false");
			req.getRequestDispatcher("../market/sub01.jsp").forward(req, resp);
		}
		
		
		
		
	}

}
