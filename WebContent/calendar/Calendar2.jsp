<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../common/jquery/jquery-3.5.1.js"></script>
<title>Calendar2.jsp</title>
<script>
(function () {
    calendarMaker($("#calendar"), new Date());
})();

var nowDate = new Date();
function calendarMaker(target, date){
	
	if (date == null || date == undefined) {
        date = new Date();
    }
	nowDate = date;
	 if ($(target).length > 0) {
        var year = nowDate.getFullYear();
        //var month = nowDate.getMonth() + 1;
		//이게 문제가 아니었을까?	
		var month = nowDate.getMonth();
        $(target).empty().append(assembly(year, month));
    } else {
        console.error("custom_calendar Target is empty!!!");
        return;
    }

	var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
    var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, 0);

	
	calendarMaker($("#calendar"), new Date());
	calMoveEvtFn();
	
	var tag =
    	'<table cellpadding="0" cellspacing="0" border="0" class="calendar">'+
		'<colgroup>'+
			'<col width="14%" />'+
			'<col width="14%" />'+
			'<col width="14%" />'+
			'<col width="14%" />'+
			'<col width="14%" />'+
			'<col width="14%" />'+
			'<col width="*" />'+
			'<tr>'+
			'<th><img src="../images/day01.gif" alt="S" /></th>'+
			'<th><img src="../images/day02.gif" alt="M" /></th>'+
			'<th><img src="../images/day03.gif" alt="T" /></th>'+
			'<th><img src="../images/day04.gif" alt="W" /></th>'+
			'<th><img src="../images/day05.gif" alt="T" /></th>'+
			'<th><img src="../images/day06.gif" alt="F" /></th>'+
			'<th><img src="../images/day07.gif" alt="S" /></th>'+
		'</tr>'+
		'</colgroup>'+
    	"<tr>";
	 var cnt = 0;
    //빈 공백 만들어주기
    for (i = 0; i < thisMonth.getDay(); i++) {
        tag += "<td style='border-bottom:1px solid #e7e7e7; border-right:1px solid #e7e7e7; font-size:11px;'></td>";
        cnt++;
    }

 	//날짜 채우기
    for (i = 1; i <= thisLastDay.getDate(); i++) {
        if (cnt % 7 == 0) { tag += "<tr>"; }

        tag += "<td style='border-bottom:1px solid #e7e7e7; border-right:1px solid #e7e7e7; font-size:11px;'>" + i + "</td>";
        cnt++;
        if (cnt % 7 == 0) {
            tag += "</tr>";
        }
    }
    $(target).find("#body").html(tag);

	function assembly(year, month) {
        var calendar_html_code =
        	'<div id="calendar">'+
		    	'<div class="cal_top">'+
		    		'<table cellpadding="0" cellspacing="0" border="0">'+
		    			'<colgroup>'+
		    				'<col width="13px;" />'+
		    				'<col width="*" />'+
		    				'<col width="13px;" />'+
		    			'</colgroup>'+
		    			'<tr>'+
		    				'<td><img id="prebtn" src="../images/cal_a01.gif" style="margin-top: 3px;" /></a></td>'+
		    				'<td>' + year + '&nbsp;&nbsp;<img src="../images/calender_m'+ month +'.gif" /></td>'+
		    				'<td><img id="nextbtn" src="../images/cal_a02.gif" style="margin-top: 3px;" /></td>'+
		    			'</tr>'+
		    		'</table>'+
		    	'</div>'+
		    	'<div id="body" class="cal_bottom">'+
		    		'<table cellpadding="0" cellspacing="0" border="0" class="calendar">'+
		    			'<colgroup>'+
		    				'<col width="14%" />'+
		    				'<col width="14%" />'+
		    				'<col width="14%" />'+
		    				'<col width="14%" />'+
		    				'<col width="14%" />'+
		    				'<col width="14%" />'+
		    				'<col width="*" />'+
		    			'</colgroup>'+
		    			'<tr>'+
		    				'<th><img src="../images/day01.gif" alt="S" /></th>'+
		    				'<th><img src="../images/day02.gif" alt="M" /></th>'+
		    				'<th><img src="../images/day03.gif" alt="T" /></th>'+
		    				'<th><img src="../images/day04.gif" alt="W" /></th>'+
		    				'<th><img src="../images/day05.gif" alt="T" /></th>'+
		    				'<th><img src="../images/day06.gif" alt="F" /></th>'+
		    				'<th><img src="../images/day07.gif" alt="S" /></th>'+
		    			'</tr>'+
		    			'<tr>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">1</a></td>'+
		    				'<td><a href="">2</a></td>'+
		    				'<td><a href="">3</a></td>'+
		    			'</tr>'+
		    			'<tr>'+
		    				'<td><a href="">4</a></td>'+
		    				'<td><a href="">5</a></td>'+
		    				'<td><a href="">6</a></td>'+
		    				'<td><a href="">7</a></td>'+
		    				'<td><a href="">8</a></td>'+
		    				'<td><a href="">9</a></td>'+
		    				'<td><a href="">10</a></td>'+
		    			'</tr>'+
		    			'<tr>'+
		    				'<td><a href="">11</a></td>'+
		    				'<td><a href="">12</a></td>'+
		    				'<td><a href="">13</a></td>'+
		    				'<td><a href="">14</a></td>'+
		    				'<td><a href="">15</a></td>'+
		    				'<td><a href="">16</a></td>'+
		    				'<td><a href="">17</a></td>'+
		    			'</tr>'+
		    			'<tr>'+
		    				'<td><a href="">18</a></td>'+
		    				'<td><a href="">19</a></td>'+
		    				'<td><a href="">20</a></td>'+
		    				'<td><a href="">21</a></td>'+
		    				'<td><a href="">22</a></td>'+
		    				'<td><a href="">23</a></td>'+
		    				'<td><a href="">24</a></td>'+
		    			'</tr>'+
		    			'<tr>'+
		    				'<td><a href="">25</a></td>'+
		    				'<td><a href="">26</a></td>'+
		    				'<td><a href="">27</a></td>'+
		    				'<td><a href="">28</a></td>'+
		    				'<td><a href="">29</a></td>'+
		    				'<td><a href="">30</a></td>'+
		    				'<td><a href="">31</a></td>'+
		    			'</tr>'+
		    			'<tr>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    				'<td><a href="">&nbsp;</a></td>'+
		    			'</tr>'+
		    		'</table>'+
		    	'</div>'+
		    '</div>';
        return calendar_html_code;
    }

	
	
	function calMoveEvtFn(){
		console.log("하하");
        //전달 클릭
        $("#calendar").on("click", "#prebtn", function () {
            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
            calendarMaker($(target), nowDate);
        });
        //다음날 클릭
       $("#calendar").on("click", "#nextbtn", function () {
            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
            calendarMaker($(target), nowDate);
        });
    }
}

</script>
</head>
<body>
<div id="calendar">
</div>
			
</body>
</html>