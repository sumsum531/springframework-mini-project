<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lt1xd5ne5c"></script>
    <script>
        function showPopUp(a){
            var url;
            var name = "test";
            console.log(a);
            if(a.name === 'allImg'){
                url = "<%=request.getContextPath() %>/take/popUpImg";
            }else{
                url = "<%=request.getContextPath() %>/take/popUp360Img";
            }
            console.log(url);
            var option = "width = 900, height = 900, top = 100, left = 200, location = no"
            window.open(url, name, option);
        }
        
        $( document ).ready(function() {
        	hospitalLocation();
       	});

    </script>
    
    <section class="container-fluid">
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                <div>
                    <h2 class="mt-5 mb-5 text-center">매물 정보</h2>
                </div>
                <div>
                    <div class="col-12 row d-flex justify-content-center" style="padding-right: 0;">
                        <div class="col-6 d-flex flex-column row-cols-sm-1">
                            <img class="rounded" src="${pageContext.request.contextPath}/resources/images/hosImg1.jpg">
                        </div>
                        <div class="col-6 d-flex flex-column row-cols-sm-1">
                            <img class="rounded" src="${pageContext.request.contextPath}/resources/images/hosImg2.jpg">
                        </div>
                    </div>
                    <div class="mt-1 mr-4 p-2 float-right">
                            <span><a class="border rounded p-2" name="allImg" style="text-decoration: none; color:black; cursor: pointer;" onclick="showPopUp(this)">모든 사진 보기 →</a></span>
                            <span><a class="border rounded p-2" name="360Img" style="text-decoration: none; color:black; cursor: pointer;" onclick="showPopUp(this)">360도 사진 보기 →</a></span>
                    </div>
                </div>
                <div class="ml-2" style="margin-top: 100px;">
                    <div class="mt-5">
                        <span class="mt-5" style="font-size: 30px;">뉴욕플란트 치과</span>
                        <span class="mr-4 mt-2 float-right" style="font-size: 20px;">건물 번호 : 000001</span>
                    </div>
                    <div class="mt-1">
                        <span style="font-size: 23px;">작성자 : 냥냥</span>
                        <span class="mr-4 float-right" style="font-size: 20px;">작성 일자 : 2022.04.19</span>
                    </div>
                </div>

                <div class="mt-5 container-fluid">
                    <div class="row">
                        <div class="col-7">
                            <div class="mb-3 font-weight-bold" style="font-size: 23px;">
                                상세 정보
                            </div>
                            <hr/>
                            <div class="container-fluid p-0">
                                <div class="row">
                                    <div class="col-4">
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="font-weight-bold">인수</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="font-weight-bold">월세</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="font-weight-bold">관리비</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="font-weight-bold">주차</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="font-weight-bold">해당층</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="font-weight-bold">전용/공급 면적</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="font-weight-bold">엘리베이터</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="font-weight-bold">입주 가능일</span>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="ml-5">5400만원</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="ml-5">5400만원</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="ml-5">5400만원</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="ml-5">가능 (무료)</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="ml-5">6층/9층</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="ml-5">24.88/35.14</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="ml-5">있음</span>
                                        </div>
                                        <div class="mb-5" style="font-size: 20px;">
                                            <span class="ml-5">2022.04.24</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4 font-weight-bold" style="font-size: 23px;">
                                옵션
                            </div>
                            <div class="d-flex mb-2">
                                <span>
                                    <div class="border rounded p-3 mr-3 text-center" style="width: 120px; background-color: rgb(231, 231, 236);">
                                        <img src="${pageContext.request.contextPath}/resources/images/carImg.png" width="50px"/>
                                        <div class="mt-2">주차 가능</div>
                                    </div>
                                </span>
                                <span>
                                    <div class="border rounded p-3 mr-3 text-center" style="width: 120px; background-color: rgb(231, 231, 236);">
                                        <img src="${pageContext.request.contextPath}/resources/images/equipImg.png" width="42px"/>
                                        <div class="mt-2">장비 있음</div>
                                    </div>
                                </span>
                                <span>
                                    <div class="border rounded p-3 mr-3 text-center" style="width: 120px; background-color: rgb(231, 231, 236);">
                                        <img src="${pageContext.request.contextPath}/resources/images/elevatorImg.png" width="40px"/>
                                        <div class="mt-2">엘리베이터</div>
                                    </div>
                                </span>
                                <span>
                                    <div class="border rounded p-3 mr-3 text-center" style="width: 120px; background-color: rgb(231, 231, 236);">
                                        <img src="${pageContext.request.contextPath}/resources/images/restroomImg.png" width="47px"/>
                                        <div class="mt-2">화장실</div>
                                    </div>
                                </span>
                                <span>
                                    <div class="border rounded p-3 mr-3 text-center" style="width: 120px; background-color: rgb(231, 231, 236);">
                                        <img src="${pageContext.request.contextPath}/resources/images/cctvImg.png" width="52px"/>
                                        <div class="mt-2">엘리베이터</div>
                                    </div>
                                </span>
                            </div>
                            
                            <div class="mb-4 mt-5 font-weight-bold" style="font-size: 23px;">
                                상세 설명
                            </div>
                           	<textarea class="p-2 mb-5" style="border-radius: 10px; resize:none; width:100%; height: 300px; font-size: 20px;" maxlength="500" color: rgb(97, 97, 100); disabled="disabled">상세 설명칸 입니다!</textarea>
                            <div class="mb-4 font-weight-bold" style="font-size: 23px;">
                                지도 위치
                            </div>
                            <div>
                            	<div id="map" class="mr-4 mt-3" style="width:100%;height:400px; border: 1px solid rgb(192, 191, 191); padding: 50px;" onchange="getMarkers()"></div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div id="box" class="border shadow w-100 float-right">
                                <div class="border text-center p-1 m-2 mb-5" style="width: 130px;">
                                    건물번호 0001
                                </div>
                                <div class="ml-3">
                                    <div class="p-1 m-2">
                                        <h3>뉴욕플란트 치과</h3>
                                    </div>
                                    <div class="p-1 m-2">
                                        서울특별시 송파구 가락동 78
                                    </div>
                                    <div class="p-1 m-2">
                                        <span style="font-size: 23px;">인수</span>
                                        <span class="ml-5" style="font-size: 23px;"><span>5400만원</span></span>
                                    </div>
                                    <div class="p-1 m-2">
                                        <span style="font-size: 23px;">월세</span>
                                        <span class="ml-5" style="font-size: 23px;"><span>5400만원</span></span>
                                    </div>
                                    <div>

                                    </div>
                                    <div class="container-fluid mt-2">
                                        <div class="row">
                                            <div class="col-4 p-1 m-2 d-flex">
                                                <span><img src="${pageContext.request.contextPath}/resources/images/elevatorImg.png" width="37px" /></span>
                                                <span style="font-size: 23px; margin-top: 8px; margin-left: 15px;">6층</span>
                                            </div>
                                            <div class="col-5 p-1 m-2 d-flex">
                                                <span><img src="${pageContext.request.contextPath}/resources/images/areaImg.png" width="37px" /></span>
                                                <span style="font-size: 23px; margin-top: 8px; margin-left: 15px;">24.88㎡</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="container-fluid mt-2 mb-2">
                                        <div class="row">
                                            <div class="col-4 p-1 m-2 d-flex">
                                                <span><img src="${pageContext.request.contextPath}/resources/images/carImg1.png" width="37px" /></span>
                                                <span style="font-size: 23px; margin-left: 15px;">6층</span>
                                            </div>
                                            <div class="col-5 p-1 m-2 d-flex">
                                                <span><img src="${pageContext.request.contextPath}/resources/images/equipImg.png" width="35px" /></span>
                                                <span style="font-size: 23px; margin-left: 15px;">장비O</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="container-fluid mt-4 mb-4">
                                        <div class="row">
                                            <div class="col-7 p-1 m-2">
                                                <div onclick="openMsgForm()" class="border p-3 text-center" style="background-color: rgb(242, 101, 45); color: white; font-size: 30px; border-radius: 8px; cursor: pointer;">문의 하기</div>
                                            </div>
                                            <div class="col-4 p-1 m-2">
                                                <div class="d-flex border justify-content-center" style="cursor: pointer; border-radius: 8px;">
                                                	<div class="d-flex flex-column justify-content-center">
                                                		<img id="interestImg" src="${pageContext.request.contextPath}/resources/images/interestBtn2.png" width="30px" height="30px" class="mr-1"/>
                                                	</div>
                                                	<div id="interestText" onclick="interestBtnClick(this)" name="off" class="p-3" style="font-size: 30px; color: black;">4</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center mt-5 mb-4">
                    <button class="border rounded m-2 p-2" style="font-size: 25px; width: 130px;">수정</button>
                    <button class="border rounded m-2 p-2 btn-danger" style="font-size: 25px; width: 130px;">삭제</button>
                </div>
            </div>
            <div class="col-2"></div>
        </div>
    </section>
    <script>
    
    	function hospitalLocation(){
    		var lat = '37.494802';
    		var lon = '127.122287';
    		
    		var p = new naver.maps.LatLng(lat, lon);
            var mapOptions = {
                center: p,
                scaleControl: false,
                mapDataContorol:false,
                zoom: 17
            };
            map = new naver.maps.Map('map', mapOptions); // id와 option
            
            var markerOptions = {
                position: p.destinationPoint(90, 15),
                map: map,
                icon: {
                    content: '<img src="<c:url value="/resources/images/ballMascot.png"/>" alt="marker" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; max-width: none; max-height: none; -webkit-user-select: none; position: absolute; width: 60px; height: 65px; left: 0px; top: 0px;">',
                     size: new naver.maps.Size(35, 30),
                     origin: new naver.maps.Point(0, 0),
                     anchor: new naver.maps.Point(16, 32)
                 }
            };
            
            marker = new naver.maps.Marker(markerOptions);
    	}
    	
	    function openMsgForm(){
	        var url = "<%=request.getContextPath() %>/message";
	        var option = "width = 300, height = 350, top = 100, left = 200, location = no";
	        window.open(url, "message", option);
	    }
	    
	    function interestBtnClick(m) {
	    	var state = $(m).attr("name");
	    	if(state == "off"){
	    		var temp = $("#interestText").text();
		    	temp++;
	    		$("#interestText").html(temp);
	    		$("#interestText").attr("name", "on");
	    		$("#interestImg").attr("src", "${pageContext.request.contextPath}/resources/images/interestBtn1.png");
	    	}else{
	    		var temp = $("#interestText").text();
		    	temp--;
	    		$("#interestText").html(temp);
	    		$("#interestText").attr("name", "off");
	    		$("#interestImg").attr("src", "${pageContext.request.contextPath}/resources/images/interestBtn2.png");
	    	}
		}
    </script>

               				
<%@ include file="/WEB-INF/views/common/footer.jsp"%>