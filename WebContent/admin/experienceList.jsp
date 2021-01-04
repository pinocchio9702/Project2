<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

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
            	공지사항</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>고객명/회사명</th>
                    <th>장애유무</th>
                    <th>주요 장애 유형</th>
                    <th>보장구 사용유무</th>
                    <th>보장구 명</th>
                    <th>연락처</th>
                    <th>담당자 휴대전화</th>
                    <th>이메일</th>
                    <th>케익체험</th>
                    <th>쿠키체험</th>
                    <th>체험희망 날짜</th>
                    <th>접송종류 구분</th>
                    <th>기타 특의 사항</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                   <th>고객명/회사명</th>
                    <th>장애유무</th>
                    <th>주요 장애 유형</th>
                    <th>보장구 사용유무</th>
                    <th>보장구 명</th>
                    <th>연락처</th>
                    <th>담당자 휴대전화</th>
                    <th>이메일</th>
                    <th>케익체험</th>
                    <th>쿠키체험</th>
                    <th>체험희망 날짜</th>
                    <th>접송종류 구분</th>
                    <th>기타 특의 사항</th>
                  </tr>
                </tfoot>
                <tbody>
				<c:choose>
					<c:when test="${empty requestScope.ExperienceList }">
						<tr>
							<td colspan="10" align="center" height="100">등록된 게시물이
								없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
					<c:forEach items="${requestScope.ExperienceList }" var="row" varStatus="loop">
	                  <tr>
	                    <td>${row.USER }</td>
	                    <td>${row.disability }</td>
	                    <td>${row.disability_type }</td>
	                    <td>${row.assisting }</td>
	                    <td>${row.assisting_name }</td>
	                    <td>${row.phone }</td>
	                    <td>${row.email }</td>
	                    <td>${row.mobile }</td>
	                    <td>${row.cake }</td>
	                    <td>${row.cookie }</td>
	                    <td>${row.experience_date }</td>
	                    <td>${row.ask }</td>
	                    <td>${row.matters }</td>
	                  </tr>
		            </c:forEach>
		            </c:otherwise>
				</c:choose>
                </tbody>

              </table>
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
