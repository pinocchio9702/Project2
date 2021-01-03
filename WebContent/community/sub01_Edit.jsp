<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${not empty request.delete }">
	<script>
		alert("게시물이 지워지지 않았습니다.");
	</script>
</c:if>
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
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;직원자료실&nbsp;>&nbsp;<p>
				</div>
				<div>

<form method="post" action="../controller/EmploEdit.do" 
	enctype="multipart/form-data">
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<input type="hid-den" name="num" value="${dto.num }" />
	<input type="hid-den" name="originalfile" value="${dto.file }" />
	
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" class="form-control" 
				name="title" value="${dto.title }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea name="content" rows="10" class="form-control">${dto.content }</textarea>
		</td>
	</tr>
	<tr>
		<th class="text-center"
			style="vertical-align:middle;">첨부파일</th>
		<td>
			파일명 : ${dto.file } 
			<input type="file" class="form-control" name="file" "/>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
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