package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Multi_boardDAO;
import model.Multi_boardDTO;
import util.FileUtil;

@WebServlet("/admin/noticeDelete.do")
public class Noticedelete extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");

		String num = req.getParameter("num");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		//첨부파일 삭제를 위해 기존의 게시물을 가져와서 DTO객체에 저장
		Multi_boardDTO dto = dao.selectView(num);
		
		
		int sucOrFail = dao.delete(num);
		if(sucOrFail == 1) {
			//게시물의 삭제가 완료되었다면 첨부파일도 삭제한다.
			String fileName = dto.getFile();
			//경로명, 파일명을 전달하여 물리적경로에 젖아된 파일을 삭제처리함
			FileUtil.deleteFile(req, "image/upload", fileName);
			
		}
		
	
		req.getRequestDispatcher("noticeList").forward(req, resp);
	}
}
