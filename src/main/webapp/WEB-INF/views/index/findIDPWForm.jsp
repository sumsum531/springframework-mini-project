<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<style>
	.failFindEmail{
		color : red;
		display : none;
	}
	.failFindID{
		color : red;
		display : none;
		margin-bottom: 0px;
	}
	.successFindID{
		color : green;
		display : none;
		margin-bottom: 0px;
	}
	
	.failFindPassword{
		color : red;
		display : none;
		margin-bottom: 0px;
	}
	.successFindPassword{
		color : green;
		display : none;
		margin-bottom: 0px;
	}
	
	.noId{
		color : red;
		display : none;
		margin-bottom: 0px;
	}
	
	.noEmail{
		color : red;
		display : none;
		margin-bottom: 0px;
	}
	
	.error::-webkit-input-placeholder{
		color : red
	}
</style>
<script>
	var findIdNum;
	var findPasswordNum;
	var resultFindID = 0;
	var resultFindPassword = 0;

	function findEmail(){
		var emailValue = $('#findInputEmail').val();
		$.ajax({
			url: "/index/findEmail",
			data: {emailValue},
			method:"post"
		})
		.done((data) => {
			if(data.result ==="success"){
				$('#cDiv').css("display", "inline-block");
				$('.failFindEmail').css("display", "none");
				findIdNum = data.num;
				
			} else if(data.result ==="fail"){
				$('.failFindEmail').css("display", "inline-block");
				$('#cDiv').css("display", "none");
			}
		});
	}
	
	function confirmFindIdNum(){
		if(findIdNum == $(checkFindIdNum).val()){
			$('.successFindID').css("display", "inline-block");
			$('.failFindID').css("display", "none");
			resultFindID = 1;
		} else{
			$('.successFindID').css("display", "none");
			$('.failFindID').css("display", "inline-block");
		}
	}
	
	function emailConfirm(){
		if(resultFindID==1){
			return true;
		} else {
			return false;
		}
	}
	
 	
</script>
<section  style="flex-grow:1;">
	<div class="d-flex justify-content-center align-items-center" style="margin-top: -31px;">
    <div class="d-flex flex-column justify-content-center col-md-3">
        <ul class="nav nav-tabs" id="myTab" role="tablist" style="margin-top: 30%">
            <li class="nav-item" role="presentation">
              <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">?????????</a>
            </li>
            <li class="nav-item" role="presentation">
              <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">????????????</a>
            </li>
          </ul>
          <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
            
            
             <form>
              <div class="d-flex flex-column justify-content-center align-items-center p-3" style="border: 1px solid black; border-radius: 5px;">
                     <div>
                         <h2 class="pb-3" style="text-align: center;">???????????????</h2>
                         <div class="form-group">
                             <input id="findInputEmail" name="findInputEmail" placeholder="????????? ?????????" type="text" style="padding: 2px;"/>
                             <button type="button" onClick="findEmail()" class="btn btn-sm" style="background-color: rgb(242, 101, 45); color: white; margin-bottom: 7px;">???????????? ??????</button>
                         </div>
                         
                         <span class="failFindEmail" style="margin-bottom: 15px ">????????? ???????????? ????????????.</span>
                         
                         <div id="cDiv" class="form-group" style="display:none;" >
                             <input id="checkFindIdNum" placeholder="????????????" type="text" style="padding: 2px;"/>
                             <button type="button" onClick="confirmFindIdNum()" class="btn btn-sm" style="background-color: rgb(242, 101, 45); color: white; margin-bottom: 7px;">??????</button>
                             <span class="failFindID" style="margin-bottom: 15px ">??????????????? ???????????? ????????????.</span>
                             <span class="successFindID" style="margin-bottom: 15px ">??????????????? ?????????????????????.</span>
                         </div>
                     </div>
                     
                     <div>
                         <button type="button" onClick="findIdByEmail()" class="btn btn-sm" style="margin:30px auto; width: 300px; background-color: rgb(242, 101, 45); color: white;">???????????????</button>
                     </div>
                     <script>
                     	function findIdByEmail(){
                     		if(emailConfirm() != true){
                     			return
                     		}
                     		
                     		var emailValue = $('#findInputEmail').val();
                    		$.ajax({
                    			url: "/index/findIdByEmail",
                    			data: {emailValue},
                    			method:"post"
                    		})
                    		.done((data) => {
                    			//alter???
                    			swal({
                    				title:"???????????????",
                    				text:data.result,
                    				icon:"${pageContext.request.contextPath}/resources/images/smallMascot.png"
                    			}).then(function(){
                    				$(location).attr("href", "loginForm");
                    			})
                    		});
                     	}
                     	
                     	function confirmFindPasswordNum(){
                    		if(findIdNum == $(checkFindIdNum).val()){
                    			$('.successFindID').css("display", "inline-block");
                    			$('.failFindID').css("display", "none");
                    			resultFindID = 1;
                    		} else{
                    			$('.successFindID').css("display", "none");
                    			$('.failFindID').css("display", "inline-block");
                    		}
                    	}
                     </script>
                 </div>
           </form>
           
           
            </div>
            
            
            <div class="tab-pane fade " id="profile" role="tabpanel" aria-labelledby="profile-tab">
            	
            	
            	<form method="post" action="">
	             	<div class="d-flex flex-column justify-content-center align-items-center p-3" style="border: 1px solid black; border-radius: 5px;">
	                     <div>
	                         <h2 class="pb-3" style="text-align: center;">??????????????????</h2>
	                         <div class="form-group">
	                             <input id="requireId" placeholder="?????????" type="text"/>
	                             <span class="noId" style="margin-bottom: 15px ">???????????? ?????? ??????????????????.</span>
	                         </div>
	                         <div class="form-group">
	                             <input id="passwordEmail" placeholder="????????? ?????????" type="text" style="padding: 2px;"/>
	                             <button type="button" onClick="checkInfo()" class="btn btn-sm" style="background-color: rgb(242, 101, 45); color: white; margin-bottom: 7px;">???????????? ??????</button>
	                         	 <span class="noEmail" style="margin-bottom: 15px ">???????????? ?????? ??????????????????.</span>
	                         </div>
	                         <script>
		                         function checkInfo(){
		                      		if($("#requireId").val() == ""){
		                      			$("#requireId").attr("placeholder", "???????????? ???????????????");
		                      			$("#requireId").addClass('error');
		                      			return;
		                      		}
		                      		
		                      		if($("#passwordEmail").val() == ""){
		                      			$("#passwordEmail").attr("placeholder", "???????????? ???????????????");
		                      			$("#passwordEmail").addClass('error');
		                      			return;
		                      		}
		                      		
		                      		var idValue = $("#requireId").val();
		                      		var passwordEmail = $('#passwordEmail').val();
		                    		$.ajax({
		                    			url: "/index/findPasswordByEmail",
		                    			data: {idValue,passwordEmail},
		                    			method:"post"
		                    		})
		                    		.done((data) => {
		                    			if(data.result=="noId"){
		                    				$('.noId').css("display", "inline-block");
		                    			} else if(data.result=="noEmail"){
		                    				$('.noId').css("display", "none");
		                    				$('.noEmail').css("display", "inline-block");
		                    			} else if(data.result=="successAll"){
		                    				$('.noId').css("display", "none");
		                    				$('.noEmail').css("display", "none");
		                    				$('#pDiv').css("display", "inline-block");
		                    				findPasswordNum = data.num;
		                    			}
		                    		});
		                      		
		                      	 }
	                         </script>
	                         
	                         <div id="pDiv" class="form-group" style="display:none">
                             	 <input id="checkFindPasswordNum" placeholder="????????????" type="text" style="padding: 2px;"/>
	                             <button type="button" onClick="confirmFindPasswordNum()" class="btn btn-sm" style="background-color: rgb(242, 101, 45); color: white; margin-bottom: 7px;">??????</button>
                         		 <span class="failFindPassword" style="margin-bottom: 15px ">??????????????? ???????????? ????????????.</span>
                             	 <span class="successFindPassword" style="margin-bottom: 15px ">??????????????? ?????????????????????.</span>
                         	</div>
                         	<script>
                         		function confirmFindPasswordNum(){
                         			if(findPasswordNum == $(checkFindPasswordNum).val()){
                         				$('.successFindPassword').css("display", "inline-block");
                         				$('.failFindPassword').css("display", "none");
                         				resultFindPassword = 1;
                         			} else{
                         				$('.successFindPassword').css("display", "none");
                         				$('.failFindPassword').css("display", "inline-block");
                         			}
                         		}
                         	</script>
	                     </div>
	                     <div>
	                         <button type="button" onClick="sendNewPassword()" class="btn btn-sm" style="margin:30px auto; width: 300px; background-color: rgb(242, 101, 45); color: white;">?????????????????????</button>
	                     </div>
	                     <script>
	                     	 function sendNewPassword(){
	                     		if(findPasswordCheck() != true){
	                     			return;
	                     		}
	                     		
	                     		var idValue = $('#requireId').val();
	                     		var toEamil = $('#passwordEmail').val();
	                    		console.log(idValue);
	                    		$.ajax({
	                    			url: "/index/sendNewPassword",
	                    			data: {idValue,toEamil},
	                    			method:"post"
	                    		})
	                    		.done((data) => {
	                    			if(data.result=="update"){
	                    				//alter???
		                    			swal({
		                    				title:"????????????????????? ?????????????????????",
		                    				text:"??????????????? ?????? ??? ??????????????? ?????? ??????????????? ??????????????????",
		                    				icon:"${pageContext.request.contextPath}/resources/images/smallMascot.png"
		                    			}).then(function(){
		                    				$(location).attr("href", "loginForm");
		                    			})
	                    			}
	                    		});
	                     	 }
	                     
		                     function findPasswordCheck(){
		                 		if(resultFindPassword==1){
		                 			return true;
		                 		} else {
		                 			return false;
		                 		}
		                 	 } 
	                     </script>
	                 </div>
            	
            	
            	 </form>
            </div>
          </div>
    </div>
</div>
</section>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
