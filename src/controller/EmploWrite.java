package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import model.Multi_boardDAO;
import model.Multi_boardDTO;
import util.FileUtil;

@WebServlet("/controller/EmploWrite.do")
public class EmploWrite extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		
		//request객체와 물리적경로를 매개변수로 upload()를 호출한다.
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("data"));
		
		System.out.println(mr);
		
		int sucOrFail;
		
		if(mr !=null) {
			HttpSession session = req.getSession(true);

			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String file = mr.getFilesystemName("file");
			String file_path = "/Project2/upload/"+file;
			
			System.out.println("파라미터로 넘어온 제목 : "+ title);
			System.out.println("파라미터로 넘어온 내용  : " +content);
			System.out.println("파라미터로 넘어온 파일명 : " +  file);
			System.out.println("파일 경로 : " + file_path);
			System.out.println("세션에 존재하는 아이디 확인  : " + session.getAttribute("USER_ID").toString());
			
			

			Multi_boardDTO dto = new Multi_boardDTO();
			dto.setId(session.getAttribute("USER_ID").toString());
			dto.setTitle(title);
			dto.setContent(content);
			dto.setFile(file);
			dto.setFile_path(file_path);
			
			
			Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
			
			sucOrFail = dao.insertEmplo(dto);
			
			dao.close();
		}else {
			//mr객체가 생성되지 않은 경우, 즉 파일 업로드 실패시...
			sucOrFail = -1;
		}
		
		if(sucOrFail ==1) {
			req.getRequestDispatcher("emploList.do").forward(req, resp);
		}
		else {
			req.getRequestDispatcher("../community/sub01_write").forward(req, resp);
		}
		
		
	}
}
