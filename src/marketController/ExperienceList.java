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
import model.ExperienceDAO;
import model.ExperienceDTO;

@WebServlet("/admin/experienceList")
public class ExperienceList extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		ExperienceDAO dao = new ExperienceDAO(drv, url, mid, mpw);
		
		List<ExperienceDTO> ExperienceList = dao.selectExperienceList();
		
		
		req.setAttribute("ExperienceList", ExperienceList);
		
		req.getRequestDispatcher("../admin/experienceList.jsp").forward(req, resp);
	}
}
