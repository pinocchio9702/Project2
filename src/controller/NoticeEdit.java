package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import model.Multi_boardDAO;
import model.Multi_boardDTO;
import util.FileUtil;

@WebServlet("/admin/noticeEdit.do")
public class NoticeEdit extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		

		
		req.setCharacterEncoding("UTF-8");

		String num = req.getParameter("num");
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		//수정폼을 구성하기 위해 게시물의 내용을 가져온다.
		Multi_boardDTO dto = dao.selectView(num);
		
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("../admin/noticeEdit.jsp").forward(req, resp);
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("여기는 오는가?");
		
		req.setCharacterEncoding("UTF-8");
		
		
		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		//첨부파일 업로드
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("images/upload"));
		
		System.out.println(mr);
		
		int sucOrFail;
		
		//멀티파트 객체가 정상적으로 생성되면 나머지 폼값을 받아온다.
		if(mr != null) {
			String num = mr.getParameter("num");
			String name = mr.getParameter("name");
			
			System.out.println("2");
			//수정처리후 상세보기 페이지로 이동해야 하므로 영역에 속성을 저장한다.
			req.setAttribute("num", num);
			

			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String file = mr.getParameter("file");
			
			System.out.println("num : " + num);
			System.out.println("name : " + name);
			System.out.println("title : " + content);
			System.out.println("file : " + file);
			
			
			Multi_boardDTO dto = new Multi_boardDTO();
			dto.setFile(file);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setName(name);
			dto.setNum(num);
			
			/*
			 레코드의 update가 성공이고 동시에 새로운 파일이 업로드 되었다면
			 기존의 파일은 삭제처리한다.
			 첨부한 파일이 없다면 기존파일은 유지된다.
			 */
			ServletContext app = this.getServletContext();
			sucOrFail = dao.update(dto);
			
//			if(sucOrFail == 1) {
//				FileUtil.deleteFile(req, "image/upload", file);
//			}
			
			dao.close();
		}
		else {
			sucOrFail = -1;
		}
		
		//수정처리 이후에는 상세보기 페이지로 이동한다.
		req.setAttribute("SUC_FAIL", sucOrFail);
		req.setAttribute("WHEREIS", "UPDATE");
		
		req.getRequestDispatcher("noticeList").forward(req, resp);
		
	}
}
