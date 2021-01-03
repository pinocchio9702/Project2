<%@page import="model.Multi_boardDTO"%>
<%@page import="model.Multi_boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<script>
	<c:if test="${not empty request.update }">
		alert("게시물이 지워지지 않았습니다.");
	</c:if>
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file="../include/community_leftmenu.jsp"%>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
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
		<td>
			${dto.name }
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			${dto.postdate }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			${dto.email }
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			${dto.visitcount }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			${dto.title }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			${dto.content }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<c:if test="${not empty dto.file }">
				${dto.file }
				<a href=".../controller/DataDownload=${dto.file }&num=${dto.num}">
					[다운로드]
				</a>
			</c:if>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	
	<c:if test="${not empty sessionScope.USER_ID &&  sessionScope.USER_ID == dto.getId() }">
	<button type="button" class="btn btn-primary"  onclick="location.href='../controller/EmploEdit.do?num=${dto.num}';">수정하기</button>
	<button type="button" class="btn btn-success" onclick="location.href='../controller/EmploDelete.do?num=${dto.num}';">삭제하기</button>	
	</c:if>
	
	<button type="button" class="btn btn-warning" 
		onclick="location.href='../controller/emploList.do';">리스트보기</button>
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