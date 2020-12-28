<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="util.CookieUtil"%>
<%
	session.removeAttribute("USER_ID");
	session.removeAttribute("USER_PW");
	CookieUtil.makeCookie(request, response, "LoginId", "", 0);

%>
<script>
	alert("로그아웃 되었습니다.");
	location.href="../main/main.do";
</script>