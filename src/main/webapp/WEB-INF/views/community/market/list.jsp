<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

    <section>
      <div style="height: 250px;" class="bg-light d-flex align-items-center justify-content-center">
        <h1 class="">거래 게시판</h1>
      </div>
      <div class="container-fluid h-100 my-5">
        <div class="row">
          <div class="col-2"></div>
          <div class="col-8 row">
            <div class="minimenu col-12 mb-4 pb-3" style="border-bottom: solid 2px rgb(138,138,138);">
              <div class="dropdown">
                <button id="dropbtn" class="btn dropbtn" style="height:37.62px"><img src="${pageContext.request.contextPath}/resources/images/stick.png" style="height: 15px; width: 15px;" class="mr-2">카테고리</button><!--눌렀을때 효과-->
                <div class="dropdown-content">
                  <a class="dropdown-item" href="#">전체</a>
                  <a class="dropdown-item" href="#">장비</a>
                  <a class="dropdown-item" href="#">가구</a>
                  <a class="dropdown-item" href="#">소모품</a>
                  <a class="dropdown-item" href="#">기타</a>
                </div>
              </div>
              <div class="dropdown">
                <button id="dropbtn" class="btn dropbtn" style="height: 37.62px;">최신순 ▼</button><!--눌렀을때 효과-->
                <div class="dropdown-content">
                  <a class="dropdown-item" href="#">인기순</a>
                </div>
              </div>
            </div>
            
            <!-- 거래게시판 물품 목록 -->        
              <c:forEach var="marketboard" items="${marketBoards}">
	              <div class="col-3 float-left mb-5">
	                <div class="card">
	                  <div class="embed-responsive embed-responsive-4by3">
	                    <a href="marketDetail">
	                    	<img src="/community/market/getMarketImage?marketNo=${marketboard.marketNo}&type=nomal&img=0" class="card-img-top row-cols-1 embed-responsive-item"/>
	                    </a>
	                  </div>
	                  <div class="card-body" style="padding: 1rem;">
	                    <p style="margin-bottom: 0px;">${marketboard.marketTitle}</p>
	                    <p style="margin-bottom: 7px; font-weight: bold;"><span>${marketboard.marketPrice}</span>원</p>                 
 	                    <div class="float-right recommentCount">
 	                    <!-- <img id="interImg${marketboard.marketNo}" src="/resources/images/interestBefore.png" width="16px" class="interImg"> -->
	                    	<span>관심 </span><span> ${marketboard.marketLikeCount}</span>
	                    	<p>조회수 <span> ${marketboard.marketHitCount}</span></p>
	                    </div>
	                 
	                    <input id="marketWriter${marketboard.marketNo}" type="hidden" name="freeNo" value="${marketboard.marketWriter}"/>
	                    <p style="margin-bottom: 0px; font-size:15px;">${marketboard.userDto.userNickname} </p>
	                    <p style="margin-bottom: 0px; font-size:15px;">
	                    	<fmt:formatDate value="${marketboard.marketRegistDate}" pattern="yyyy-MM-dd" />
	                    </p>
	                  </div>
	                </div>
	              </div>
              </c:forEach>  

            <!-- 글쓰기 버튼 -->
            <div class="col-12 d-flex align-content-end justify-content-end">
              <a href="insert" type="button" class="btn px-2 btn-secondary">글쓰기</a>
            </div>
            
            <!-- 페이지 & 검색 -->
            <div class="col-12 d-flex flex-column align-content-center justify-content-center">
				<!-- 페이지 처리 -->
                <div class="pt-3 my-3">
                  <ul class="pagination justify-content-center mb-0">
	               	<li class="page-item">
						<a class="page-link" href="list?pageNo=1">First</a>
					</li>
					<c:if test="${pager.groupNo>1}">
						<li class="page-item">
							<a class="page-link" href="list?pageNo=${pager.startPageNo-1}">Previous</a>
						</li>
					</c:if>
                    
                    <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}"><!-- 시작 페이지부터 마지막 페이지까지 반복 -->
						<c:if test="${pager.pageNo != i}">
							<li class="page-item">
								<a class="page-link" href="list?pageNo=${i}">${i}</a>
							</li>
						</c:if>
						<c:if test="${pager.pageNo == i}">
							<li class="page-item active">
								<a class="page-link" href="list?pageNo=${i}">${i}</a>
							</li>
						</c:if>
					</c:forEach>
					<c:if test="${pager.groupNo<pager.totalGroupNo}">
						<li class="page-item">
	                      <a class="page-link" href="list?pageNo=${pager.endPageNo+1}">Next</a>
	                    </li>
					</c:if>
					<li class="page-item">
	                	<a class="page-link" href="list?pageNo=${pager.totalPageNo}">Last</a>
	                </li>
                  </ul>
                </div>
              <form class="form-inline my-2 my-lg-0 justify-content-center">
                  <select name="searchType">
                    <option value="제목+내용" selected="select">제목+내용</option>
                    <option value="내용">내용</option>
                    <option value="제목">제목</option>
                    <option value="작성자">작성자</option>
                  </select>
                  <input
                    class="form-control"
                    type="text"
                    placeholder="검색어를 입력해 주세요."
                    aria-label="Search"
                    width="300"
                  />
                  <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                    검색
                  </button>
                </form>
            </div>
            </div>           
          <div class="col-2"></div>
        </div>
      </div>
    </section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>