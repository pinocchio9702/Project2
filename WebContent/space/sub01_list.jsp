<%@page import="model.Multi_boardDTO"%>
<%@page import="java.util.List"%>
<%@page import="util.PagingUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.Multi_boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
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
int totalRecordCount = dao.getTotalRecordCountNotice(param);
//전체 레코드 수를 Map에 저장한다. 차후 View로 전달한다.
param.put("totalCount", totalRecordCount);

int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

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

String pagingImg = PagingUtil.paginBS4(totalRecordCount, pageSize, blockPage, nowPage, "sub01_list.jsp?" + addQueryString);
param.put("pagingImg", pagingImg);

List<Multi_boardDTO> listsNotice = dao.selectListPageNotice(param); //페이지 처리 o

//DB연결을 헤제하는 것이 아니라 커넥션풀에 개체를 반납한다.
dao.close();

//데이터를 request영역에 저장한다.
request.setAttribute("listsNotice", listsNotice);
request.setAttribute("map", param);

%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

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
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
				</div>
				<div>

<div class="row text-right" style="margin-bottom:20px;
		padding-right:50px;">
<!-- 검색부분 -->
<form class="form-inline">	
	<div class="form-group">
		<select name="keyField" class="form-control">
			<option value="">제목</option>
			<option value="">작성자</option>
			<option value="">내용</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="keyString"  class="form-control"/>
		<div class="input-group-btn">
			<button type="submit" class="btn btn-default">
				<i class="glyphicon glyphicon-search"></i>
			</button>
		</div>
	</div>
</form>	
<!-- 검색부분 end -->
</div>
<div class="row">
	<!-- 게시판리스트부분 -->
	<table class="table table-bordered table-hover">
	<colgroup>
		<col width="80px"/>
		<col width="*"/>
		<col width="120px"/>
		<col width="120px"/>
		<col width="80px"/>
		<col width="50px"/>
	</colgroup>
	
	<thead>
	<tr class="success">
		<th class="text-center">번호</th>
		<th class="text-left">제목</th>
		<th class="text-center">작성자</th>
		<th class="text-center">작성일</th>
		<th class="text-center">조회수</th>
		<th class="text-center">첨부</th>
	</tr>
	</thead>
	
	<tbody>
	<c:choose>
		<c:when test="${empty listsNotice }">
			<tr>
				<td colspan="6" align="center" height="100">등록된 게시물이
					없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${listsNotice }" var="row" varStatus="loop">
	<!-- 리스트반복 -->
	
	<tr>
		<td class="text-center">${map.totalCount - (((map.nowPage-1) * map.pageSize) + loop.index) }</td>
		<td class="text-left"><a href="sub01_view.jsp?num=${row.num }&nowPage=${map.nowPage}&Field=${map.Field}&keyString=${map.keyString}">${row.title }</a></td>
		<td class="text-center">${row.id }</td>
		<td class="text-center">${row.postdate }</td>
		<td class="text-center">${row.visitcount }</td>
		<td class="text-center"><c:if test="${not empty row.file }">
			<a
				href="../Download?filename=${row.file }&idx=${row.num}">
				<img src="../images/disk.png" width="20">
			</a>
		</c:if></td>
	</tr>
	</tbody>
	</c:forEach>
	</c:otherwise>
	</c:choose>
	</table>
</div>
<div class="row text-right" style="padding-right:50px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
				
	<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
</div>
<div class="row text-center">
	<!-- 페이지번호 부분 -->
	<ul class="pagination">
	
	${map.pagingImg }
	
		<!-- <li><span class="glyphicon glyphicon-fast-backward"></span></li>
		<li><a href="#">1</a></li>		
		<li class="active"><a href="#">2</a></li>
		<li><a href="#">3</a></li>
		<li><a href="#">4</a></li>		
		<li><a href="#">5</a></li>
		<li><span class="glyphicon glyphicon-fast-forward"></span></li> -->
	</ul>	
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