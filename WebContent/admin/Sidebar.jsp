<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<!-- Sidebar -->
<ul class="sidebar navbar-nav">
  <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      <i class="fas fa-fw fa-folder"></i>
      <span>관리자 모드</span>
    </a>
    <div class="dropdown-menu" aria-labelledby="pagesDropdown">
      <h6 class="dropdown-header">관리자</h6>
      <a class="dropdown-item" href="login.jsp">로그인</a>
      <a class="dropdown-item" href="register.jsp">관리자 등록</a>
      <a class="dropdown-item" href="forgot-password.jsp">비밀번호 찾기</a>
    </div>
  </li>
  <li class="nav-item dropdown" >
    <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      <i class="fas fa-fw fa-table"></i>
      <span>Tables</span></a>
       <div class="dropdown-menu" aria-labelledby="pagesDropdown">
      <h6 class="dropdown-header">게시물 관리</h6>
      <a class="dropdown-item" href="../admin/memberList">회원관리</a>
      <a class="dropdown-item" href="../admin/noticeList">공지사항</a>
      <a class="dropdown-item" href="../admin/calendarList.jsp">일정관리</a>
      <a class="dropdown-item" href="../admin/cleaningList">블루크리닝</a>
      <a class="dropdown-item" href="../admin/experienceList">체험학습신청 관리</a>
      <a class="dropdown-item" href="../admin/purchaseList">구매서</a>
      <div class="dropdown-divider"></div>

    </div>
  </li>
</ul>