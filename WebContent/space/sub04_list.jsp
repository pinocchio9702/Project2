<%@page import="model.Multi_boardDTO"%>
<%@page import="java.util.List"%>
<%@page import="util.PagingUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.Multi_boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<%
//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");

//DAO객체 생성 및 커넥션풀을 통한 DB연결
Multi_boardDAO dao = new Multi_boardDAO(drv, url, mid, mpw);
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
//테이블의 전체 레코드 수를 카운트
int totalRecordCount = dao.getTotalRecordCountPhoto(param);
//전체 레코드 수를 Map에 저장한다. 차후 View로 전달한다.
param.put("totalCount", totalRecordCount);

int pageSize = 8;
int blockPage = 3;

//전체 페이수를 계산한다.
int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

System.out.println("전체레코드수 : " + totalRecordCount);
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
param.put("totalCount", totalRecordCount);
param.put("pageSize", pageSize);

String pagingImg = PagingUtil.paginBS4(totalRecordCount, pageSize, blockPage, nowPage, "../space/sub04_list.jsp?" + addQueryString);
param.put("pagingImg", pagingImg);

List<Multi_boardDTO> photoBoard = dao.selectListPagePhoto(param); //페이지 처리 o

//DB연결을 헤제하는 것이 아니라 커넥션풀에 개체를 반납한다.
dao.close();

//데이터를 request영역에 저장한다.
request.setAttribute("photoBoard", photoBoard);
request.setAttribute("map", param);
System.out.println(session.getAttribute("USER_ID"));
%>

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
				<c:choose>
					<c:when test="${empty photoBoard }">
						게시물이 없습니다.
					</c:when>
					<c:otherwise>
					<c:forEach items="${photoBoard }" var="row" varStatus="loop">
			  			<span style="margin: 10px">
			  			<div class="card" style="width:170px">
			    			<a href="../space/sub04_view.jsp?num=${row.num }"><img class="card-img-top" src="${row.file_path }" alt="Card image" style="height:200px; width:100%"></a>
			    			<div class="card-body">
			      				<h4 class="card-title">${row.title }</h4>
			      				<p class="card-text">${fn:substring(row.content,0,10) }</p>
			      				<div>
			      				<sapn>${row.name }  </sapn><span>${row.postdate }  </span>
			      				</div>
			      				<span>방문자 : ${row.visitcount }  </span>
			    			</div>
			  			</div>
			  			</span>
					</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<c:if test="${not empty sessionScope.USER_ID }">
			<button  style="font-size: 20px; float: right;" type="button" class="btn btn-info" 
				onclick="location.href='../space/sub04_write.jsp'">글쓰기</button>
			</c:if>
			
			<div class="row text-center">
				<!-- 페이지번호 부분 -->
				<ul class="pagination">
					${map.pagingImg }
				</ul>	
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
