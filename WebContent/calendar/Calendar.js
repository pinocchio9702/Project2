   var nowDate = new Date();
   function calendarMaker(target, date) {
      if (date == null || date == undefined) {
           date = new Date();
       }
      nowDate = date;
      var year = nowDate.getFullYear();
      console.log(year);
        var month = nowDate.getMonth() + 1;
        var html = assembly(year, month);
        
        var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
        var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, 0);
        
        html += "<tr>";
        var cnt = 0;
        //빈 공백 만들어주기
        for (i = 0; i < thisMonth.getDay(); i++) {
           html += "<td></td>";
            cnt++;
        }

        //날짜 채우기
        for (i = 1; i <= thisLastDay.getDate(); i++) {
            if (cnt % 7 == 0) { html += "<tr>"; }

         if( cnt % 7 == 0) { html += "<td style='color: red;'>" + i + "</td>";}
         else if(cnt % 7 == 6) { html+= "<td style='color: blue;'>" + i + "</td>";}
         else{ html += "<td>" + i + "</td>";}
            cnt++;
            if (cnt % 7 == 0) {
               html += "</tr>";
            }
        }
        html+= "</table>";
        $("#calendar").html(html);
   }
    
   
   function assembly(year, month) {
        var calendar_html_code =
           "<p class='main_title' style='border: 0px; margin-bottom: 0px;> "+
         "<img src='../images/main_title05.gif' alt='월간일정 CALENDAR' /></p>"+
           "<div class='cal_top'><table cellpadding='0' cellspacing='0' border='0'>"+
         "<colgroup>"+
         "   <col width='13px;' />"+
         "   <col width='*' />"+
            "<col width='13px;' />"+
         "</colgroup>"+
         "<tr><td><button id='prev' style='border: 0;'><img src='../images/cal_a01.gif'"+
            "      style='margin-top: 3px;' /></button></td>"+
            "<td color='#868686'><strong>"+year+"년&nbsp;&nbsp;</strong><img"+
            "   src='../images/calender_m"+month+".gif' /></td>"+
            "<td><button id='next' style='border: 0;'><img src='../images/cal_a02.gif'"+
                  "style='margin-top: 3px;' /></button></td>"+
         "</tr>"+
         "</table>"+
         "</div>"+
         '<div class="cal_bottom">'+
         '<table cellpadding="0" cellspacing="0" border="0" class="calendar">'+
            "<colgroup>" +
            "<col width='14%' />" +
            "<col width='14%' />" +
            "<col width='14%' />" +
            "<col width='14%' />" +
            "<col width='14%' />" +
            "<col width='14%' />" +
            "<col width='14%' />" +
            "</colgroup>" +
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
   function calMoveEvtFn() {
        //전달 클릭
        $("#calendar").on("click", "#prev", function () {
            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
            calendarMaker("#calendar", nowDate);
        });
        //다음날 클릭
        $("#calendar").on("click", "#next", function () {
           nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
            calendarMaker("#calendar", nowDate);
        });
    }