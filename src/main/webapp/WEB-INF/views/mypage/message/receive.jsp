<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <script>
    	
    	var msgForm;
    	
	    function selectAll(selectAll)  {
	        const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	        
	        checkboxes.forEach((checkbox) => {
	            checkbox.checked = selectAll.checked
	        })
	    }

	    function openMsgForm(receiver, messageNo){
	    	console.log(name);
            var url = "<%=request.getContextPath() %>/message?receiver="+receiver+"&messagedNo="+messageNo;
            var option = "width = 300, height = 350, top = 100, left = 200, location = no";
            window.open(url, "message", option);
        }
		
	    function receiveMsg(msgNo){
            var url = "<%=request.getContextPath() %>/messageView?messageNo="+msgNo;
            var option = "width = 300, height = 350, top = 100, left = 200, location = no";
            window.open(url, "message", option);
        }
	    
	    function fn_checkedDel(){
        	var cnt = $("input[name='messageNo']:checked").length;
        	console.log(cnt);
        	
        	var arr = new Array();
        	$("input[name='messageNo']:checked").each(function(){
        		arr.push($(this).attr('id'));
        	});
        	if(cnt == 0){
				swal("선택된 게시물이 없습니다.");
        	} else {
        		console.log(arr);
        		$.ajax({
        			type: 'POST',
        			url: '/mypage/message/rdeleteMsg',
        			dataType: 'json',
        			data: {delArr: arr},
        		}).done((data) => {
        		}).fail((data) => {
        		});
        	}
        	location.reload();
        }
    </script>
   
    <section>
        <div class="container-fluid h-100 mt-5">
            <div class="row">
                <div class="col-2">
                    <div class="p-5 justify-content-center">
                        <div class="mt-5"><a href="/mypage/modify" class="btn btn-outline-dark w-100 p-2">내 정보 수정</a></div>
                        <div class="mt-2"><a href="/mypage/myboard/board" class="btn btn-outline-dark w-100 p-2">작성글</a></div>
                        <div class="mt-2"><a href="/mypage/message/receive" class="active btn btn-outline-dark w-100 p-2">쪽지함</a></div>
                        <div class="mt-2"><a href="/mypage/prefer/buildingprefer" class="btn btn-outline-dark w-100 p-2">찜목록</a></div>
                        <div class="mt-2"><a href="/mypage/withdrawl" class="btn btn-outline-dark w-100 p-2">회원탈퇴</a></div>
                    </div>
                </div>
                <div class="col-8">
                    <h3 class="m-3">쪽지함</h3>
                    <div class="row">
                        <ul class="nav nav-tabs">
                            <li class="nav-item">
                                <a class="nav-link active h5 text-dark" href="/mypage/message/receive">받은쪽지함</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link h5 text-dark" href="/mypage/message/send">보낸쪽지함</a>
                            </li>
                        </ul>
                    </div>
                    <div class="row">
                        <table class="table table-hover">
                            <thead>
                                <tr class="text-center">
                                    <th>제목</th>
                                    <th>받은날</th>
                                    <th>보낸사람</th>
                                    <th>답장여부</th>
                                    <td><input type="checkbox" onclick="selectAll(this)"/></td>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="message" items="${messages}">
                            	<tr class="text-center">
                                    <td><a onclick="javascript:receiveMsg('${message.messageNo}');" class="text-dark">${message.messageTitle}</a></td>
                                    <td><fmt:formatDate value="${message.messageDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td><span id="${message.messageNo}">${message.messageSender }</span></td>
                                    <td><a href="#" class="btn btn-outline-dark" onclick="openMsgForm('${message.messageSender}','${message.messageNo}')">답장</a></td>
                                    <td><input type="checkbox" class="delete" name="messageNo" id="${message.messageNo}"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="row float-right">
                        <div class="mr-2">
                            <input type="button" value="삭제" class="float-right btn btn-sm btn-outline-dark" onclick="fn_checkedDel();"/>
                        </div>
                    </div>
                    <div class="row d-flex justify-content-center mb-5">
                    <c:if test="${total > 0}">
						<ul class="pagination justify-content-center mb-0">
			               	<li class="page-item">
								<a class="page-link" href="/mypage/message/receive?pageNo=1">First</a>
							</li>
							<c:if test="${pager.groupNo>1}">
								<li class="page-item">
									<a class="page-link" href="/mypage/message/receive?pageNo=${pager.startPageNo-1}">Previous</a>
								</li>
							</c:if>
		                    <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}"><!-- 시작 페이지부터 마지막 페이지까지 반복 -->
								<c:if test="${pager.pageNo != i}">
									<li class="page-item">
										<a class="page-link" href="/mypage/message/receive?pageNo=${i}">${i}</a>
									</li>
								</c:if>
								<c:if test="${pager.pageNo == i}">
									<li class="page-item active">
										<a class="page-link" href="/mypage/message/receive?pageNo=${i}">${i}</a>
									</li>
								</c:if>
							</c:forEach>
							<c:if test="${pager.groupNo<pager.totalGroupNo}">
								<li class="page-item">
			                      <a class="page-link" href="/mypage/message/receive?pageNo=${pager.endPageNo+1}">Next</a>
			                    </li>
							</c:if>
							<li class="page-item">
			                	<a class="page-link" href="/mypage/message/receive?pageNo=${pager.totalPageNo}">Last</a>
			                </li>
	                	</ul>
	                </c:if>	
                    </div>
                </div>
            </div>
        </div>
    </section>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
   