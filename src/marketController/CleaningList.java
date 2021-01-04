package marketController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CleaningDAO;
import model.CleaningDTO;

@WebServlet("/admin/cleaningList")
public class CleaningList extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		CleaningDAO dao = new CleaningDAO(drv, url, mid, mpw);
		
		List<CleaningDTO> CleaningList = dao.selectCleaingList();
		
		System.out.println("저장한 claeningList : "+CleaningList);
		
		req.setAttribute("CleaningList", CleaningList);
		
		req.getRequestDispatcher("../admin/cleaningList.jsp").forward(req, resp);
	}
}
