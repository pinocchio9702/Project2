<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../common/jquery/jquery-3.5.1.js"></script>
<script type="text/javascript">
var year = 2012
var Mon = 1;

$(function() {
	
	
	
	$("#nextbtn").click(function(){
		console.log(year);
		console.log(Mon);
		$.ajax({
			//요청할 서버의 경로 url
			url : "../calendar/Calendar.jsp",
			//콜백데이터 타입
			dataType : "html",
			//요청시 전송방식
			type : "get",
			//전송방식에 따른 컨텐츠 타입
			contentType : "text/html;charset:utf-8",
			
			data : {
				year : year,
				Mon : Mon+1
			},
				
			//파라미터. JSON형식
			//성공, 실패시 콜백메소드, sucFunc(매개변수)형태로 사용하지 않는다.
			success : sucFunc,
			error : errFunc
		});
	});		
	
})

function sucFunc(resData) {
	$("#calendar").html(resData);
}

/*
요청 성공시 호출할 콜백메소드로 jQuery외부에 정의되었다.
함수명만으로 지정하더라도 콜백데이터는 파라미터로 전달받을 수
있다. 
*/
function errFunc() {
alert("에러발생, 디버깅 하시세요")
}
</script>
</head>
<body>
<div id="calendar">
	<div class="cal_top">
		<table cellpadding="0" cellspacing="0" border="0">
			<colgroup>
				<col width="13px;" />
				<col width="*" />
				<col width="13px;" />
			</colgroup>
			<tr>
				<td><a href=""><img src="../images/cal_a01.gif" style="margin-top: 3px;" /></a></td>
				<td><img src="../images/calender_2019.gif" />&nbsp;&nbsp;<img src="../images/calender_m<%=request.getParameter("Mon") %>.gif" /></td>
				<td><img id="nextbtn" src="../images/cal_a02.gif" style="margin-top: 3px;" /></td>
			</tr>
		</table>
	</div>
	<div class="cal_bottom">
		<table cellpadding="0" cellspacing="0" border="0" class="calendar">
			<colgroup>
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="*" />
			</colgroup>
			<tr>
				<th><img src="../images/day01.gif" alt="S" /></th>
				<th><img src="../images/day02.gif" alt="M" /></th>
				<th><img src="../images/day03.gif" alt="T" /></th>
				<th><img src="../images/day04.gif" alt="W" /></th>
				<th><img src="../images/day05.gif" alt="T" /></th>
				<th><img src="../images/day06.gif" alt="F" /></th>
				<th><img src="../images/day07.gif" alt="S" /></th>
			</tr>
			<tr>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">1</a></td>
				<td><a href="">2</a></td>
				<td><a href="">3</a></td>
			</tr>
			<tr>
				<td><a href="">4</a></td>
				<td><a href="">5</a></td>
				<td><a href="">6</a></td>
				<td><a href="">7</a></td>
				<td><a href="">8</a></td>
				<td><a href="">9</a></td>
				<td><a href="">10</a></td>
			</tr>
			<tr>
				<td><a href="">11</a></td>
				<td><a href="">12</a></td>
				<td><a href="">13</a></td>
				<td><a href="">14</a></td>
				<td><a href="">15</a></td>
				<td><a href="">16</a></td>
				<td><a href="">17</a></td>
			</tr>
			<tr>
				<td><a href="">18</a></td>
				<td><a href="">19</a></td>
				<td><a href="">20</a></td>
				<td><a href="">21</a></td>
				<td><a href="">22</a></td>
				<td><a href="">23</a></td>
				<td><a href="">24</a></td>
			</tr>
			<tr>
				<td><a href="">25</a></td>
				<td><a href="">26</a></td>
				<td><a href="">27</a></td>
				<td><a href="">28</a></td>
				<td><a href="">29</a></td>
				<td><a href="">30</a></td>
				<td><a href="">31</a></td>
			</tr>
			<tr>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
				<td><a href="">&nbsp;</a></td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>