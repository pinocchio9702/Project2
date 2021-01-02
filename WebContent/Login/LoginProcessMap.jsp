<%@page import="java.util.Map"%>
<%@page import="util.CookieUtil"%>
<%@page import="model.MembershipDTO"%>
<%@page import="model.MembershipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
System.out.println("넘어옴?");
	//폼값 받기
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");
String id_save = request.getParameter("id_save");

System.out.println("프로제스로 파라미터로 넘어온 user_id : " + id);

//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");

//DAO객체 생성 및 디비 연결
MembershipDAO dao = new MembershipDAO(drv, url, mid, mpw);

//폼값으로 받은 아이디, 패스워드를 통해 로그인 처리 함수 호출
//방법3 : Map컬렉션에 저장된 회원정보를 통해 세션 영역에 저장
Map<String, String> memberShipMap = dao.getMembershipMap(id, pw);

System.out.println("dao객체로 Map에 저장된 회원 아아디 : " + memberShipMap.get("id"));
//if(id.equals(memberDTO.getId()) && pw.equals(memberDTO.getPass())){
if (memberShipMap.get("id") != null) {
	System.out.println("1");
	//로그인 성공시 회원 아이디를 쿠키로 생성한다.
	CookieUtil.makeCookie(request, response, "LoginId", id, 60 * 60 * 24);
	//나중에 로그인 체크 편의를 위해 session에 넣어줌
	session.setAttribute("USER_ID", memberShipMap.get("id"));
	session.setAttribute("USER_PW", memberShipMap.get("pass"));
	session.setAttribute("USER_NAME", memberShipMap.get("name"));
	//session.setAttribute("USER_EMAIL", memberShipMap.get("email"));

	//아이디 저장하기 체크박스를...
	if (id_save == null) {
		System.out.println("2");
		//체크헤제하면 쿠키를 삭제하낟.
		CookieUtil.makeCookie(request, response, "SaveId", "", 0);
	}
	else {
		System.out.println("3");
		//체크하면 쿠키를 생성한다.
		CookieUtil.makeCookie(request, response, "SaveId", id, 60 * 60 * 24);
	}
		
	System.out.println("세션에 저장된어 있는지 main가지전 최종 확인" + session.getAttribute("USER_ID"));
	response.sendRedirect("../main/main.do");

} else {
	System.out.println("1");
	request.setAttribute("ERROR_MSG", "회원이 아닙니다.");
	request.getRequestDispatcher("../main/main.do").forward(request, response);
}
%>
