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
import javax.servlet.http.HttpSession;

import model.MembershipDAO;
import model.MembershipDTO;
import model.Multi_boardDAO;
import model.Multi_boardDTO;
import util.PagingUtil;

@WebServlet("/controller/emploList.do")
public class EmploList extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext application = this.getServletContext();
		
		//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
		String drv = application.getInitParameter("MariaJDBCDriver");
		String url = application.getInitParameter("MariaConnectURL");
		String mid = application.getInitParameter("MariaUser");
		String mpw = application.getInitParameter("MariaPass");
		
		Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
		
		//직원 확인하기
		HttpSession session = req.getSession(true);

		MembershipDTO membshipDTO = new MembershipDTO();
		MembershipDAO memberDAO = new MembershipDAO(drv, url, mid, mpw);
		
		System.out.println(session.getAttribute("USER_ID").toString());
		
		String grade = memberDAO.selectGrade(session.getAttribute("USER_ID").toString());
		
		if(grade.equals("U")) {
			System.out.println("grade가 U : " + grade);
			req.setAttribute("grade", "일반 회원은 접근하실 수 없습니다.");
			req.getRequestDispatcher("../controller/guardian_list.do").forward(req, resp);
		}
		else {
			Map param = new HashMap();
			String addQueryString = "";
			//검색어 관련 파라미터 처리
			String keyField = req.getParameter("keyField");
			String keyString = req.getParameter("keyString");
			
			if (!(keyField == null || keyString.equals(""))) {

				//검색어가 있는 경우 파라미터를 Map에 저장하고, 쿼리스트링을 만들어준다.
				//쿼리스트링은 상세보기나 글쓰기 후에 검색이 풀리는 것을 방지하는 코드를 작성하기 위해 만든다.
				addQueryString = String.format("keyField=%s&keyString=%s", keyField, keyString);
				param.put("Column", keyField);
				param.put("Word", keyString);
			}
			
			//테이블의 전체 레코드 수를 카운트
			int totalRecordCount = dao.getTotalRecordCountEmplo(param);
			
			//전체 레코드 수를 Map에 저장한다. 차후 View로 전달한다.
			param.put("totalCount", totalRecordCount);
			
			int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
			int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

			//전체 페이수를 계산한다.
			int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);
			
			System.out.println("전체레코드수 : " + totalRecordCount);
			System.out.println("전체페이지수 : " + totalPage);
			
			//현재 페이지번호를 설정한다. 최초진입시에는 무조건 1로 설정한다.
			int nowPage = (req.getParameter("nowPage") == null || req.getParameter("nowPage").equals("")) ? 1
					: Integer.parseInt(req.getParameter("nowPage"));

			int start = (nowPage - 1) * pageSize;
			int end = pageSize;

			//Map 컬렉션 테이터 저장
			param.put("start", start);
			param.put("end", end);
			param.put("totalPage", totalPage);
			param.put("nowPage", nowPage);
			param.put("totalCount", totalRecordCount);
			param.put("pageSize", pageSize);
			
			
			String pagingImg = PagingUtil.paginBS4(totalRecordCount, pageSize, blockPage, nowPage,
					"emploList.do?" + addQueryString);
			param.put("pagingImg", pagingImg);
			
			List<Multi_boardDTO> listsEmplo = dao.selectListPageEmploy(param); //페이지 처리 o
			
			//DB연결을 헤제하는 것이 아니라 커넥션풀에 개체를 반납한다.
			dao.close();
			
			//데이터를 request영역에 저장한다.
			req.setAttribute("listsEmplo", listsEmplo);
			req.setAttribute("map", param);
			
			req.getRequestDispatcher("../community/sub01_list.jsp").forward(req, resp);
		}
		
		//req.getRequestDispatcher("../community/sub02_list.jsp").forward(req, resp);
	}
}
