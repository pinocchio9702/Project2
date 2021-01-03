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

@WebServlet("/controller/GuardianEdit.do")
public class GuardianEdit extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		String num = req.getParameter("num");
		
		//수정폼을 구성하기 위해 게시물의 내용을 가져온다.
		Multi_boardDTO dto = dao.selectView(num);		
		
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("../community/sub02_Edit.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		//request객체와 물리적경로를 매개변수로 upload()를 호출한다.
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("data"));
		
		int sucOrFail;
		
		if(mr != null) {
			String num = mr.getParameter("num");
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String file = mr.getFilesystemName("file");
			String originalfile = mr.getParameter("originalfile");
			String file_path = "/Project2/upload/"+file;
			
			System.out.println("파라미터로 넘어온 게시물 일련번혼 : " + num);
			System.out.println("파라미터로 넘어온 제목 : "+ title);
			System.out.println("파라미터로 넘어온 내용  : " +content);
			System.out.println("파라미터로 넘어온 파일명 : " +  file);
			System.out.println("파라미터로 넘어온 원본 파일명 : " + originalfile);
			System.out.println("파일 경로 : " + file_path);
			
			Multi_boardDTO dto = new Multi_boardDTO();
			dto.setNum(num);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setFile(file);
			dto.setFile_path(file_path);
			
			sucOrFail = dao.Photoupdate(dto);
			
			if(sucOrFail == 1 && mr.getFilesystemName("file")!=null) {
				System.out.println("삭제하기 위한 조건문을 들어오는지 디버깅");
				FileUtil.deleteFile(req, "/data", originalfile);
			}
			
			dao.close();
		}else {
			sucOrFail = -1;
		}
		
		if(sucOrFail ==1) {
			req.getRequestDispatcher("guardian_list.do").forward(req, resp);
		}
		else {
			req.getRequestDispatcher("../community/sub01_Edit.jsp").forward(req, resp);
		}
	
	}
}
