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

@WebServlet("/admin/noticeWrite")
public class NoticeWrite extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("1");
		req.setCharacterEncoding("UTF-8");

		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		HttpSession session = req.getSession(true);
		
		//request객체와 물리적경로를 매개변수로 upload()를 호출한다.
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("images/upload"));
		
		System.out.println("2");
		
		int sucOrFail;
		
		if(mr !=null) {
			System.out.println("3");
			/*
			파일업로드가 완료되면 나머지 폼값을 받기 위해 mr참조변수를 이용한다.
			*/
			
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			//서버에 저장된 실제파일명을 가져온다.
			String attachedfile = 
			mr.getFilesystemName("attachedfile");
			
			System.out.println(title);
			System.out.println(content);
			System.out.println(attachedfile);
			System.out.println(session.getAttribute("USER_ID").toString());
			
			
			//DTO객체에 위에 폼값을 저장한다.
			Multi_boardDTO dto = new Multi_boardDTO();
			dto.setFile(attachedfile);
			dto.setContent(content);
			dto.setTitle(title);
			
			dto.setId(session.getAttribute("USER_ID").toString());
			
			//DAO객체 생성 및 연결...insert처리
			Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
			
			//파일 업로드 성공 및 insert성공시...
			sucOrFail = dao.insertNotice(dto);
			/*
			페이지 처리를 위한 100개 데이터 입력
			
			sucOrFail = 1;
			for(int i = 1; i <=100; i++ ) {
				dto.setTitle("자료실" + i + "번째 포스팅");
				dao.insert(dto);
			}
			*/
			dao.close();
			System.out.println("4");
		}else {
			//mr객체가 생성되지 않은 경우, 즉 파일 업로드 실패시...
			sucOrFail = -1;
		}
		if(sucOrFail ==1) {
			System.out.println("5");
			resp.sendRedirect("noticeList");
		}
		else {
			System.out.println("6");
			req.getRequestDispatcher("../admin/noticeWrite.jsp").forward(req, resp);
		}
		
		//req.getRequestDispatcher("noticeList").forward(req, resp);
	}
}
