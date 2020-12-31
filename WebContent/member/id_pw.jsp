<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

<c:if test="${not empty id}">
	alert("당신의 아이디는${id }입니다.");
</c:if>

</script>
 
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
					<form name="FindId" action="../controller/FindId.do">
						<ul>
							<li><input type="text" name="name" value="" class="login_input01" /></li>
							<li><input type="text" name="email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:FindId.submit()" ><img data-toggle="modal" data-target="#myModal" src="../images/member/id_btn01.gif" class="id_btn" /></a>
						<a href="join02.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</div>
					</form>
					<div class="pw_box">
						<ul>
							<li><input type="text" name="" value="" class="login_input01" /></li>
							<li><input type="text" name="" value="" class="login_input01" /></li>
							<li><input type="text" name="" value="" class="login_input01" /></li>
						</ul>
						<a href=""><img src="../images/member/id_btn01.gif" class="pw_btn" /></a>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>

 </body>
</html>
