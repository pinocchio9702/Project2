<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="assets/styles/index.css">
  <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
  <title>Vanilla Coding | Bootcamp Prep</title>
</head>
<style type="text/css">

html, body{
  background-color: #FFFFFF;
  font-family: 'Roboto', sans-serif;
}
.main{
  width: 100%;
  display: block;
  background: #ababab;
}
.content-wrap{
  width: 100%;
  margin:0 auto;
  border: 4px solid rgba(161, 161, 161, 0.5); 
  border-radius: 20px;
  overflow: hidden;
  background: #ddaf35;
}
.content-left{
  background: #0b0809;
  color:#ddaf35;
  float: left;
  width: 100%;
  padding: 30px;
}
.main-wrap{
  text-align: center;
  padding: 20px 0 0 0;
}
.main-day{
  font-size: 30px;
  font-weight: bold;
}
.main-date{
  font-size: 120px;
  font-weight: bold;
  margin: 20px 0;
}
.todo-wrap{
  padding: 0 0 0 40px;
}
.todo-title{
  font-size: 20px;
  font-weight: 100;
  margin: 0 0 10px 0;
}
.input-box{
  width: 50%;
  margin-right: 20px;
  height: auto; 
  background: #0b0809;
  color: #ddaf35;
  line-height : normal;
  padding: .8em .5em 0 0; 
  font-family: inherit;
  border: 0; 
  border-bottom: 1px dashed #ddaf35;; 
  border-radius: 0; 
  outline-style: none; 
  -webkit-appearance: none; 
  -moz-appearance: none; 
  appearance: none;
}
.input-data{
  cursor: pointer;
  font-size: 10px;
  padding: 10px;
  margin: 10px 0 10px 0;
  background: #ddaf35;
  border: none;
  color: #0b0809;
  border-radius: 10px;
}
.input-data:hover{
  background: #ffffff;
  color: #0b0809;
}
.input-list > div{
  font-size: 10px;
  width: 60%;
  float: left;
  color: #ddaf35;
}
.input-list > .checked{
  color: #FFFFFF;
  text-decoration:line-through
}
.del-data{
  display: block;
  color: #ddaf35;
  float: left;
  width: 10%;
  cursor: pointer;
  font-size: 10px;
  padding: 10px;
  background: #0b0809;
  border: none;
  border-radius: 10px;
}
.content-right{
  float: left;
  width: 90%;
  padding: 10px;
}
.sun{
  color:#ef3333;
}
.sat{
  color:#2107e0;
}
.content-right table tr td{
  width: 40px;
  height: 40px;
  text-align: center;
  font-size: 20px;
  font-weight: bold;
}
.active{
  background: #0b0809;
  border-radius: 50%;
  color: #ffffff;
}

@media(min-width: 850px){
  .main{
    display: flex;
    align-items: center;
    justify-content:  center;
    width: 100vw;
    height: 100vh;
    background: #ababab;
  }
  .content-wrap{
    width: 800px;
    height: 600px;
    margin:0 auto;
    border: 4px solid rgba(161, 161, 161, 0.5); 
    border-radius: 20px;
    overflow: hidden;
    background: #ddaf35;
  }
  .content-left{
    background: #0b0809;
    color:#ddaf35;
    float: left;
    width: 360px;
    height: 600px;
    padding: 90px 20px 20px 0;
  }
  .main-wrap{
    text-align: center;
    margin: 20px 0 0 0;
  }
  .main-day{
    font-size: 30px;
    font-weight: bold;
  }
  .main-date{
    font-size: 120px;
    font-weight: bold;
    margin: 20px 0;
  }
  .todo-wrap{
    padding: 0 0 0 40px;
  }
  .todo-title{
    font-size: 20px;
    font-weight: 100;
    margin: 0 0 10px 0;
  }
  .input-box{
    width: 70%;
    height: auto; 
    background: #0b0809;
    color: #ddaf35;
    line-height : normal;
    padding: .8em .5em 0 0; 
    font-family: inherit;
    border: 0; 
    border-bottom: 1px dashed #ddaf35;; 
    border-radius: 0; 
    outline-style: none; 
    -webkit-appearance: none; 
    -moz-appearance: none; 
    appearance: none;
  }
  .input-data{
    cursor: pointer;
    font-size: 10px;
    padding: 10px;
    margin: 20px 0 30px 0;
    background: #ddaf35;
    border: none;
    color: #0b0809;
    border-radius: 10px;
  }
  .input-data:hover{
    background: #ffffff;
    color: #0b0809;
  }
  .input-list > div{
    font-size: 10px;
    width: 60%;
    float: left;
    color: #ddaf35;
  }
  .del-data{
    display: block;
    color: #ddaf35;
    float: left;
    width: 10%;
    cursor: pointer;
    font-size: 10px;
    padding: 10px;
    background: #0b0809;
    border: none;
    border-radius: 10px;
  }
  .content-right{
    float: left;
    width: 360px;
    height: 600px;
    padding: 100px 20px 20px 20px;
  }
  .sun{
    color:#ef3333;
  }
  .sat{
    color:#2107e0;
  }
  .content-right table tr td{
    width: 50px;
    height: 50px;
    text-align: center;
    font-size: 20px;
    font-weight: bold;
  }
  .active{
    background: #0b0809;
    border-radius: 50%;
    color: #ffffff;
  }
}
</style>
<script type="text/javascript">
var currentTitle = document.getElementById('current-year-month');
var calendarBody = document.getElementById('calendar-body');
var today = new Date();
var first = new Date(today.getFullYear(), today.getMonth(),1);
var dayList = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
var monthList = ['January','February','March','April','May','June','July','August','September','October','November','December'];
var leapYear=[31,29,31,30,31,30,31,31,30,31,30,31];
var notLeapYear=[31,28,31,30,31,30,31,31,30,31,30,31];
var pageFirst = first;
var pageYear;
if(first.getFullYear() % 4 === 0){
    pageYear = leapYear;
}else{
    pageYear = notLeapYear;
}

function showCalendar(){
    let monthCnt = 100;
    let cnt = 1;
    for(var i = 0; i < 6; i++){
        var $tr = document.createElement('tr');
        $tr.setAttribute('id', monthCnt);   
        for(var j = 0; j < 7; j++){
            if((i === 0 && j < first.getDay()) || cnt > pageYear[first.getMonth()]){
                var $td = document.createElement('td');
                $tr.appendChild($td);     
            }else{
                var $td = document.createElement('td');
                $td.textContent = cnt;
                $td.setAttribute('id', cnt);                
                $tr.appendChild($td);
                cnt++;
            }
        }
        monthCnt++;
        calendarBody.appendChild($tr);
    }
}
showCalendar();

function removeCalendar(){
    let catchTr = 100;
    for(var i = 100; i< 106; i++){
        var $tr = document.getElementById(catchTr);
        $tr.remove();
        catchTr++;
    }
}

function prev(){
    inputBox.value = "";
    const $divs = document.querySelectorAll('#input-list > div');
    $divs.forEach(function(e){
      e.remove();
    });
    const $btns = document.querySelectorAll('#input-list > button');
    $btns.forEach(function(e1){
      e1.remove();
    });
    if(pageFirst.getMonth() === 1){
        pageFirst = new Date(first.getFullYear()-1, 12, 1);
        first = pageFirst;
        if(first.getFullYear() % 4 === 0){
            pageYear = leapYear;
        }else{
            pageYear = notLeapYear;
        }
    }else{
        pageFirst = new Date(first.getFullYear(), first.getMonth()-1, 1);
        first = pageFirst;
    }
    today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
    currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;'+ first.getFullYear();
    removeCalendar();
    showCalendar();
    showMain();
    clickedDate1 = document.getElementById(today.getDate());
    clickedDate1.classList.add('active');
    clickStart();
    reshowingList();
}

function next(){
    inputBox.value = "";
    const $divs = document.querySelectorAll('#input-list > div');
    $divs.forEach(function(e){
      e.remove();
    });
    const $btns = document.querySelectorAll('#input-list > button');
    $btns.forEach(function(e1){
      e1.remove();
    });
    if(pageFirst.getMonth() === 12){
        pageFirst = new Date(first.getFullYear()+1, 1, 1);
        first = pageFirst;
        if(first.getFullYear() % 4 === 0){
            pageYear = leapYear;
        }else{
            pageYear = notLeapYear;
        }
    }else{
        pageFirst = new Date(first.getFullYear(), first.getMonth()+1, 1);
        first = pageFirst;
    }
    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
    currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;'+ first.getFullYear();
    removeCalendar();
    showCalendar(); 
    showMain();
    clickedDate1 = document.getElementById(today.getDate());
    clickedDate1.classList.add('active');  
    clickStart();
    reshowingList();
}
</script>
<body>
  <div class="main">
    <div class="content-wrap">
      <div class="content-left">
        <div class="main-wrap">
          <div id="main-day" class="main-day"></div>
          <div id="main-date" class="main-date"></div>
        </div>
        <div class="todo-wrap">
          <div class="todo-title">Todo List</div>
          <div class="input-wrap">
            <input type="text" placeholder="please write here!!" id="input-box" class="input-box">
            <button type="button" id="input-data" class="input-data">INPUT</button>
            <div id="input-list" class="input-list"></div>
          </div>
        </div>
      </div>
      <div class="content-right">
        <table id="calendar" align="center">
          <thead>
            <tr class="btn-wrap clearfix">
              <td>
                <label id="prev">
                    &#60;
                </label>
              </td>
              <td align="center" id="current-year-month" colspan="5"></td>
              <td>
                <label id="next">
                    &#62;
                </label>
              </td>
            </tr>
            <tr>
                <td class = "sun" align="center">Sun</td>
                <td align="center">Mon</td>
                <td align="center">Tue</td>
                <td align="center">Wed</td>
                <td align="center">Thu</td>
                <td align="center">Fri</td>
                <td class= "sat" align="center">Sat</td>
              </tr>
          </thead>
          <tbody id="calendar-body" class="calendar-body"></tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>