<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="https://kit.fontawesome.com/748830bbae.js" crossorigin="anonymous"></script>
	<script>
        function openMsgForm(marketWriter){
	        
	        if(`${sessionUserId}` == ""){
	    		swal({
	    			text:"로그인해야 이용할 수 있는 기능입니다. 로그인을 해주세요."
	    		});
	    		return;
	    	}

            var url = "<%=request.getContextPath() %>/message?receiver="+marketWriter;
            var option = "width = 300, height = 350, top = 100, left = 200, location = no";
            window.open(url, "message", option);
        }
        
        $(document).ready(function() {
        	showLikeCount();
        });
    </script>
    <style style="flex-grow:1;">
		.top-content { width: 100%;}
		.top-content .carousel-control-prev { left: -100px; border-bottom: 0; font-size: 40px; color: #444; }
		.top-content .carousel-control-next { right: -100px; border-bottom: 0; font-size: 40px; color: #444; }
		.top-content .carousel-caption .carousel-caption-description { color: #fff; color: rgba(255, 255, 255, 0.8); }
    </style>
    <section>
        <div class="container-fluid mb-5">
	      <div class="d-flex align-items-center justify-content-center mb-5">
	      	<img alt="" src="${pageContext.request.contextPath}/resources/images/marketBoard.png" style="width:100%">
	      </div>
            <div class="row">
                <div class="col-2">
                </div>
                <div class="col-8">
                	<div class="ml-3 mr-3">
	                    <span class="h5 pt-3" style="margin-bottom: 0px">글쓴이 : </span><span class="h5 pt-3" style="margin-bottom: 0px">${marketBoardDto.userDto.userNickname}</span>
	                    <a class="btn btn-outline-dark ml-2" onclick="openMsgForm('${marketBoardDto.marketWriter}')">쪽지보내기</a>
	                    <span class="date float-right mr-3 h6 pt-3" style="margin-bottom: 0px">
	                    	<fmt:formatDate value="${marketBoardDto.marketRegistDate}" pattern="yyyy-MM-dd  HH:mm"/>
	                    	<span class="ml-3">조회: ${marketBoardDto.marketHitCount}</span>
	                    	</span>
					</div>
                    <div class="card mt-3">
                        <div class="card-body p-3">
                            <div class="title mb-3">
                                <span class="h3 p-4">${marketBoardDto.marketTitle}</span>
                            </div>							
							<!-- Top content -->
					        <div class="top-content my-5 px-5">
					        	<div class="container px-5">
					        		<div class="row px-5">
					        			<div class="col">
								            <!-- Carousel -->
								            <div id="carousel-example" class="carousel slide" data-ride="carousel">
								
								                <div class="carousel-inner">
												  	<c:forEach var="file" items="${marketFileList}" varStatus="status">
												  		<c:if test="${status.index == 0}">
														    <div class="carousel-item active">
														      <img id="myModal" class="d-block w-100" src="getMarketImage?marketNo=${marketBoardDto.marketNo}&img=${status.index}" alt="First slide" style="height: 500px; width:100%; border-radius: 10px;">
														    </div>							  			
												  		</c:if>
												  		<c:if test="${status.index != 0}">
												  			<div class="carousel-item">
														      <img class="d-block w-100" src="getMarketImage?marketNo=${marketBoardDto.marketNo}&img=${status.index}" alt="other slide" style="height: 500px; width:100%; border-radius: 10px;">
														    </div>	
												  		</c:if>
												  	</c:forEach>
								                </div>
								                
								                <a class="carousel-control-prev" href="#carousel-example" role="button" data-slide="prev">
								                    <i class="fas fa-arrow-left" aria-hidden="true"></i>
								                    <span class="sr-only">Previous</span>
								                </a>
								                <a class="carousel-control-next" href="#carousel-example" role="button" data-slide="next">
								                    <i class="fas fa-arrow-right" aria-hidden="true"></i>
								                    <span class="sr-only">Next</span>
								                </a>
								            </div>
					            		</div>
					            	</div>
					            </div>
					        </div>

                            <div class="price h4 mt-4 p-3 ml-2">
                                <span>가격: </span> ${marketBoardDto.marketPrice} <span> 원</span>
                            </div>
                            <div class="p-3">
                            	<textarea name="content" class="form-control mt-3 bg-white" style="height: 300px; resize:none; font-size:20px;" disabled>${marketBoardDto.marketContent}</textarea>	
                            </div>
                        </div>
                    </div>
                    <div class="buttons mt-5 d-flex justify-content-center">
                        <a class="btn btn-outline-secondary p-3" style="width:100px; height:56px;" href="list?pageNo=${pageNo}&category=${category}&align=${align}&searchType=${searchType}&searchContent=${searchContent}">목록</a>
                        <button class="btn btn-outline-secondary ml-3" style="width:100px; " onclick="likeBtnClick(this);">
                        	<img id="interImg" class="mr-2" src="" width="30px;"/>
                        	<span id="interCnt" class="p-1">${marketBoardDto.marketLikeCount}</span>
                        </button>
                    </div>
                    <div class="buttons mt-5 d-flex justify-content-center">
                    	<c:if test="${sessionUserId == marketBoardDto.marketWriter}">
	                    	<a class="btn btn-outline-info p-2 m-2" style="width:100px;" href="update?marketNo=${marketBoardDto.marketNo}">수정</a>
	                        <button class="btn btn-outline-danger p-2 m-2" style="width:100px;" onclick="deleteMarketBoard('${marketBoardDto.marketNo}');">삭제</button>
	                        <button class="btn btn-outline-primary p-2 m-2" style="width:100px;" onclick="updateSaleYn('${marketBoardDto.marketNo}');">판매완료</button>
                    	</c:if>
                    </div>
                </div>
                <div class="col-2">
                </div>
            </div>
        </div>
    </section>
    <script>
		var likeCnt = `${marketBoardDto.marketLikeCount}`;
		var marketNo = `${marketBoardDto.marketNo}`;
    
	   function showLikeCount(){
	   	$.ajax({
	   		url: "checkLike",
	   		data:{
	   			id:`${sessionUserId}`,
	   			type:"market",
    			marketNo:`${marketBoardDto.marketNo}`
	   		}
	   	}).done((data) => {
	   		if(data.likeCheck == 'like'){
	   			$("#interImg").attr("src", "/resources/images/interestAfter.png");
	   		}else{
	   			$("#interImg").attr("src", "/resources/images/interestBefore.png");
	   		}
	   	});
	   }

		function likeBtnClick(img){
	        var path = document.getElementById("interImg").src;
	        
	        if(`${sessionUserId}` == ""){
	    		swal({
	    			text:"로그인해야 이용할 수 있는 기능입니다. 로그인을 해주세요."
	    		});
	    		return;
	    	}
	        
			if(path.includes("Before")){ //누르지 않은 상태에서 클릭했을 경우!
				likeCnt++;
	        	$.ajax({
	        		url : "setLikeLists",
	        		data : {
	        			check:"before",
	        			id:`${sessionUserId}`,
		    			type:"market",
		    			marketNo:marketNo,
		    			likeCnt:likeCnt
	        		}
	        	}).done((data) => {
	    			$("#interImg").attr("src", "/resources/images/interestAfter.png");
	    			document.getElementById("interCnt").innerHTML = likeCnt;
	    		});
	        } else {//이미 클릭한 상태에서 클릭했을 경우
	        	likeCnt--;
	        	$.ajax({
	        		url : "setLikeLists",
	        		data : {
	        			check:"after",
	        			id:`${sessionUserId}`,
		    			type:"market",
		    			marketNo:marketNo,
		    			likeCnt:likeCnt
	        		}
	        	}).done((data) => {
	    			$("#interImg").attr("src", "/resources/images/interestBefore.png");
	    			document.getElementById("interCnt").innerHTML = likeCnt;
	    		});
	        }
	    }
		
		function deleteMarketBoard(marketNo){
			$.ajax({
				url: "deleteMarketBaord",
				data: {marketNo:marketNo}
			}).done((data)=>{
            	swal({
					text: "삭제되었습니다."
				}).then(()=>{
					$(location).attr("href", "marketInsertCancle");
				});
	    		return;
			});
		}
		
		function updateSaleYn(marketNo){
			$.ajax({
				url: "updateSaleYn",
				data: {marketNo:marketNo}
			}).done((data)=>{
            	swal({
					text: "판매완료 되었습니다."
				}).then(()=>{
					$(location).attr("href", "marketInsertCancle");
				});
	    		return;
			});
		}

    </script>

	    	
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>