<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

    <section>
      <div style="height: 250px;" class="bg-light d-flex align-items-center justify-content-center">
        <h1 class="">자유 게시판</h1>
      </div>
      <div class="container-fluid h-100">
        <div class="row">
          <div class="col-2"></div>
          <div class="col-8">
            <!-- 게시판 시작 -->
            <div class="row mt-5">
              <div class="col-lg-12">
                <div class="table-responsive">
                  <table
                    class="table project-table table-centered table-nowrap table-hover" 
                  >
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col" style="text-align: center;">제목</th>
                        <th scope="col" class="px-0">댓글수</th>
                        <th scope="col">작성자</th>
                        <th scope="col" style="text-align: center;">작성일</th>
                        <th scope="col">조회</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr style="cursor: pointer">
                        <th scope="row">100</th>
                        <td><a class="text-dark" href="boardDetail">제목입니다.</a></td>
                        <td>3</td>
                        <td>냥냥</td>
                        <td style="text-align: center;">2022.04.12</td>
                        <td>10</td>
                      </tr>
                      <tr>
                        <th scope="row">99</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                      <tr>
                        <th scope="row">98</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                      <tr>
                        <th scope="row">97</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                      <tr>
                        <th scope="row">96</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                      <tr>
                        <th scope="row">95</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                      <tr>
                        <th scope="row">94</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                      <tr>
                        <th scope="row">93</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                      <tr>
                        <th scope="row">92</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                      <tr>
                        <th scope="row">91</th>
                        <td>New admin Design</td>
                        <td>3</td>
                        <td>닉네임</td>
                        <td  style="text-align: center;">2022.02.12</td>
                        <td>13</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <!-- end project-list -->
                
                <div class="float-right">
                    <a href="insert" type="button" class="btn px-2 btn-secondary">글쓰기</a>
                </div>
                
				<!-- 페이지 처리 -->
                <div class="pt-3 my-3">
                  <ul class="pagination justify-content-center mb-0">
                    <li class="page-item disabled">
                      <a
                        class="page-link"
                        href="#"
                        tabindex="-1"
                        aria-disabled="true"
                        >Previous</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">11</a>
                    </li>
                    <li class="page-item active">
                      <a class="page-link" href="#">12</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">13</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">14</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">15</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">16</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">17</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">18</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">19</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">20</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">Next</a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div class="col-2"></div>
        </div>
      </div>
    </section>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>