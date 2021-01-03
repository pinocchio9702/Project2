<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<%
Calendar cr = Calendar.getInstance();

int year = Integer.parseInt(request.getParameter("year"));
int month = cr.get(Calendar.MONTH);
int date = cr.get(Calendar.DATE);

//if(year == null && month == null && date == null){
//	year = cr.get(Calendar.YEAR);
//	month = cr.get(Calendar.MONTH);
//	date = cr.get(Calendar.DATE);
//}

String next = request.getParameter("next");

System.out.println("파라미터 next 값 : " + next);
if(next == null){
	
}
else if(next.equals("1")){
	if(month < 12){
		month ++;
	}else{
		month = 0;
		year ++;
	}
}else if(next.equals("0")){
	if(month > 1){
		month --;
	}
	else{
		month = 11;
		year --;
	}
}

System.out.println("현재 년도 : " + year);
System.out.println("현재 월 : " +month);
System.out.println("현재 일 : " + date);

%>

<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<img src="../images/space/sub_image.jpg" id="main_visual" />

			<div class="contents_box">
				<div class="left_contents">

					<%@ include file="../include/space_leftmenu.jsp"%>
				</div>

				<div class="row">
					<div class="right_contents">
						
							<img src="../images/space/sub02_title.gif" alt="프로그램일정"
								class="con_title" />
							<p class="location">
								<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정
							
							<p>
							<div>
								<center>
									<table style="margin-top: 50px" width=400px border='0'
										celpadding='0' cellspacing='0'>
										<tr>
											<td>
													<font size="2"><a href ="sub02.jsp?next=0&year=<%=year%>&month=<%=month%>"><i class='fas fa-angle-left'
														style='font-size: 24px'></i></a></font>
											</td>
											<td style="text-align: center"><b
												style="font-size: 40px"><%=year %>월 <%=month+1 %>월</b></td>
											<td style="text-align: right">
													<font size="2"><a href ="sub02.jsp?next=0&year=<%=year%>&month=<%=month%>"><i class='fas fa-angle-right'
														style='font-size: 36px'></i></a></font>
											</td>
										</tr>
									</table>
								</center>



								<table style="margin-top: 20px" class="table table-bordered">
									<colgroup>
										<col width="120px" />
										<col width="120px" />
										<col width="120px" />
										<col width="120px" />
										<col width="120px" />
										<col width="120px" />
										<col width="120px" />
									</colgroup>
									<thead>
										<tr class="table-warning">
											<th class="text-center" style="text-color: red;">SUN</th>
											<th class="text-center">MON</th>
											<th class="text-center">TUE</th>
											<th class="text-center">WED</th>
											<th class="text-center">THU</th>
											<th class="text-center">FRI</th>
											<th class="text-center">SAT</th>
										</tr>
									</thead>
									<tbody>
										
										
									</tbody>
								</table>




							</div>
						
					</div>
				</div>

			</div>
			<%@ include file="../include/quick.jsp"%>


			<%@ include file="../include/footer.jsp"%>


		</div>
	</center>
</body>
</html>
