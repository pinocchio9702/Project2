<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="stylesheet" href="../common/bootstrap3.5.1/css/bootstrap.css">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
		<script>
		$(function() {
			$("#datepicker").datepicker({
				"dateFormat" : "yy-mm-dd", //날짜형식
				"showAnim" : "slideDown"
			});
			
			var dateFormat = "mm/dd/yy", from = $("#date_from").datepicker({
				defaultDate : "+1w",
				changeMonth : true,
				numberOfMonths : 3
			}).on("change", function() {
				to.datepicker("option", "minDate", getDate(this));
			}), to = $("#date_to").datepicker({
				defaultDate : "+1w",
				changeMonth : true,
				numberOfMonths : 3
			}).on("change", function() {
				from.datepicker("option", "maxDate", getDate(this));
			});

			function getDate(element) {
				var date;
				try {
					date = $.datepicker.parseDate(dateFormat, element.value);
				} catch (error) {
					date = null;
				}

				return date;
			}
		});
			   function checkValidate(fm){
			      if(fm.name.value==""){
			         alert("작성자의 이름을 입력하세요."); 
			         fm.name.focus(); 
			         return false; 
			      }
			      if(fm.pass.value==""){
			         alert("비밀번호를 입력하세요."); 
			         fm.pass.focus(); 
			         return false; 
			      }
			      if(fm.title.value==""){
			         alert("제목을 입력하세요."); 
			         fm.title.focus(); 
			         return false; 
			      }
			      if(fm.content.value==""){
			         alert("내용을 입력하세요."); 
			         fm.content.focus(); 
			         return false;
			      }
			   }

		</script>
        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            	일정 추가하기</div>
          <div class="card-body">
            <div class="table-responsive">
            <div class="container">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <form name="writeFrm" method="post" action="../admin/calendarWrite.do"
					onsubmit="return checkValidate(this);">
                <tbody>
				<tr>
					<th class="text-center"
						style="vertical-align:middle;">제목</th>
					<td>
						<input type="text" class="form-control" 
							name="title" />
					</td>
				</tr>
				<tr>
					<th class="text-center"
						style="vertical-align:middle;">내용</th>
					<td>
						<textarea rows="10" 
							class="form-control" name="content"></textarea>
					</td>
				</tr>
				<tr>
					<th class="text-center"
						style="vertical-align:middle;">일정</th>
					<td>
						<input type="text" class="form-control" name="cal_date" id="datepicker"  />
					</td>
				</tr>
				
                </tbody>
              </table>
              </div>
            </div>
          </div>
        </div>
        <button type="submit" class="btn btn-danger">일정 등록하기</button>
        <button type="button" class="btn btn-warning" onclick="location.href='../admin/calendarList.jsp';">리스트보기</button>

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
