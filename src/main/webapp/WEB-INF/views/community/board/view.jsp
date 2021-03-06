<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

    <section style="flex-grow:1;">
      <div class="d-flex align-items-center justify-content-center mb-5">
      	<img alt="" src="${pageContext.request.contextPath}/resources/images/freeBoard.png" style="width:100%">
      </div>
      <div class="container-fluid mt-5">
        <div class="row">
          <div class="col-2"></div>
          <div class="col-8">
            <div class="mb-5">
              <div class="my-2">
                <p class="d-inline-block h6 mx-2">글쓴이 <span class="ml-1">${freeBoardDto.userDto.userNickname}</span></p>
                <p class="d-inline-block h6 float-right mx-2">조회수: <span>${freeBoardDto.freeHitCount}</span></p>
                <p class="d-inline-block h6  float-right mx-2"><fmt:formatDate value="${freeBoardDto.freeRegistDate}" pattern="HH:mm"/></p>
                <p class="d-inline-block h6 float-right mx-2"><fmt:formatDate value="${freeBoardDto.freeRegistDate}" pattern="yyyy-MM-dd"/></p>            
              </div>
              <div id="free-board-title" class="h4 p-3" style="border: 1px solid rgb(224, 224, 224); border-radius: 10px;">${freeBoardDto.freeTitle}</div>
              <div id="free-board-content" class="h5 px-3 py-5" style="border: 1px solid rgb(224, 224, 224); border-radius: 10px;">
              	${freeBoardDto.freeContent}
              </div>
              <div class="text-center my-3">
				<c:if test="${sessionUserId == freeBoardDto.freeWriter}">
					<a href="/community/board/update?freeNo=${freeBoardDto.freeNo}" class="btn btn-outline-info p-2 my-4" style="width:100px;">수정</a>
				</c:if>  	
				<c:if test="${from ne 'mypage'}">
					<a href="/community/board/list?pageNo=${pageNo}" class="btn btn-outline-secondary my-4 p-2" style="width:100px;">목록</a>
				</c:if>
				<c:if test="${from eq 'mypage'}">
					<a href="/mypage/myboard/board?pageNo=${pageNo}" class="btn btn-outline-secondary my-4 p-2" style="width:100px;">목록</a>
				</c:if>
				<c:if test="${sessionUserId == freeBoardDto.freeWriter}">
					<a href="/community/board/freeBoardPostingDelete?freeNo=${freeBoardDto.freeNo}" class="btn btn-outline-danger p-2 my-4" style="width:100px;">삭제</a>
				</c:if> 
              </div>
              <div id="free-board-coment">
	              <ul>
 	              	<c:forEach var="commentDto" items="${comments}" varStatus="status">
 	              		<c:if test="${commentDto.upperNo == 0}">
			        		<li class="list-group-item">
			        			<div id ="innerContainer${commentDto.commentNo}"></div>
			        			<div id="container${commentDto.commentNo}" class="row">
			        			<div class="col-10">
				              		<input id="freeNo${commentDto.commentNo}" type="hidden" name="freeNo" value="${commentDto.freeNo}"/>
				              		<input id="commentNo${commentDto.commentNo}" type="hidden" name="commentNo" value="${commentDto.commentNo}"/>
				              		<input id="upperNo${commentDto.commentNo}" type="hidden" name="upperNo" value="${commentDto.upperNo}"/>
				              		<input id="commentDepth${commentDto.commentNo}" type="hidden" name="commentDepth" value="${commentDto.commentDepth}"/>
				                     <div style="flex: 8; padding: 4px 13px;">
			                         <p id="commentWriter${commentDto.commentNo}" style="font-weight: bold;">${commentDto.userDto.userNickname}</p>
			                         <div style="white-space:pre;" id="commentContent${commentDto.commentNo}" class="comment-text">${commentDto.commentContent}</div>
			                         <p><small><fmt:formatDate value="${commentDto.commentRegistDate}" pattern="yyyy-MM-dd HH:mm"/></small></p>
			                       </div>		                     		                    			
			        			</div>
								<div class="col-2">
			                  		<div class="d-flex flex-column comment2" style="margin-right: 13px;">
			                  			<button class="commentBtn" onclick="bringReplyJson(${commentDto.commentNo})">답글</button>
			                       		<c:if test="${sessionUserId == commentDto.commentWriter}">
		             				       <button class="commentBtn" onclick="updateContent(${commentDto.commentNo})">수정</button>
		             				       <form method="post" action="commentDelete">
		             				       		<input type="hidden" name="freeNo" value="${commentDto.freeNo}"/>
		             				       		<input id="${status.index}" type="hidden" name="commentNo" value="${commentDto.commentNo}"/>
		             				       		<input type="hidden" name="upperNo" value=" ${commentDto.upperNo}"/>
		             				       		<button type="submit" class="commentBtn" style="width:161px;">삭제</button>
		             				       	</form>                                 
			                       		</c:if>
			                      	</div>							
								</div>
			                  	</div>
			                  	<div id ="replyContainer${commentDto.commentNo}"></div>
			                  </li>				 	              		
 	              		</c:if>
 	              		<c:if test="${commentDto.upperNo != 0}">
 	              			<li class="list-group-item">
			        			<div id ="innerContainer${commentDto.commentNo}" class="pl-5"></div>
			        			<div id="container${commentDto.commentNo}" class="row pl-5">
			        			<div class="col-10">
				              		<input id="freeNo${commentDto.commentNo}" type="hidden" name="freeNo" value="${commentDto.freeNo}"/>
				              		<input id="commentNo${commentDto.commentNo}" type="hidden" name="commentNo" value="${commentDto.commentNo}"/>
				              		<input id="upperNo${commentDto.commentNo}" type="hidden" name="upperNo" value="${commentDto.upperNo}"/>
				              		<input id="commentDepth${commentDto.commentNo}" type="hidden" name="commentDepth" value="${commentDto.commentDepth}"/>
				                     <div style="flex: 8; padding: 4px 13px;">
			                         <p id="commentWriter${commentDto.commentNo}" style="font-weight: bold;">${commentDto.userDto.userNickname}</p>
			                         <div style="white-space:pre;" id="commentContent${commentDto.commentNo}" class="comment-text">${commentDto.commentContent}</div>
			                         <p><small><fmt:formatDate value="${commentDto.commentRegistDate}" pattern="yyyy-MM-dd HH:mm"/></small></p>
			                       </div>		                     		                    			
			        			</div>
								<div class="col-2">
			                  		<div class="d-flex flex-column comment2" style="margin-right: 13px;">
			                       		<c:if test="${sessionUserId == commentDto.commentWriter}">
			                       		   <button class="commentBtn" onclick="updateContent(${commentDto.commentNo})">수정</button>
		             				       <form method="post" action="commentDelete">
		             				       		<input type="hidden" name="freeNo" value="${commentDto.freeNo}"/>
		             				       		<input id="${status.index}" type="hidden" name="commentNo" value="${commentDto.commentNo}"/>
		             				       		<input type="hidden" name="upperNo" value=" ${commentDto.upperNo}"/>
		             				       		<button type="submit" class="commentBtn" style="width:100%">삭제</button>
		             				       	</form>                                 
			                       		</c:if>
			                      	</div>							
								</div>
			                  	</div>
			                  	<div id ="replyContainer${commentDto.commentNo}"></div>
			                  </li>	
 	              		</c:if>                
	              	  </c:forEach>
	              	  
	              	  <c:if test="${sessionUserId != null}">
			              <li class="list-group-item">
			              	<form method="post" action="insertComment" id="insertComment">
			              		<input type="hidden" name="freeNo" value="${freeBoardDto.freeNo}"/>
		                      	<div class="row" style="display: flex;">
			                        <div style="flex: 8; padding: 4px 13px;">
			                          	<p style="font-weight: bold;">${sessionUserNickname}</p>
			                          	<textarea placeholder="댓글을 입력해 주세요." style="display: block; width: 100%; height: 60px; resize: none;" name="commentContent"></textarea>
			                        </div>
			                        <div class="d-flex flex-column justify-content-end mb-3" style="margin-right: 13px;">
			                          <button type="submit" class="commentBtn">등록</button>
			                        </div>
		                      	</div>		              
			              	</form>
		                  </li>	              	              	  
	              	  </c:if>
	              </ul>
              </div>
            </div>           
          <div class="col-2"></div>
        </div>
      </div>
      </div>
    </section>
<script>
	function updateContent(commentNo){
		
		var freeNo = $("#freeNo"+commentNo).val();
		var commentContent = $("#commentContent"+commentNo).text();
		var userNickname = $("#commentWriter"+commentNo).text();
		var upperNo = $("#upperNo"+commentNo).val();

		var userId = "${sessionUserId}";
		$("#container"+commentNo).attr('style','display:none');
		
		$.ajax({
			url: "/community/board/updateContent",
			data: {"commentContent":commentContent, "commentNo":commentNo, "userId":userId,
					"userNickname":userNickname, "freeNo":freeNo, "upperNo":upperNo},
			method: "post"
		}).done((data)=>{
			$("#innerContainer"+commentNo).html(data);
		}) 
	}

	function bringReplyJson(commentNo){
		var	upperNo = commentNo;
		var	freeNo = $("#freeNo"+commentNo).val();
		var	userId = "${sessionUserId}";
		var	commentDepth = $("#commentDepth"+commentNo).val();

		$.ajax({
			url: "/community/board/bringReplyJson",
			data: {"upperNo":upperNo, "freeNo":freeNo, "userId":userId, "commentDepth":commentDepth},
			method: "post"
		
		}).done((data)=>{
			var html = '';
			html +='	<div class="row pl-5" style="display: flex;">';
			html +='		<div style="flex: 8; padding: 4px 13px;">'; 
			html +=`			<p style="font-weight: bold;">${sessionUserNickname}</p>`;
			html +='			<textarea id="textarea'+ data.upperNo +'" placeholder="댓글을 입력해 주세요." style="display: block; width: 100%; height: 60px; resize: none;"></textarea>';
			html +='		</div>';
			html +='		<div class="d-flex flex-column justify-content-end mb-3" style="margin-right: 13px;">';
			html +='		  <button type="submit" class="commentBtn" onclick="registReply(' + data.upperNo + ')">등록</button>';
			html +='		</div>';
			html +='	</div>';
			
			$("#replyContainer"+commentNo).html(html);
		})
	}
	
	function registReply(commentNo){
		$("#replyContainer"+commentNo).attr('style','display:none');
		
		var	upperNo = commentNo;
		var	freeNo = $("#freeNo"+commentNo).val();
		var	commentDepth = $("#commentDepth"+commentNo).val();
		var	commentContext= $("#textarea"+commentNo).val();
		var	userId = "${sessionUserId}";
		
		$.ajax({
			url: "/community/board/registReply",
			data: { userId,  upperNo, freeNo, commentDepth, commentContext},
			method:"POST",
		}).done((data)=>{
		})
		window.location.reload(true);
	}
		
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>