<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

    <section>
      <div class="container-fluid h-100 my-5">
        <div class="row">
          <div class="col-2"></div>
          <div class="col-8">
            <div class="h3 border-bottom mb-3"><img src="${pageContext.request.contextPath}/resources/images/writing.png">글쓰기</div>
            <div class="mb-5">
              <form method="post" action="insertContent" id="insertForm">
                <input type="text" class="form-control my-3" maxlength="100" placeholder="제목을 입력하세요"></input>
                <textarea class="form-control" placeholder="게시물 내용을 작성해 주세요." maxlength="1000" style="height: 300px; overflow-y:scroll; resize:none;"></textarea>
                <div class="pagination justify-content-center mb-0">
                    <button type="button" onclick="goSubmit()" class="btn bg-light mt-3 mx-3 btn-lg" style="border: solid 1px rgb(224, 216, 216);">등&nbsp;&nbsp;&nbsp;록</button>
                    <button type="button" onclick="cancle()" class="btn bg-light mt-3 mx-3 btn-lg" style="border: solid 1px rgb(224, 216, 216);">취&nbsp;&nbsp;&nbsp;소</button>
                </div>
              </form>              
            </div>            
            <div class="col-2"></div>
          </div>
        </div>
      </div>
    </section>
    <script>
	    function cancle(){
	      $(location).attr("href", "insertCancle")
	    }
	    function goSubmit(){
	      $("#insertForm").submit(); //form태그의 action="insertContent"탐
	    }
  	</script>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>