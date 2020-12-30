<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css">
<script src="../common/jquery/jquery-3.5.1.js"></script >
<script>
/* $(function(){
	$('#idCheck').click(function(){
		$.ajax({
			url : 'idCheck.js',
			type : 'get',
			dataType : "html",
			//요청성공시 콜백메소드 : 무기명함수 형태로 정의됨
			success : function(res) {
				alerm();
			},
			//요청 실패시 콜백메소드 : 외부함수 형태로 정의됨
			error : errFunc
		});
	});
}); 
function errFunc() {
	alert("에러발생, 디버깅 하시세요")
}*/

function idcheck() {
	var id = document.getElementsByName("id")[0];
    
    // if(id.length < 8 || id.length > 12){
    //     alert("아이디는 8자에서 12자 사이로 구성해 주세요");
    //     document.getElementsByName("userid")[0].value ="";
        
    // }
	
    if(id.value == ""){
    	alert("아이디를 입력해주세요");
    	return
    }

    var s_width = window.screen.width;
    var s_height = window.screen.height;

    var leftVar = s_width/2 - 300/2;
    var topVar = s_height/2 - 300/2;

    console.log(id);

    window.open("idCheck.jsp?id="+id.value,"idcheck","width=600, height=50, left=" + leftVar + ", top=" + topVar);
}

function email_input(f) {
	if(f.value ==1 || f.vlaue == ""){
		document.getElementsByName("email_2")[0].value = "";
	}
	else if(!(f.value == 1)){
		document.getElementsByName("email_2")[0].value = f.value;
	}
}
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function zipFind(){
            new daum.Postcode({
                oncomplete: function(data) {
                    console.log(data.zonecode);
                    console.log(data.address);
                    console.log(data.sido);
                    console.log(data.sigungu);

                    //가입폼에 적용하기(form을 가져오기)
                    var f = document.regiform;
                    //폼이름을 가져오면 태그의 이름으로 그 태그를 제어할 수 있다.
                    //zonecode.value(input태그)에 zonecode을 넣기
                    f.zip1.value = data.zonecode;
                    //address1.value(input태그)에 address을 넣기
                    f.addr1.value = data.address;
                    f.addr2.focus();
                }
            }).open();
        }
    </script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 <body>
	<center>
	<form name="regiform" action="../controller/memberinsert.do" 
		method="post" onsubmit="return check_form();" >
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<img src="../images/member/sub_image.jpg" id="main_visual" />
		<div class="contents_box">

			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">

				<div class="top_title">
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>

			</div>
				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>

						<td><input type="text" name="id"  value="" class="join_input" />&nbsp;
						<img onclick="idcheck();" src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp;
						<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>

					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
	<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
	<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
	<select name="last_email_check2" onChange="email_input(this);" class="pass" id="last_email_check2" >
		<option selected="" value="">선택해주세요</option>
		<option value="1" >직접입력</option>
		<option value="dreamwiz.com" >dreamwiz.com</option>
		<option value="empal.com" >empal.com</option>
		<option value="empas.com" >empas.com</option>
		<option value="freechal.com" >freechal.com</option>
		<option value="hanafos.com" >hanafos.com</option>
		<option value="hanmail.net" >hanmail.net</option>
		<option value="hotmail.com" >hotmail.com</option>
		<option value="intizen.com" >intizen.com</option>
		<option value="korea.com" >korea.com</option>
		<option value="kornet.net" >kornet.net</option>
		<option value="msn.co.kr" >msn.co.kr</option>
		<option value="nate.com" >nate.com</option>
		<option value="naver.com" >naver.com</option>
		<option value="netian.com" >netian.com</option>
		<option value="orgio.co.kr" >orgio.co.kr</option>
		<option value="paran.com" >paran.com</option>
		<option value="sayclub.com" >sayclub.com</option>
		<option value="yahoo.co.kr" >yahoo.co.kr</option>
		<option value="yahoo.com" >yahoo.com</option>
	</select>
	 
						<input type="checkbox" name="open_email" value="1">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zip1" value=""  class="join_input" style="width:50px;" />&nbsp;-&nbsp;
						<input type="text" name="zip2" value=""  class="join_input" style="width:50px;" />
						<a href="javascript:;" title="새 창으로 열림" onclick="zipFind();" onkeypress="">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>

				<p style="text-align:center; margin-bottom:20px"> <input type="image" src="../images/btn01.gif" name="submit" value="submit">&nbsp;&nbsp;<img src="../images/btn02.gif" /></a></p>
				
			</div>
		
  
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	<%@ include file="../include/footer.jsp" %>
	</form>
	</center>
 </body>
 <script type="text/javascript">
 function getParameter(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
 
 
function check_form() {
	var idCheck = getParameter("idCheck");


	
	var name = document.getElementsByName("name")[0].value;
	var id = document.getElementsByName("id")[0].value;
	var pass = document.getElementsByName("pass")[0].value;
	var pass2 = document.getElementsByName("pass2")[0].value;
	var tel1 = document.getElementsByName("tel1")[0].value;
	var tel2 = document.getElementsByName("tel2")[0].value;
	var tel3 = document.getElementsByName("tel3")[0].value;
	var mobile1 = document.getElementsByName("mobile1")[0].value;
	var mobile2 = document.getElementsByName("mobile2")[0].value;
	var mobile3 = document.getElementsByName("mobile3")[0].value;
	var email_1 = document.getElementsByName("email_1")[0].value;
	var email_2 = document.getElementsByName("email_2")[0].value;
	var addr1 = document.getElementsByName("addr1")[0].value;
	var addr2 = document.getElementsByName("addr2")[0].value;
	
	if(name == ""){
		alert("이름을 입력해주세요");
		return false;
	}
	
	else if(id == ""){
		alert("아이디를 입력해주세요");
		return false;
	}
	
	else if((document.getElementsByName("id")[0].readOnly) == false){
		alert("중복확인을 해주세요");
		return false;
	}
	
	else if(pass == ""){
		alert("비밀번호를 입력해주세요");
		return false;
	}
	else if(pass2 == ""){
		alert("비밀번호 확인을 입력해주세요");
		return false;
	}
	
	else if(pass != pass2){
		alert("비밀번호가 같지 않습니다.");
		return false;
	}
	else if(tel1 == ""){
		alert("전화번호를 입력해주세요");
		return false;
	}
	else if(tel2 == ""){
		alert("전화번호를 입력해주세요");
		return false;
	}
	else if(tel3 == ""){
		alert("전화번호를 입력해주세요");
		return false;
	}
	else if(mobile1 == ""){
		alert("핸드폰번호를 입력해주세요");
		return false;
	}
	else if(mobile2 == ""){
		alert("핸드폰번호를 입력해주세요");
		return false;
	}
	else if(mobile3 == ""){
		alert("핸드폰번호를 입력해주세요");
		return false;
	}
	else if(email_1 == ""){
		alert("이메일을 입력해주세요");
		return false;
	}
	else if(email_2 == ""){
		alert("이메일을 입력해주세요");
		return false;
	}
	else if(addr1 == ""){
		alert("주소를 입력해주세요");
		return false;
	}
	else if(addr2 == ""){
		alert("주소를 입력해주세요");
		return false;
	}
	else{
		alert("회원가입이 완료되었습니다.")
	}
	
	return true;
	
	
	
	
	
	
	
	
}
</script>
</html>
