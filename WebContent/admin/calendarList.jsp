<%@page import="model.CalendarDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.CalendarDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<%
	Calendar cr = Calendar.getInstance();

String year = request.getParameter("year");
String month = request.getParameter("month");
String next = request.getParameter("next");
String yearNext = request.getParameter("yearnext");

System.out.println("파라미터로 받은 년도 : " + year);
System.out.println("파라미터로 받은 달 : " + month);
System.out.println("파라미터로 받은 일 : " + year);

if (year == null || month == null) {
	year = Integer.toString(cr.get(Calendar.YEAR));
	month = Integer.toString(cr.get(Calendar.MONTH));
	int date = cr.get(Calendar.DATE);
}

if (next == null) {

} else if (next.equals("0")) {
	if (Integer.parseInt(month) > 0) {
		month = Integer.toString(Integer.parseInt(month) - 1);
	} else {
		year = Integer.toString(Integer.parseInt(year) - 1);
		month = "11";
	}
} else if (next.equals("1")) {
	if (Integer.parseInt(month) < 11) {
		month = Integer.toString(Integer.parseInt(month) + 1);
	} else {
		year = Integer.toString(Integer.parseInt(year) + 1);
		month = "0";
	}
}

if (yearNext == null) {

} else if (yearNext.equals("0")) {
	year = Integer.toString(Integer.parseInt(year) - 1);
} else if (yearNext.equals("1")) {
	year = Integer.toString(Integer.parseInt(year) + 1);
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
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin - Tables</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
		<a class="navbar-brand mr-1" href="../admin/memberList">Start
			Bootstrap</a>
		<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
			id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>
	</nav>

	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="Sidebar.jsp"%>

		<div id="content-wrapper">

			<div class="container-fluid">

				<!-- Breadcrumbs-->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">Dashboard</a></li>
					<li class="breadcrumb-item active">Tables</li>
				</ol>

				<!-- DataTables Example -->
				<div class="card mb-3">
					<div class="card-header">
						<i class="fas fa-table"></i> 일정관리
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table style="margin-top: 50px" width=400px border='0'
								celpadding='0' cellspacing='0'>
								<tr>
									<td><font size="2"><a
											href="calendarList.jsp?yearnext=0&year=<%=year%>&month=<%=month%>"><i
												class='fas fa-angle-double-left' style='font-size: 36px'></i></a></font>
									</td>
									<td><font size="2"><a
											href="calendarList.jsp?next=0&year=<%=year%>&month=<%=month%>"><i
												class='fas fa-angle-left' style='font-size: 36px'></i></a></font></td>
									<td style="text-align: center"><b style="font-size: 40px"><%=year%>월
											<%=Integer.parseInt(month) + 1%>월</b></td>
									<td style="text-align: right"><font size="2"><a
											href="calendarList.jsp?next=1&year=<%=year%>&month=<%=month%>"><i
												class='fas fa-angle-right' style='font-size: 36px'></i></a></font></td>
									<td style="text-align: right"><font size="2"><a
											href="calendarList.jsp?yearnext=1&year=<%=year%>&month=<%=month%>"><i
												class='fas fa-angle-double-right' style='font-size: 36px'></i></a></font>
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
											for (int i = 1; i < startDay; i++) {
											count++;
										%>
										<td height="80px">&nbsp;</td>
										<%
											}
										%>
										<%
											for (int i = startDate; i <= endDate; i++) {
											count++;
										%>
										<td height="80px" style="font-size: 15px" align="left"><%=i%>
											<%
												for (CalendarDTO dto : calendar) {
												if (dto.getCal_date().equals(year + "-" + String.format("%02d", Integer.parseInt(month) + 1) + "-"
												+ String.format("%02d", i) + " 00:00:00.0")) {
											%> <a href="../admin/calendarView.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a></td>
										<%
											}
										}
										%>
										</td>
										<%
											if (count % 7 == 0 && i < endDate) {
										%>
									</tr>
									<tr>
										<%
											}
										}
										while (count % 7 != 0) {
										%>
										<td height="80px">&nbsp;</td>
										<%
											count++;
										}
										%>
									
								</tbody>
							</table>

							<button onclick="location.href='calendarWrite.jsp'"
								style="float: right;" type="button"
								class="btn btn-outline-secondary">일정 추가하기</button>
						</div>
					</div>
				</div>

				<p class="small text-center text-muted my-5">
					<em>More table examples coming soon...</em>
				</p>

			</div>
			<!-- /.container-fluid -->

			<!-- Sticky Footer -->
			<footer class="sticky-footer">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright © Your Website 2019</span>
					</div>
				</div>
			</footer>

		</div>
		<!-- /.content-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="login.html">Logout</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Page level plugin JavaScript-->
	<script src="vendor/datatables/jquery.dataTables.js"></script>
	<script src="vendor/datatables/dataTables.bootstrap4.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin.min.js"></script>

	<!-- Demo scripts for this page-->
	<script src="js/demo/datatables-demo.js"></script>

</body>

</html>
