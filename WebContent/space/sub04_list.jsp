<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


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
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
<div class="row">
	<!-- 게시판리스트부분 -->
	<table class="table table-bordered table-hover">
	<colgroup>
		<col width="20px"/>
		<col width="20px"/>
		<col width="20px"/>
	</colgroup>
	
	
	<tbody>

		
	<!-- 리스트반복 -->
	
	<tr>
		<td  colspan="3" class="text-center">이미지</td>
	</tr>
	<tr>
		<td colspan="3" class="text-center">제목</td>
	</tr>
	<tr>
		<td colspan="3" class="text-center">내용</td>
	</tr>
	<tr>
		<td class="text-center">이름</td>
		<td class="text-center">시간</td>
		<td class="text-center">조회수</td>
		
	</tr>
	</tbody>
	</table>
</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
