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
 <script type="text/javascript">
		function idUse(){
			opener.document.regiform.userid.value = 
				document.overlapping.userid.value;
			self.close();
		}
	</script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    
    <style>
        
        @import url('https://fonts.googleapis.com/css2?family=Gaegu&family=Noto+Sans+KR&display=swap');
    
        *{
            font-family: 'Gaegu', cursive;/*문서의 기본폰트 설정*/
            font-size: 15px;
            margin: 0 auto;/*문서의 전체의 가운데 정렬*/
        }
        
        form{
            padding-left: 30px;
        }

        form button{
            background-color: #333333; font-size: 1em; width: 80px;
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
		
	%>
    <form name="overlapping">
        <input type="text" id="userid" value= <%=id %>>     
        <button type="button" onclick="idcheck();">중복확인</button> 
        <p id="warring"></p>
    </form>

    <script>
        function idcheck(){
            
        	//특수기호가 있는지 없는지 확인하는 변수
        	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
        	//한글 체크
        	var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

        	
            console.log(document.getElementById("userid").value);
            
            var id = document.getElementById("userid").value;
            
            if(id.length < 8 || id.length > 12){
            	document.getElementById("warring").innerHTML = "아이디는 8~12자 사이로 만들어주세요";
            }
            
            else if(!isNaN(id.charAt(0))){
            	document.getElementById("warring").innerHTML = "아이디의 첫문자는 숫자로 만들수 없습니다. ";
            }
            
            else if(special_pattern.test(id) || pattern_kor.test(id)){
            	document.getElementById("warring").innerHTML = "아이디는 숫자와 영어로만 만드실수 있습니다. ";
            }
            
            else{
            	opener.document.getElementById("allow").innerHTML = "사용가능";
            	//document.getElementById("userid").readOnly = true;
            	opener.document.getElementsByName("userid")[0].value = id;
            	self.close();
            }
            
            
        }
    </script>
</body>
</html>