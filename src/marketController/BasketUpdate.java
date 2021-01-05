package marketController;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BasketDAO;

@WebServlet("/market/basketUpdate.do")
public class BasketUpdate extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		String[] goods_nums = req.getParameterValues("goods_num"); 
		String[] ids = req.getParameterValues("id");
		String[] amounts = req.getParameterValues("amount");
		
		BasketDAO dao = new BasketDAO(drv, url, mid, mpw);
		for(int i=0; i<goods_nums.length; i++) {
			System.out.println(goods_nums[i]);
			System.out.println(ids[i]);
			System.out.println(amounts[i]);
			
			int result = dao.basketUpdate(Integer.parseInt(amounts[i]), Integer.parseInt(goods_nums[i]), ids[i]);
		}
		req.getRequestDispatcher("../market/basket.jsp").forward(req, resp);
		
	}
}
