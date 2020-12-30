<%@page import="controller.Idcheck"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IdCheck.html</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    
    <style>
        
        @import url('https://fonts.googleapis.com/css2?family=Gaegu&family=Noto+Sans+KR&display=swap');
    
        *{
            font-family: 'Gaegu', cursive;/*문서의 기본폰트 설정*/
            font-size: 20px;
            margin: 0 auto;/*문서의 전체의 가운데 정렬*/
        }
        
        form{
            padding-left: 80px;
        }

        form button{
            background-color: #333333; font-size: 1em; width: 100px;
            padding: 5px; color: #ffffff; border: 2px solid #333333;
        }
        form #warring{
        	color : red;
        }
    </style>
</head>
<body>
	<%
		String id = request.getParameter("id"); 
		System.out.println(request.getAttribute("idCheck"));
		//int idCheck = (int)request.getAttribute("idCheck");
		
	%>
    <form name="overlapping" action="../controller/idcheck.do"
    	onsubmit="return idcheck()">
        <input type="text" name="id" id="id" value= <%=id %>>  
<%if(request.getAttribute("idCheck") == null){ %>
        <button type="submit" onclick="idcheck();">중복확인</button> 
        <p id="warring"></p>
        

<%}else if((boolean)request.getAttribute("idCheck") == false){ %>
        <button type="submit" onclick="idcheck();">중복확인</button> 
        <p id="warring">중복된 아이디 입니다.</p>
        
<%}else{ %>
		<script>
			document.getElementsByName("id")[0].readOnly = true;
		</script>
        <button onclick="idUse();">사용하기</button> 
        <p id="warring">사용 가능한 아아디입닌다. 사용하기 버튼을 눌러주세요</p>
<%} %>
</form>
    

    <script>
       	function getParameter(name) {
       	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
       	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
       	        results = regex.exec(location.search);
       	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
       	}
        function idcheck(){
        	
        	
        	var idcheck = getParameter("idcheck");
        	var double_id = getParameter("id");
        	var flag;
            
        	//특수기호가 있는지 없는지 확인하는 변수
        	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
        	//한글 체크
        	var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

        	
            console.log(document.getElementById("id").value);
            
            var id = document.getElementById("id").value;
            
            var chk_num = id.search(/[0-9]/g);
            var chk_eng = id.search(/[a-z]/ig);
            
            
            if(id.length < 4 || id.length > 12){
            	document.getElementById("warring").innerHTML = "아이디는 8~12자 사이로 만들어주세요";
            	return false;
            }
            
            else if(!isNaN(id.charAt(0))){
            	document.getElementById("warring").innerHTML = "아이디의 첫문자는 숫자로 만들수 없습니다. ";
            	return false;
            }
            
            else if(special_pattern.test(id) || pattern_kor.test(id)){
            	document.getElementById("warring").innerHTML = "아이디는 숫자와 영어로만 만드실수 있습니다. ";
            	return false;
            }
            
            else if(chk_num < 0 || chk_eng < 0){
            	document.getElementById("warring").innerHTML = "아이디는 숫자와 영어의 조합이어야합니다.. ";
            	return false;
            }
           
       
            
            return true;
           
               
        }
        
        function idUse() {
			
        	opener.document.getElementsByName("id")[0].value = document.getElementById("id").value;
        	opener.document.getElementsByName("id")[0].readOnly = true;
        	self.close();
		}
    </script>
</body>
</html>