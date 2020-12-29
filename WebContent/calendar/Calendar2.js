
var nowDate = new Date();
function calendarMaker(target, date){
	
	if (date == null || date == undefined) {
        date = new Date();
    }
	nowDate = date;
	 if ($(target).length > 0) {
        var year = nowDate.getFullYear();
        var month = nowDate.getMonth() + 1;
		//이게 문제가 아니었을까?	
		//var month = nowDate.getMonth();
        //$(target).empty().append(assembly(year, month));
		
		
		
    } else {
        console.error("custom_calendar Target is empty!!!");
        return;
    }

	var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
    var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, 0);

	
	

	 var tag = assembly(year, month);
	 tag += '<tr>';
	 var cnt = 0;
    //빈 공백 만들어주기
    for (i = 0; i < thisMonth.getDay(); i++) {
        tag += "<td></td>";
        cnt++;
    }
	
 	//날짜 채우기
    for (i = 1; i <= thisLastDay.getDate(); i++) {
        if (cnt % 7 == 0) { tag += "<tr>"; }

        tag += "<td>" + i + "</td>";
        cnt++;
        if (cnt % 7 == 0) {
            tag += "</tr>";
        }
		
    }
	tag +="</table>"
	$("#calendar").html(tag);
}

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
		    			'</tr>';
        return calendar_html_code;
    }

	
	
	function calMoveEvtFn(){
		console.log("하하");
        //전달 클릭
        $("#calendar").on("click", "#prebtn", function () {
            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
            calendarMaker($('#calendar'), nowDate);
        });
        //다음날 클릭
       $("#calendar").on("click", "#nextbtn", function () {
            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
            calendarMaker($('#calendar'), nowDate);
        });
    }
	
	
	
	
	

	
	
	
	
	
	
	
