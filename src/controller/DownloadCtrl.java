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
@WebServlet("/admin/Download")
public class DownloadCtrl extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		ServletContext application = this.getServletContext();
		// web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		String filename = req.getParameter("filename");
		/*
		방법1 : 서버에 저장된 파일명 그대로 다운로드.
			파일명을 변경할 필요가 없으므로 파일명에 관련된 파라미터는 1개만 있다.
		*/
		//FileUtil.download(req, resp, "/Upload", filename);
		/*
		방법2 : 서버에 저장된 파일을 다운로드 할때는 원본 파일명으로
			변경하여 다운로드 한다. 이떄는 저장된 파일명과 원본 파일명이
			각각 테이블에 저장되어 있어야 한다. 여기서는 파일명 변경에
			대해서만 확인해본다.
			FileUtil.download(reqest객체, response객체, 디렉토리명, 서버에 저장된 파일명, 원본파일명);
		 */
		FileUtil.download(req, resp, "image/upload", filename);
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);

		dao.close();
	}
}
