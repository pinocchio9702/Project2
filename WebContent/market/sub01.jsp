<%@page import="model.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@page import="util.PagingUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");

GoodsDAO dao = new GoodsDAO(drv, url, mid, mpw);

Map param = new HashMap();
String addQueryString = ""; 

//검색어 관련 파라미터 처리
String keyField = request.getParameter("keyField");
String keyString = request.getParameter("keyString");
if(!(keyField == null || keyString.equals(""))) {
	
	//검색어가 있는 경우 파라미터를 Map에 저장하고, 쿼리스트링을 만들어준다.
	//쿼리스트링은 상세보기나 글쓰기 후에 검색이 풀리는 것을 방지하는 코드를 작성하기 위해 만든다.
	addQueryString =
			String.format("keyField=%s&keyString=%s", keyField, keyString);
	param.put("Column", keyField);
	param.put("Word", keyString);
}

int totalGoodsCount = dao.getTotalRecordCountBoard(param);

//전체 레코드 수를 Map에 저장한다. 차후 View로 전달한다.
param.put("totalCount", totalGoodsCount);

int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

//전체 페이수를 계산한다.
int totalPage = (int)Math.ceil((double)totalGoodsCount/pageSize);

System.out.println("전체레코드수 : " + totalGoodsCount);
System.out.println("전체페이지수 : " + totalPage);

//현재 페이지번호를 설정한다. 최초진입시에는 무조건 1로 설정한다.
int nowPage = (request.getParameter("nowPage") ==null || request.getParameter("nowPage").equals(""))
		? 1 : Integer.parseInt(request.getParameter("nowPage"));

int start = (nowPage-1) * pageSize;
int end = pageSize;

//Map 컬렉션 테이터 저장
param.put("start", start);
param.put("end", end);
param.put("totalPage", totalPage);
param.put("nowPage", nowPage);
param.put("totalCount", totalGoodsCount);
param.put("pageSize", pageSize);

String pagingImg = PagingUtil.paginBS4(totalGoodsCount, pageSize, blockPage, nowPage, "sub01.jsp?" + addQueryString);
param.put("pagingImg", pagingImg);


List<GoodsDTO> goodsList = dao.selectListPageGoods(param); //페이지 처리 o

dao.close();

request.setAttribute("goodsList", goodsList);
request.setAttribute("map", param);

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
				<table cellpadding="0" cellspacing="0" border="0" class="market_board01">
					<colgroup>
						<col width="5%" />
						<col width="20%" />
						<col width="*" />
						<col width="10%" />
						<col width="10%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th>선택</th>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>구매</th>
					</tr>
					<c:choose>
						<c:when test="${empty goodsList }">
							<tr>
								<td colspan="6" align="center" height="100">등록된 게시물이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${goodsList }" var="row" varStatus="loop">
								<tr>
									<td><input type="checkbox" name="" value="" /></td>
									<td><a href="market_view.jsp?num=${row.num }&nowPage=${map.nowPage}"><img width="100px" height="100px" src="${row.image_path }" /></a></td>
									<td class="t_left" style="font-size: 30px"><a href="market_view.jsp?num=${row.num }&nowPage=${map.nowPage}">${row.NAME }</a></td>
									<td class="p_style" style="">${row.price }</td>
									<td><input type="text" name="" value="1" class="n_box" /></td>
									<td><a href=""><img src="../images/market/btn01.gif" style="margin-bottom:5px;" /></a><br /><a href="basket.jsp"><img src="../images/market/btn02.gif" /></a></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			<div class="row text-center">
				<!-- 페이지번호 부분 -->
				<ul class="pagination">
					${map.pagingImg }
				</ul>	
			</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
