<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<style>
	.id_input_re_1{
		color : green;
		display : none;
	}
	
	.id_input_re_2{
		color : red;
		display : none;
	}
	
	.id_input_re_3{
		color : green;
		display : none;
	}
	
	.id_input_re_4{
		color : red;
		display : none;
	}
	
	.id_input_re_5{
		color : red;
		display : none;
	}
	
	.id_input_re_6{
		color : red;
		display : none;
	}
	
	.id_input_re_7{
		color : red;
		display : none;
	}
	
	.id_input_re_8{
		color : green;
		display : none;
	}
	
	.id_input_checkId{
		color : red;
		display : none;
	}
	
	.id_input_checkPassword{
		color : red;
		display : none;
	}
	
	.id_input_checkPhone{
		color : red;
		display:none;
	}
	.error::-webkit-input-placeholder{
		color : red
	}
</style>

<script>
	//인증번호로 사용한 전역변수 생성
	var num;
	var idFlag = 0;
	var passwordFlag = 0;
	var emailFlag = 0;
	var nameFlag = 0;
	var phoneFlag= 0;
	var nicknameFlag = 0;
	
    function selectEmail(ele){ 
        var $ele = $(ele); 
        var $userEmail2 = $('input[name=userEmail2]'); 
        // '1'인 경우 직접입력 
        if($ele.val() == "1"){ 
            $userEmail2.attr('readonly', false); 
            $userEmail2.val(''); 
        } else { 
            $userEmail2.attr('readonly', true); 
            $userEmail2.val($ele.val()); 
        } 
    }
    //이메일 합치기
    function sumemail(){
        var text1=document.getElementById('userEmail1').value + '@' + document.getElementById('userEmail2').value;
        document.getElementById('userEmail').value = text1;
    }
    //회원가입 폼 빈값 검사
    function check(){
    	if($('#userId').val()==""){
    		$('#userId').attr('placeholder', '아이디를 입력하세요')
    		$('#userId').addClass('error');
    		return false;
    	} 
    	
    	if ($('#userPassword').val()==""){
    		$('#userPassword').attr('placeholder', '비밀번호를 입력하세요')
    		$('#userPassword').addClass('error');
    		return false;
    	} 
    	
    	if ($('#email1').val()==""){
    		$('#email1').attr('placeholder', '이메일를 입력하세요')
    		$('#email1').addClass('error');
    		return false;
    	}
    	
    	if ($('#userName').val()==""){
    		$('#userName').attr('placeholder', '이름을 입력하세요')
    		$('#userName').addClass('error');
    		return false;
    	} else {
    		nameFlag = 1;
    	}
    	
    	if ($('#userPhone').val()==""){
    		$('#userPhone').attr('placeholder', '전화번호를 입력하세요')
    		$('#userPhone').addClass('error');
    		return false;
    	}
    	
    	//핸드폰번호 유효성 검사
    	var userPhonePattern = /^010-?([0-9]{3,4})-?([0-9]{4})$/;
    	var phone = $('#userPhone').val();
    	var userPhonePatternTest = userPhonePattern.test(phone);
    	if(userPhonePatternTest==false){
    		$('.id_input_checkPhone').css("display","inline-block");
    	} else if(userPhonePatternTest==true) {
    		$('.id_input_checkPhone').css("display","none");
    	}
    	
    	if ($('#userNickname').val()==""){
    		$('#userNickname').attr('placeholder', '닉네임을 입력하세요')
    		$('#userNickname').addClass('error');
    		return false;
    	} 
    	
    	//비밀번호 정규표현식 유효성 검사
    	var userPasswordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    	var password = $('#userPassword').val();
    	var userPasswordPatternTest = userPasswordPattern.test(password);
  	    if(userPasswordPatternTest == false){
  		    $('.id_input_checkPassword').css("display","inline-block");
  		    return false;
  	    } else if(userPasswordPatternTest == true){
  	    	$('.id_input_checkPassword').css("display","none");
  	    }
  	   
    	if($('#confirmPassword').val()!=$('#userPassword').val()){
    		$('.id_input_re_5').css("display","inline-block");
    		$('.id_input_checkPassword').css("display","none");
    		return false;
    	} else {
    		passwordFlag = 1;
    	}
    	
    	//폼의 모든 내용이 잘 작성 되었나 확인후 submit
    	if(idFlag==1 && passwordFlag==1 && emailFlag==1 && nameFlag==1 && nicknameFlag==1 ){
    		return true;
    	} else {
    		return false;
    	}
    	
    }
</script>

<section style="flex-grow:1;">
	<form id="signupForm" method="post" action="/index/signUp" onsubmit ="return check()">
		   <div class="d-flex flex-row justify-content-center align-items-center">
		       <div class="d-flex flex-column col-md-4">
		           <div class="d-flex justify-content-center">
		               <h2 class= "m-5">회원가입</h2>
		           </div>
		           <div class="form-group">
		               <input id="userId" name="userId" class ="col-md-8 p-2" placeholder="아이디" type="text"/>
		               <button type="button" onClick="checkId()" class="btn col-3 p-2" style="background-color: rgb(242, 101, 45); color: white; margin-bottom: 6px;">중복확인</button>
		               <script>
		                function checkId() {
		             	   if($(userId).val() == ""){
		             		    $('#userId').attr('placeholder', '아이디를 입력하세요')
		              		    $('#userId').addClass('error');
		              		    return;
		             	   } 
		             	   
		             	   //아이디 정규표현식 유효성 검사
		             	   var userIdPattern = /^[a-z]+[a-z0-9]{5,19}$/;
		             	   var id = $(userId).val();
		             	   var userIdPatternTest = userIdPattern.test(id);
		             	   if(userIdPatternTest == false){
		             		   $('.id_input_checkId').css("display","inline-block");
		             		   $('.id_input_re_1').css("display", "none");
		             		   $('.id_input_re_2').css("display", "none");
	 						   $('.id_input_re_5').css("display","none");
		             		   return;
		             	   }
		             	   
		             	   
		 					$.ajax({
		 						url: "/index/checkId",
		 						data: {id},
		 						method:"post"
		 					})
		 					.done((data) => {
		 						if(data.result ==="가입불가"){
		 							$('.id_input_re_2').css("display","inline-block");
		 							$('.id_input_re_1').css("display", "none");
		 							$('.id_input_re_5').css("display","none");
		 							$('.id_input_checkId').css("display","none");
		 						} else if(data.result ==="가입가능"){
		 							idFlag = 1;
		 							$('.id_input_re_1').css("display","inline-block");
		 							$('.id_input_re_2').css("display", "none");
		 							$('.id_input_re_5').css("display","none");
		 							$('.id_input_checkId').css("display","none");
		 						}
		 					});
		 				}
		               </script>
		               <span class="id_input_checkId">6~20자의 영문 소문자와 숫자만 사용가능합니다.</span>
		               <span class="id_input_re_1">사용 가능한 아이디입니다.</span>
		   			   <span class="id_input_re_2">아이디가 이미 존재합니다.</span>
		        </div>
		        <div class="form-group">
		            <input id="userPassword" name="userPassword" class ="col-md-8 p-2" placeholder="비밀번호" type="password"/>
		            <span class="id_input_checkPassword">8자 이상, 하나 이상의 문자, 숫자, 특수문자를 조합하시오.</span>
		        </div>
		        <div class="form-group">
		            <input id="confirmPassword" class ="col-md-8 p-2" placeholder="비밀번호 확인" type="password"/>
		            <span class="id_input_re_5">비밀번호가 일치하지 않습니다.</span>
		        </div>
		        <div class="form-group d-flex flex-row">
		            <input class ="col-md-3 mr-1 p-2" id="userEmail1" name="userEmail1" placeholder="이메일" type="text" style="width: 80px;"/><span class="mt-2" style="font-size="1rem";>@</span><input class="ml-1 mr-1" id="userEmail2" name="userEmail2" type="text"/>
		            <select name = "select_email" class="p-2" onchange="selectEmail(this)">
		                <option value="" selected>선택하세요</option> 
		                <option value="naver.com">naver.com</option> 
		                <option value="gmail.com">gmail.com</option> 
		                <option value="hanmail.com">hanmail.com</option>
		                <option value="1">직접입력</option>
		            </select>
		            <input id="userEmail" name="userEmail" value="" style="display:none"/>
		        </div>
		        <span class="id_input_re_6">등록된 이메일입니다.</span>
		       	<div class="form-group">
		       		<button type="button" onClick="checkEmail()" class="btn p-2 col-md-8" style="background-color: rgb(242, 101, 45); color: white;">이메일 인증</button>
		       		<script>
		       			function checkEmail() {
		       			  sumemail();
		             	  if($('#userEmail1').val() == ""){
		              			$('#userEmail1').attr('placeholder', '이메일를 입력하세요')
		              			$('#userEmail1').addClass('error');
		             			return;
		             	   }
		             	   var email = $(userEmail).val();
		 					$.ajax({
		 						url: "/index/checkEmail",
		 						data: {email},
		 						method:"post"
		 					})
		 					.done((data) => {
		 						if(data.result ==="success"){
		 							emailAuthenticate();
		 							num=data.num;
		 							$('.id_input_re_6').css("display","none");
		 						} else if(data.result ==="fail"){
		 							$('.id_input_re_6').css("display","inline-block");
		 						}
		 					});
		 				}
		       			function emailAuthenticate(){
		       				$('#aDiv').css("display", "inline-block");
		       			}
		       		</script>
		       	</div>
		       	
		       	<div id="aDiv" class="form-group" style="display:none">
		       		<input id="certificationinput" name="certificationNum" class ="col-md-8 p-2" placeholder="인증번호" type="text"/>
		       		<button type="button" onClick="checkNum()" class="btn btn-sm col-3 p-2" style="background-color: rgb(242, 101, 45); color: white;">확인</button>
		       		<span class="id_input_re_7">인증번호가 일치하지 않습니다.</span>
		       		<span class="id_input_re_8">인증이 성공했습니다.</span>
		       	</div>
		       	<script>
		       		function checkNum(){
		       			if(num == $('#certificationinput').val()){
		       				emailFlag = 1;
		       				$('.id_input_re_8').css("display","inline-block");
							$('.id_input_re_7').css("display", "none");
		       			} else {
		       				$('.id_input_re_7').css("display","inline-block");
							$('.id_input_re_8').css("display", "none");
		       			}
		       		}
		       	</script>
		       	
		        <div class="form-group">
		            <input id="userName" name="userName" class ="col-md-8 p-2" placeholder="이름" type="text"/>
		        </div>
		        <div class="form-group">
		            <input id="userPhone" name="userPhone" class ="col-md-8 p-2" placeholder="전화번호" type="text"/>
		            <span>ex)010-1234-1234</span>
		            <p class="id_input_checkPhone" style="margin:0;">예시와 같은 형식이 아닙니다.</p>
		        </div>
		        
		        
		        <div class="form-group">
		            <input id="userNickname" name="userNickname" class ="col-md-8 p-2" placeholder="닉네임" type="text"/>
		            <button type="button" onClick="checkNickname()" class="btn p-2 col-3"  style="background-color: rgb(242, 101, 45); color: white; margin-bottom: 6px;">중복확인</button>
		        	<script>
		                function checkNickname() {
		             	   var nickname = $(userNickname).val();
		             	   if ($('#userNickname').val()==""){
		             		  $('#userNickname').attr('placeholder', '닉네임을 입력하세요')
		              		  $('#userNickname').addClass('error');
		             		  return;
		              	   }  
		             	   
		 					$.ajax({
		 						url: "/index/checkNickname",
		 						data: {nickname},
		 						method:"post"
		 					})
		 					.done((data) => {
		 						if(data.result ==="success"){
		 							$('.id_input_re_4').css("display","inline-block");
		 							$('.id_input_re_3').css("display", "none")
		 						} else if(data.result ==="fail"){
		 							nicknameFlag = 1;
		 							$('.id_input_re_3').css("display","inline-block");
		 							$('.id_input_re_4').css("display", "none");
		 						}
		 					});
		 				}
		               </script>
		               <span class="id_input_re_3">사용 가능한 닉네임입니다.</span>
		   			   <span class="id_input_re_4">닉네임이 이미 존재합니다.</span>
		        </div>
		        <div class = "form-group" style="margin-bottom:100px;">
		        	<input type="submit" onclick="" value="회원가입" class="btn p-2 col-11" style=" background-color: rgb(242, 101, 45); color: white; margin: 0px auto;"></input>
		        </div>
		    </div>
		</div>
	</form>
	</div>
	<div class="col-2"></div>
</section>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>