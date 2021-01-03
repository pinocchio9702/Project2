<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<img src="../images/community/sub_image.jpg" id="main_visual" />

			<div class="contents_box">
				<div class="left_contents">

					<%@ include file="../include/community_leftmenu.jsp"%>
				</div>
				<div class="right_contents">
					<div class="top_title">
						<img src="../images/community/sub01_title.gif" alt="보호자 게시판"
							class="con_title" />
						<p class="location">
							<img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실
						<p>
					</div>
					<div>

						<div class="row text-right"
							style="margin-bottom: 20px; padding-right: 50px;">
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
									<input type="text" name="keyString" class="form-control" />
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
									<col width="80px" />
									<col width="*" />
									<col width="120px" />
									<col width="120px" />
									<col width="80px" />
									<col width="80px" />
								</colgroup>

								<thead>
									<tr class="success">
										<th class="text-center">번호</th>
										<th class="text-left">제목</th>
										<th class="text-center">작성자</th>
										<th class="text-center">작성일</th>
										<th class="text-center">조회수</th>
										<th class="text-center">첨부파일</th>
									</tr>
								</thead>

								<tbody>
									<c:choose>
										<c:when test="${empty listsEmplo }">
											<tr>
												<td colspan="6" align="center" height="100">등록된 게시물이
													없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${listsEmplo }" var="row" varStatus="loop">
												<!-- 리스트반복 -->

												<tr>
													<td class="text-center">${map.totalCount - (((map.nowPage-1) * map.pageSize) + loop.index) }</td>
													<td class="text-left"><a
														href="../controller/emplo_view.do?num=${row.num }">${row.title }</a></td>
													<td class="text-center">${row.name }</td>
													<td class="text-center">${row.postdate }</td>
													<td class="text-center">${row.visitcount }</td>
													<td class="text-center"><c:if
															test="${not empty row.file }">
															<a
																href="../controller/DataDownload?file=${row.file }&dx=${row.id}">
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
						<div class="row text-right" style="padding-right: 50px;">
							<!-- 각종 버튼 부분 -->
							<!-- <button type="reset" class="btn">Reset</button> -->
							<c:if test="${not empty sessionScope.USER_ID }">
							<button type="button" class="btn btn-default"
								onclick="location.href='../community/sub01_write.jsp';">글쓰기</button>
							</c:if>
							<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
						</div>
						<div class="row text-center">
							<!-- 페이지번호 부분 -->
							<ul class="pagination">${map.pagingImg }
							</ul>
						</div>

					</div>
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>


		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>
