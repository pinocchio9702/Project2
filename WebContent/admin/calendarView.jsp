<%@page import="model.CalendarDTO"%>
<%@page import="model.CalendarDAO"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<%

String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");
//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");
CalendarDAO dao = new CalendarDAO(drv, url, mid, mpw);
//일련번에 해당하는 게시물을 DTO객체로 반환함.
CalendarDTO dto = dao.selectView(num);

System.out.println("dto 아이디 : " + dto.getId());
System.out.println("dto 제목"+dto.getTitle());
System.out.println("dto 내용 " + dto.getContent());
System.out.println("dto 날자" + dto.getCal_date());
System.out.println("dto 일련번호 : " + dto.getNum());

dao.close();
%>
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin - Tables</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">
    <a class="navbar-brand mr-1" href="../admin/memberList">Start Bootstrap</a>
    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>
  </nav>

  <div id="wrapper">

    <!-- Sidebar -->
    <%@ include file="Sidebar.jsp" %>

    <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Tables</li>
        </ol>

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            	일정 상세보기</div>
          <div class="card-body">
            <div class="table-responsive">
            
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <tbody>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">작성자</th>
						<td colspan="3">
							<%=dto.getId() %>
						</td>
					</tr>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">제목</th>
						<td colspan="3">
							<%=dto.getTitle() %>
						</td>
					</tr>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">내용</th>
						<td colspan="3">
							<%=dto.getContent().replace("\r\n", "<br/>") %>
						</td>
					</tr>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">일정</th>
						<td colspan="3">
							<%=dto.getCal_date() %>
						</td>
					</tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
		<button type="button" class="btn btn-secondary" onclick="location.href='../admin/calendarEdit.do?num=<%=dto.getNum()%>';">수정하기</button>
		<button type="button" class="btn btn-success" onclick="location.href='../admin/calendarDelete.do?num=<%=dto.getNum()%>';">삭제하기</button>
		<button type="button" class="btn btn-warning"
							onclick="location.href='../admin/calendarList.jsp';">리스트보기</button>			
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
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
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
