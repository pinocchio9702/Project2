<%@page import="model.BasketDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.BasketDAO"%>
<%@page import="model.GoodsDTO"%>
<%@page import="model.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${requestScope.Purchase eq 'false' }">
	<script type="text/javascript">
		alert("구매의 실패했습니다.");
	</script>
</c:if>



<%
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
}

dao.close();

request.setAttribute("basketList", basketList);

%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

function zipFind(){
    new daum.Postcode({
        oncomplete: function(data) {
            console.log(data.zonecode);
            console.log(data.address);
            console.log(data.sido);
            console.log(data.sigungu);

            //가입폼에 적용하기(form을 가져오기)
            var f = document.purchaseInsert;
            //폼이름을 가져오면 태그의 이름으로 그 태그를 제어할 수 있다.
            //zonecode.value(input태그)에 zonecode을 넣기
            f.order_address1.value = data.zonecode;
            //address1.value(input태그)에 address을 넣기
            f.order_address3.value = data.address;
            f.order_address4.focus();
        }
    }).open();
}

function zipFind_del(){
    new daum.Postcode({
        oncomplete: function(data) {
            console.log(data.zonecode);
            console.log(data.address);
            console.log(data.sido);
            console.log(data.sigungu);

            //가입폼에 적용하기(form을 가져오기)
            var f = document.purchaseInsert;
            //폼이름을 가져오면 태그의 이름으로 그 태그를 제어할 수 있다.
            //zonecode.value(input태그)에 zonecode을 넣기
            f.del_address1.value = data.zonecode;
            //address1.value(input태그)에 address을 넣기
            f.del_address3.value = data.address;
            f.del_address4.focus();
        }
    }).open();
}
</script>

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
				<p class="con_tit"><img src="../images/market/basket_title01.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list" style="margin-bottom:50px;">
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
									<td colspan="9">구매목록이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${basketList }" var="row" varStatus="loop">
									<tr>
										<td><input type="checkbox" name="" value="" /></td>
										<td><img width="100px" height="100px" src="${row.image_path }" /></td>
										<td>${row.name }</td>
										<td>${row.price }원</td>
										<td><img src="../images/market/j_icon.gif" />&nbsp;${row.saved }</td>
										<td><input type="text" name="" value="${row.amount }" class="basket_num" />&nbsp;<a href=""><img src="../images/market/m_btn.gif" /></a></td>
										<td>무료배송</td>
										<td>[조건]</td>
										<td><span>${row.total }원<span></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<form action="../market/purchaseInsert.do" name="purchaseInsert"
						method="post">
				<p class="con_tit"><img src="../images/market/basket_title02.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="order_name"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name="order_address1"  value="" class="join_input" style="width:50px; margin-bottom:5px;" /> - <input type="text" name="order_address2"  value="" class="join_input" style="width:50px; margin-bottom:5px;" /> <a href="javascript:;" title="새 창으로 열림" onclick="zipFind();"><img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" /></a><br /><input type="text" name="order_address3"  value="" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br /><input type="text" name="order_address4"  value="" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="order_mobile1"  value="" class="join_input" style="width:50px;" /> - <input type="text" name="order_mobile2"  value="" class="join_input" style="width:50px;" /> - <input type="text" name="order_mobile3"  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="order_email1"  value="" class="join_input" style="width:100px;" /> @ <input type="text" name="order_email2"  value="" class="join_input" style="width:100px;" /></td>
						</tr>
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title03.gif" /></p>
				<p style="text-align:right">배송지 정보가 주문자 정보와 동일합니까? 예<input name="order_del" onclick="check(this)" value="true" type="radio" /> 아니오<input name="order_del" onclick="check(this)" value="false" type="radio" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="del_name"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name="del_address1"  value="" class="join_input" style="width:50px; margin-bottom:5px;" /> - <input type="text" name="del_address2"  value="" class="join_input" style="width:50px; margin-bottom:5px;" /> <a href="javascript:;" title="새 창으로 열림" onclick="zipFind_del();"><img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" /></a><br /><input type="text" name="del_address3"  value="" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br /><input type="text" name="del_address4"  value="" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="del_mobile1"  value="" class="join_input" style="width:50px;" /> - <input type="text" name="del_mobile2"  value="" class="join_input" style="width:50px;" /> - <input type="text" name="del_mobile3"  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="del_email1"  value="" class="join_input" style="width:100px;" /> @ <input type="text" name="del_email2"  value="" class="join_input" style="width:100px;" /></td>
						</tr>
						<tr>
							<th>배송메세지</th>
							<td style="text-align:left;"><input type="text" name="del_message"  value="" class="join_input" style="width:500px;" /></td>
						</tr>
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title04.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:30px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제금액</th>
							<input type="hidden" value="<%=sum %>" name="total" />
							<td style="text-align:left;"><span class="money"><%=sum %></span></td>
						</tr>
						<tr>
							<th>결제방식선택</th>
							<td style="text-align:left;"><input name="payment_type" value="card" type="radio" /> 카드결제&nbsp;&nbsp;&nbsp;<input name="payment_type"  value="deposit" type="radio" /> 무통장입금&nbsp;&nbsp;&nbsp;<input name="payment_type" value="transfer" type="radio" /> 실시간 계좌이체</td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:right;"><a href="javascript:purchaseInsert.submit()"><img src="../images/market/basket_btn04.gif" /></a></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
 
 <script>
function check(flag) {
	if(flag.value == "true"){
		document.getElementsByName("del_name")[0].value = document.getElementsByName("order_name")[0].value;
		document.getElementsByName("del_address1")[0].value = document.getElementsByName("order_address1")[0].value;
		document.getElementsByName("del_address2")[0].value = document.getElementsByName("order_address2")[0].value;
		document.getElementsByName("del_address3")[0].value = document.getElementsByName("order_address3")[0].value;
		document.getElementsByName("del_address4")[0].value = document.getElementsByName("order_address4")[0].value;
		document.getElementsByName("del_mobile1")[0].value = document.getElementsByName("order_mobile1")[0].value;
		document.getElementsByName("del_mobile2")[0].value = document.getElementsByName("order_mobile2")[0].value;
		document.getElementsByName("del_mobile3")[0].value = document.getElementsByName("order_mobile3")[0].value;
		document.getElementsByName("del_email1")[0].value = document.getElementsByName("order_email1")[0].value;
		document.getElementsByName("del_email2")[0].value = document.getElementsByName("order_email1")[0].value;
	}
	else{
		document.getElementsByName("del_name")[0].value = "";
		document.getElementsByName("del_address1")[0].value = "";
		document.getElementsByName("del_address2")[0].value = "";
		document.getElementsByName("del_address3")[0].value = "";
		document.getElementsByName("del_address4")[0].value = "";
		document.getElementsByName("del_mobile1")[0].value = "";
		document.getElementsByName("del_mobile2")[0].value = "";
		document.getElementsByName("del_mobile3")[0].value = "";
		document.getElementsByName("del_email1")[0].value = "";
		document.getElementsByName("del_email2")[0].value = "";
	}
}

</script>
</html>
