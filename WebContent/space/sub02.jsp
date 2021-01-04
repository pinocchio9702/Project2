<%@page import="model.CalendarDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.CalendarDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

String year = request.getParameter("year");
String month = request.getParameter("month");
String next = request.getParameter("next");
String yearNext = request.getParameter("yearnext");

System.out.println("파라미터로 받은 년도 : " + year);
System.out.println("파라미터로 받은 달 : " + month);
System.out.println("파라미터로 받은 일 : " + year);

if(year == null || month == null){
	year = Integer.toString(cr.get(Calendar.YEAR));
	month = Integer.toString(cr.get(Calendar.MONTH));
	int date = cr.get(Calendar.DATE);
}

if(next == null){
	
}
else if(next.equals("0")){
	if(Integer.parseInt(month) > 0){
		month =  Integer.toString(Integer.parseInt(month)- 1);
	}
	else{
		year = Integer.toString(Integer.parseInt(year)- 1);
		month = "11";
	}
}
else if(next.equals("1")){
	if(Integer.parseInt(month) < 11){
		month =  Integer.toString(Integer.parseInt(month)+ 1);
	}
	else{
		year = Integer.toString(Integer.parseInt(year)+ 1);
		month = "0";
	}
}

if(yearNext == null){
	
}else if(yearNext.equals("0")){
	year = Integer.toString(Integer.parseInt(year)- 1);
}else if(yearNext.equals("1")){
	year = Integer.toString(Integer.parseInt(year)+ 1);
}

cr.set(Integer.parseInt(year), Integer.parseInt(month), 1);

//해당 월의 첫날을 구함
int startDate = cr.getMinimum(Calendar.DATE);
//해당 월의 마지막 날을 구함
int endDate = cr.getActualMaximum(Calendar.DATE);
//1일의 요일을 구함
int startDay = cr.get(Calendar.DAY_OF_WEEK);

int count = 0;

System.out.println("해당 월의 첫날 : " + startDate);
System.out.println("해당 월의 마지막날 : " + endDate);
System.out.println("1일의 요일 : " + startDay);
%>

<%
//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");

CalendarDAO dao = new CalendarDAO(drv, url, mid, mpw);

List<CalendarDTO> calendar = dao.selectCalendar();

dao.close();

request.setAttribute("calendar", calendar);
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
													<font size="2"><a href ="sub02.jsp?yearnext=0&year=<%=year%>&month=<%=month%>"><i class='fas fa-angle-double-left' style='font-size:36px'></i></a></font>
											</td>
											<td>
													<font size="2"><a href ="sub02.jsp?next=0&year=<%=year%>&month=<%=month%>"><i class='fas fa-angle-left'
														style='font-size: 36px'></i></a></font>
											</td>
											<td style="text-align: center"><b
												style="font-size: 40px"><%=year %>월 <%=Integer.parseInt(month)+1 %>월</b></td>
											<td style="text-align: right">
													<font size="2"><a href ="sub02.jsp?next=1&year=<%=year%>&month=<%=month%>"><i class='fas fa-angle-right'
														style='font-size: 36px'></i></a></font>
											</td>
											<td style="text-align: right">
													<font size="2"><a href ="sub02.jsp?yearnext=1&year=<%=year%>&month=<%=month%>"><i class='fas fa-angle-double-right' style='font-size:36px'></i></a></font>
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
									<tr>
									<%
									for(int i=1; i<startDay; i++){
										count++;
									%>
										<td height="80px">&nbsp;</td>
									<%
									}
									%>
									<%
									for(int i=startDate; i<=endDate; i++){
										count++;
									%>
										<td height="80px" style="font-size: 15px" align="left"><%=i %>
									<%
										for(CalendarDTO dto : calendar){
											if(dto.getCal_date().equals(year+"-"+String.format("%02d", Integer.parseInt(month)+1)+"-"+String.format("%02d", i)+" 00:00:00.0")){
									%>
											<a href="../space/sub02_view.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle() %></a></td>
									<%
											}
										}
									%>
									</td>
									<%
										if(count%7 ==0 && i< endDate){
									%>
									</tr>
									<tr>
									<%
										}
									}
									while(count%7 != 0){
									%>
										<td height="80px" >&nbsp;</td>
									<%
									count++;
									}
									%>
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
