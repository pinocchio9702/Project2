package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Multi_boardDAO;
import util.FileUtil;
@WebServlet("/controller/DataDownload")
public class DataDownload extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		String filename = req.getParameter("file");
		System.out.println("파라미터로 넘어온 파일 이름 : " + filename);
		/*
		방법1 : 서버에 저장된 파일명 그대로 다운로드.
			파일명을 변경할 필요가 없으므로 파일명에 관련된 파라미터는 1개만 있다.
		*/
		FileUtil.download(req, resp, "/data", filename);

	}
}
