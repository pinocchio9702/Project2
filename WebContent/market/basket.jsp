<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.Vector"%>
<%@page import="model.BasketDAO"%>
<%@page import="model.BasketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.USER_ID }">
	<script type="text/javascript">
		alert("로그인 후 접속해주세요");
		location.href = "../main/main.do";
	</script>
</c:if>

<% 
if(session.getAttribute("USER_ID") == null){
%>
	<script type="text/javascript">
		alert("로그인 후 접속해주세요");
		location.href = "../main/main.do";
	</script>

<%
	return;
}

//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");

BasketDAO dao = new BasketDAO(drv, url, mid, mpw);

String id = session.getAttribute("USER_ID").toString();

System.out.println("장바구니에 넘어온 아이디 : " + id);

List<BasketDTO> basketList = dao.selectListPageGoods(id);

int sum = 0;
//배송비
int delivery = 0;

for(BasketDTO dto : basketList){
	sum += dto.getTotal();
	System.out.println(dto.getGoods_num());
}

dao.close();

request.setAttribute("basketList", basketList);

%>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="8%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>적립금</th>
							<th>수량</th>
							<th>배송구분</th>
							<th>배송비</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
					<c:when test="${empty basketList}">
						<tr>
							<td colspan="9">장바구니가 텅 비었습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<form action="../market/basketUpdate.do" method="post"
							name="update">
						<c:forEach items="${basketList }" var="row" varStatus="loop">
						<tr>
							<input type="hidden" name="goods_num" value="${row.goods_num}" />
							<input type="hidden" name="id" value="${row.id}" />
							<td><input type="checkbox" name="" value="" /></td>
							<td><img width="100px" height="100px" src="${row.image_path }" /></td>
							<td>${row.name }</td>
							<td>${row.price }원</td>
							<td><img src="../images/market/j_icon.gif" />&nbsp;${row.saved }</td>
							<td><input type="text" name="amount" value="${row.amount }" class="basket_num" />&nbsp;<a href="javascript:update.submit()"><img src="../images/market/m_btn.gif" /></a></td>
							<td>무료배송</td>
							<td>[조건]</td>
							<td><span>${row.total }원<span></td>
						</tr>
						</c:forEach>
						</form>
					</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				<p class="basket_text">[ 기본 배송 ] <span>상품구매금액</span> <%=sum %> + <span>배송비</span><%=delivery %> = 합계 : <span class="money"><%=sum + delivery %></span><br /><br /><a href=""><img src="../images/market/basket_btn01.gif" /></a>&nbsp;<a href="basket02.jsp"><img src="../images/market/basket_btn02.gif" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
