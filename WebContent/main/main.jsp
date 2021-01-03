<%@page import="util.CookieUtil"%>
<%@page import="sun.font.Script"%>
<%@page import="javafx.scene.control.Alert"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<script src="../common/jquery/jquery-3.5.1.js"></script >
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
</style>
</head>
<script>


	$(function() {
		console.log("1");
		$.ajax({
			//요청할 서버의 경로 url
			url : "../calendar/Calendar2.js",
			//콜백데이터 타입
			dataType : "script",
			//요청시 전송방식
			type : "get",
			//전송방식에 따른 컨텐츠 타입
			contentType : "text/html;charset:utf-8",
			//파라미터. JSON형식
			//성공, 실패시 콜백메소드, sucFunc(매개변수)형태로 사용하지 않는다.
			success : sucFunc,
			error : errFunc
		});
		
	});

	function sucFunc(resData) {
		calendarMaker($('#calendar'), new Date());
		calMoveEvtFn();
	}
	/*
		요청 성공시 호출할 콜백메소드로 jQuery외부에 정의되었다.
		함수명만으로 지정하더라도 콜백데이터는 파라미터로 전달받을 수
		있다. 
	 */
	function errFunc() {
		alert("에러발생, 디버깅 하시세요")
	}
</script>
<body>	
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		
		<div id="main_visual">
		<a href="/product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title" style="border:0px; margin-bottom:0px;">
					<img src="../images/main_title01.gif" alt="로그인 LOGIN" />
				</p>
				<div class="login_box">
				<%if(request.getAttribute("ERROR_MSG")!=null){ %>
					<script>
					alert("회원정보가 잘못되었습니다.");
					</script>
				<%} %>
				
				
				<%
					//혹시나 있을 세션을 지워줌(위에 top에 로그인 버튼을 위해 지우준다.)
					//session.removeAttribute("USER_ID");
					//session.removeAttribute("USER_PW");
					
					//처음 시작했을때를 위해 쿠키를 지워준다.
					//CookieUtil.makeCookie(request, response, "LoginId", "", 0);
					
					//리퀘스트 내장객체를 이용해서 생성된 쿠키를 가져온다.
					Cookie[] cookies = request.getCookies();
					//쿠키값을 저장할 변수
					String id = "", save ="";
					//생성된 쿠키가 존재한다면 
					if(cookies!= null){
						for(Cookie ck : cookies){
							if(ck.getName().equals("LoginId")){
								//로그인 아이디가 있는 확인
								id = ck.getValue();
								System.out.println("id = " + id);
							}
							else if(ck.getName().equals("SaveId")){
								//아이디 저장에 관련된 값이 있는지 확인한다.
								save = ck.getValue();
								System.out.println("save=" + save);
							}
						}
					}
					
					System.out.println("세션에 저장되어 있는 아이디" + session.getAttribute("USER_ID"));
					//로그인 되었는지 확인하기 위해 세션영역에서 속성을 가져온다.
					if(id.length() == 0 || session.getAttribute("USER_ID")==null){
				%>
				
					<script>
						//로그인 폼의 빈값체크를 위한 함수
						function loginValidate(fn){
							if(!fn.user_id.value){
								alert("아이디를 입력하세요");
								fn.user_id.focus();
								return false;
							}
							if(fn.user_pw.value==""){
								alert("패스워드를 입력하세요");
								fn.user_pw.focus();
								return false;
							}
						}
					</script>
					<form action="../Login/LoginProcessMap.jsp" method="post" name="loginFrm"
					onsubmit="return loginValidate(this);">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="45px" />
							<col width="120px" />
							<col width="55px" />
						</colgroup>
						<tr>
							<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
							<td><input type="text" name="user_id" value="<%=(save.length()==0) ? "" : save %>" class="login_input" /></td>
							<td rowspan="2"><input type="image" src="../images/login_btn01.gif" alt="로그인" /></td>
						</tr>
						<tr>
							<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
							<td><input type="password" name="user_pw" value="" class="login_input" /></td>
						</tr>
					</table>
					
					<p>
						<input type="checkbox" name="id_save" value="Y" <% if(save.length() != 0){%>
							checked="checked"
						<% } %> /><img src="../images/login_tit03.gif" alt="저장" />
						<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
					</p>
					</form>
				<%
					}else{
				%>
					<!-- 로그인 후 -->
					<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;">${sessionScope.USER_NAME }님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
					<p style="text-align:right; padding-right:10px;">
						<a href=""><img src="../images/login_btn04.gif" /></a>
						<a href="../Login/Logout.jsp"><img src="../images/login_btn05.gif" /></a>
					</p>
				<% } %>
			 
				</div>
			</div>
			<%
			
			%>
			<div class="main_con_center">
				<p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="../space/sub01_list.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
				<c:choose>
				<c:when test="${empty listsNotice }">
					<li><p><a href="">공지사항이 없습니다.</a></p></li>
				</c:when>
				<c:otherwise>
					<c:forEach items="${listsNotice }" var="row" varStatus="loop">
						<%-- <c:when test="${fn:length(row.title) > 14}">--%>
							<li><p><a href="../space/sub01_view.jsp?num=${row.num }">${fn:substring(row.title,0,13) }</a><span>${row.postdate }</span></p></li>
						<%-- </c:when> 
						<c:otherwise> 
							<li><p><a href="">${row.title }</a><span>${row.postdate }</span></p></li>
						</c:otherwise> --%>
					</c:forEach>
				</c:otherwise>
				</c:choose>
				</ul>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="../space/sub03_list.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
				<c:choose>
				<c:when test="${empty listsBoard }">
					<li><p><a href="">게시물이 없습니다.</a></p></li>
				</c:when>
				<c:otherwise>
					<c:forEach items="${listsBoard }" var="row" varStatus="loop">
					<li><p><a href="../space/sub03_view.jsp?num=${row.num }">${fn:substring(row.title,0,13) }</a><span>${row.postdate }</span></p></li>
				</c:forEach>
				</c:otherwise>
				</c:choose>
				</ul>
			</div>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="../images/main_tel.gif" />
			</div>
			
			<div class="main_con_center">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
			
			<div id="calendar">
			</div>
			
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="../space/sub04_list.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_photo_list">
				<c:choose>
				<c:when test="${empty photoBoard }">
					<li><p><a href="">게시물이 없습니다.</a></p></li>
				</c:when>
				<c:otherwise>
					<c:forEach items="${photoBoard }" var="row" varStatus="loop">
					<li>
						<dl>
							<dt><a href=""><img width="70" height="70" src="${row.file_path }" /></a></dt>
							<li><p>${fn:substring(row.title,0,13) }</a></p></li>
						</dl>
					</li>
					</c:forEach>
				</c:otherwise>
				</c:choose>
					<%-- <li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>--%>
				</ul>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>