<%@page import="model.CalendarDTO"%>
<%@page import="model.CalendarDAO"%>
<%@page import="model.Multi_boardDTO"%>
<%@page import="model.Multi_boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<%

String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");
//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");
CalendarDAO dao = new CalendarDAO(drv, url, mid, mpw);
//일련번에 해당하는 게시물을 DTO객체로 반환함.
CalendarDTO dto = dao.selectView(num);

System.out.println("dto 아이디 : " + dto.getId());
System.out.println("dto 제목"+dto.getTitle());
System.out.println("dto 내용 " + dto.getContent());
System.out.println("dto 날자" + dto.getCal_date());
System.out.println("dto 일련번호 : " + dto.getNum());

dao.close();
%>

<script>
	<c:if test="${not empty request.update }">
		alert("게시물이 지워지지 않았습니다.");
	</c:if>
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub05_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
				</div>
				<div>

<form enctype="multipart/form-data">
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td colspan="3">
			<%=dto.getId() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<%=dto.getTitle() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<%=dto.getContent().replace("\r\n", "<br/>") %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">일정</th>
		<td colspan="3">
			<%=dto.getCal_date() %>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">

	<button type="button" class="btn btn-warning" 
		onclick="location.href='../space/sub02_list.jsp';">리스트보기</button>
</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>