package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Multi_boardDAO;
import model.Multi_boardDTO;
import util.PagingUtil;

@WebServlet("/controller/listctrl.do")
public class ListCtrl extends HttpServlet{
 
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext application = this.getServletContext();
		
		//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		//DAO객체 생성 및 커넥션풀을 통한 DB연결
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		//컨트롤러(서블릿) 및 View(jsp)로 전달할 파라미터를 저장하기 위한 맵 컬렉션
		Map param = new HashMap();
		String addQueryString = "";  
		
		//검색어 관련 파라미터 처리
		String keyField = req.getParameter("keyField");
		String keyString = req.getParameter("keyString");
		if(!(keyField == null || keyString.equals(""))) {
			
			//검색어가 있는 경우 파라미터를 Map에 저장하고, 쿼리스트링을 만들어준다.
			//쿼리스트링은 상세보기나 글쓰기 후에 검색이 풀리는 것을 방지하는 코드를 작성하기 위해 만든다.
			addQueryString =
					String.format("keyField=%s&keyString=%s", keyField, keyString);
			param.put("Field", keyField);
			param.put("keyString", keyString);
		}
		//테이블의 전체 레코드 수를 카운트
		int totalRecordCount = dao.getTotalRecordCountNotice(param);
		//전체 레코드 수를 Map에 저장한다. 차후 View로 전달한다.
		param.put("totalCount", totalRecordCount);
		
		//페이지 처리 추가 부분start/////////////////////////////////////////
		
		/*
		web.xml의 컨텍스트 초기화 파라미터를 서블릿에서 가져오기 위해
		application내장 객체를 메소드를 통해 얻어와서 값을 얻어온다.
		 */
		
		int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
		int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));
		
		//전체 페이수를 계산한다.
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		
		System.out.println("전체레코드수 : " + totalRecordCount);
		System.out.println("전체페이지수 : " + totalPage);
		
		//현재 페이지번호를 설정한다. 최초진입시에는 무조건 1로 설정한다.
		int nowPage = (req.getParameter("nowPage") ==null || req.getParameter("nowPage").equals(""))
				? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		//한페이지에 출력할 게시물의 구간을 정하기 위해  start,end값 계산
		/*
			페이지 처리를 위해 오라클에서는 서브쿼리와 rownum을 이용하지만
			마리아딥에서는 limit를 사용하므로 아래 계산식이 달라져야한다.
		 */
		int start = (nowPage-1) * pageSize;
		int end = pageSize;
		
		//Map 컬렉션 테이터 저장
		param.put("start", start);
		param.put("end", end);
		param.put("totalPage", totalPage);
		param.put("nowPage", nowPage);
		param.put("totalCount", totalRecordCount);
		param.put("pageSize", pageSize);
		
		String pagingImg = PagingUtil.paginBS4(totalRecordCount, pageSize, blockPage, nowPage, "../DataRoom/DataList?" + addQueryString);
		param.put("pagingImg", pagingImg);
		
		//페이지 처리 추가부분end/////////////////////////////////////////
		
		
		//테이블 전체 레코드를 가져와서 List 컬렉션에 저장한다.
		//List<DataroomDTO> lists = dao.selectList(param); //페이지 처리 x
	
		List<Multi_boardDTO> listsNotice = dao.selectListPageNotice(param); //페이지 처리 o
		
		//DB연결을 헤제하는 것이 아니라 커넥션풀에 개체를 반납한다.
		dao.close();
		
		//데이터를 request영역에 저장한다.
		req.setAttribute("listsNotice", listsNotice);
		req.setAttribute("map", param);
		
		//영역에 저장된 데이터를 View로 전달하기 위해 포워드한다.
		req.getRequestDispatcher("/space/sub01_list.jsp").forward(req, resp);
		
		
		
	}
	
	/*
	만약 게시판 리스트쪽에서 post방식으로 요청이 들어오더라도
	처리는 doGet()에서 처리할 수 있도록 모든 요청을 토스한다.
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
