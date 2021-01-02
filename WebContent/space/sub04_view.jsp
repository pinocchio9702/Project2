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
/*
검색 후 파라미터 처리를 위한 추가부분
	: 리스트에서 검색 후 상세보기, 그리고 다시 리스트 보기를
	눌렀을때 검색이 유지되도록 처리하기 위한 코드
*/
String queryStr = "";

String searchColumn = request.getParameter("keyField");
String searchWord = request.getParameter("keyString");

if(searchWord != null){
	queryStr += "keyField=" + searchColumn + "&keyString=" + searchWord;
}
//2페이지에서 상세보기 했다면 리스트로 돌아갈때도 페이지가 유지되어야 한다.
String nowPage = request.getParameter("nowPage");
queryStr += "&nowPage="+nowPage;
//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");
System.out.println(num);
Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
//조회수를 업데이트하여 visitcount컬럼을 1증가시킴
dao.updateVisitCount(num);
//일련번에 해당하는 게시물을 DTO객체로 반환함.
Multi_boardDTO dto = dao.selectView(num);

System.out.println("이름은 : " + dto.getName());
System.out.println("게시물의 이름은 : " + dto.getBoard_name());
System.out.println("이메일 정보 는 : " + dto.getEmail());
System.out.println("게시물의 이메일 정보 는 : " + dto.getBoard_email());
System.out.println("게시물의 이미지경로는 : " + dto.getFile_path());
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
					<img src="../images/space/sub04_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
				<div>

<form enctype="multipart/form-data">
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			<%if(dto.getBoard_name() == null){ %>
				<%=dto.getName() %>
			<%}else{ %>
				<%=dto.getBoard_name() %>
			<%} %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			<%=dto.getPostdate() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<%if(dto.getBoard_email() == null){ %>
				<%=dto.getEmail() %>
			<%}else{ %>
				<%=dto.getBoard_email() %>
			<%} %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			<%=dto.getVisitcount() %>
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
			style="vertical-align:middle;">사진</th>
		<td colspan="3">
			<img src=<%=dto.getFile_path() %> style="height:200px; width:200px">
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="button" class="btn btn-primary"  onclick="location.href='../controller/PhotoEdit.do?num=<%=dto.getNum()%>';">수정하기</button>
	<button type="button" class="btn btn-success" onclick="location.href='../controller/PhotoDelete.do?num=<%=dto.getNum()%>';">삭제하기</button>	
	<button type="button" class="btn btn-warning" 
		onclick="location.href='../space/sub04_list.jsp';">리스트보기</button>
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