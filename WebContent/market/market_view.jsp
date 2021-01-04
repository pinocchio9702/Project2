<%@page import="model.GoodsDTO"%>
<%@page import="model.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");

String queryStr = "";

String nowPage = request.getParameter("nowPage");
queryStr += "&nowPage="+nowPage;

String num = request.getParameter("num");
GoodsDAO dao = new GoodsDAO(drv, url, mid, mpw);
System.out.println("파라미터로 넘어온 num : " + num);

GoodsDTO dto = dao.selectView(num);
System.out.println(dto.getNAME());
request.setAttribute("dto", dto);
dao.close();
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
				<div class="market_view_box">
					<div class="market_left">
						<img height="400px" width="400px" src="<%=dto.getImage_path() %>" />
						<p class="plus_btn"><a href=""><img src="../images/market/plus_btn.gif" /></a></p>
					</div>
					<div class="market_right">
						<p class="m_title"><%=dto.getNAME() %>
						<p>- <%=dto.getExplan() %></p>
						<ul class="m_list">
							<li>
								<dl>
									<dt>가격</dt>
									<dd class="p_style"><%=dto.getPrice() %></dd>
								</dl>
								<dl>
									<dt>적립금</dt>
									<dd><%=dto.getSaved() %></dd>
								</dl>
								<dl>
									<dt>수량</dt>
									<dd><input type="text" name="" value="1" class="n_box" /></dd>
								</dl>
								<dl style="border-bottom:0px;">
									<dt>주문정보</dt>
									<dd><input type="text" name="" class="n_box" style="width:200px;" /></dd>
								</dl>
								<div style="clear:both;"></div>
							</li>
						</ul>
						<p class="btn_box"><a href=""><img src="../images/market/m_btn01.gif" alt="바로구매" /></a>&nbsp;&nbsp;<a href="basket.jsp"><img src="../images/market/m_btn02.gif" alt="장바구니" /></a></p>
					</div>
				</div>
				<img src="<%=dto.getImage_path() %>" />

			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
