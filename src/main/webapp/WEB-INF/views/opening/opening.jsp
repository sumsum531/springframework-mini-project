<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<script>
	    $(function(){
	        getLocation();
	    });
	    function addActive(id){
	        var btn = document.getElementById(id);
	        btn.classList.toggle("active");
	    }
    </script>
    

<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
    	<div class="modal-content bg-light">
	    	<button type="button" class="close inline-block" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true" class="float-right mr-1" style="z-index:-123;">&times;</span>
	        </button>
    		<h3 class="text-center mb-3 bg-light">로드뷰 보기</h3>
    		<div id="pano" style="width: 99%; height: 490px; border-radius: 5px; margin:0 auto;" class="text-center"></div>
    	</div>
  	</div>
</div>
<section style="flex-grow:1;">
	<div class="container-fluid h-100 mt-5">
		<div class="row mb-5">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row ml-5">
				<h4>개원 장소 키워드 추천</h4>
				</div>
				<div class="row">
					<div class="col-6 mt-3">
							<div class="row d-flex justify-content-between flex-column" style="margin: 0 auto;">
								<table style="margin: 0 auto;">
									<tr>
										<td class="p-2">
											<div id="keyword1" class="btn btn-outline-dark w-100 m-1 searchBtn" onclick="addActive(this.id);">임플란트</div>
										</td>
										<td class="p-2">
											<div id="keyword2" class="btn btn-outline-dark w-100 m-1 searchBtn" onclick="addActive(this.id);">역세권</div>
										</td>
										<td class="p-2">
											<div id="keyword3" class="btn btn-outline-dark w-100 m-1 searchBtn" onclick="addActive(this.id);">소아치료전문</div>
										</td>
										<td class="p-2">
											<div id="keyword4" class="btn btn-outline-dark w-100 m-1 searchBtn" onclick="addActive(this.id);">노인치료전문</div>
										</td>
									</tr>
									<tr>
										<td class="p-2">
											<div id="keyword5" class="btn btn-outline-dark w-100 m-1 searchBtn" onclick="addActive(this.id);">교정전문</div>
										</td>
										<td class="p-2">
											<div id="keyword6" class="btn btn-outline-dark w-100 m-1 searchBtn" onclick="addActive(this.id);">턱관절교정</div>
										</td>
										<td class="p-2">
											<div id="keyword7" class="btn btn-outline-dark w-100 m-1 searchBtn" onclick="addActive(this.id);">사랑니발치</div>
										</td>
										<td class="p-2">
											<div id="keyword8" class="btn btn-outline-dark w-100 m-1 searchBtn" onclick="addActive(this.id);">편의시설</div>
										</td>
									</tr>
								</table>
							
								<div class="mr-5">
									<span class="text-dark pr-2 float-left ml-5">* 중복 선택이가능합니다.</span>
									<a href="#" class="float-right"><img src="${pageContext.request.contextPath}/resources/images/reset.png" width="40px" onclick="location.reload();" /> </a>
									<a href="javascript:keywordSearch();"class=" pr-4 float-right"><img src="${pageContext.request.contextPath}/resources/images/search.png" width="40px"/></a>
								</div>
							</div>
						<div class="row d-flex mt-5">
							<img src="/resources/images/mascot.png" width="120px" style="margin-top: 210px;" />
							<div class="ml-4 mr-3" style="width: 450px; height: 300px; border-radius: 15px;">
								<img src="/resources/images/messageBox.png" width="480px" height="300px" class="float-right ml-1" style="z-index: -100000" />
								<ul class="mt-3" id="msgBox" style="position: absolute;">
								</ul>
							</div>
						</div>
					</div>
					<div class="col-6 d-flex flex-column">
						<div id="map" style="width: 100%; height: 500px; border-radius: 8px;" class="mt-4 border">
							<a title="현재위치" onclick="moveMapCurrentLoc(event)" class="border rounded p-1 m-1 shadow" style="z-index: 10; position: absolute; top: 0; left: 0; background-color: white; cursor: pointer;">
								<img src="${pageContext.request.contextPath}/resources/images/location.png" width="40px" />
							</a>
						</div>
						<script>
                               
                                var markers = new Array();
                                var infoWindows = new Array();
                                var marker;
                                var cmarker;
                                var result;
                                var positions = new Array();
                                var juso = new Array();
                                var infoWindow;
                                var contentFlag = false;
                                
                                function getLocation() {
                                    if (navigator.geolocation) {
                                        navigator.geolocation.getCurrentPosition(showPosition);
                                    } else { 
                                        x.innerHTML = "Geolocation is not supported by this browser.";
                                    }
                                }
                                
                                function showPosition(position){
                                	lat = position.coords.latitude;
                                	lng = position.coords.longitude;
                                	
                                	var curPos = new naver.maps.LatLng(lat, lng);
                                	var mapOptions = {
                                			center: curPos,
                                			scaleControl: false,
                                			mapDataControl: false,
                                			zoom: 10,
                                	};
                                	
                                	map = new naver.maps.Map('map', mapOptions);
                                	
                                	var markerOptions = {
                                			position: curPos.destinationPoint(90, 15),
                                			map: map,
                                			icon: {
                                				content: '<img src="<c:url value="/resources/images/ballMascot.png"/>" alt="marker" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; max-width: none; max-height: none; -webkit-user-select: none; position: absolute; width: 60px; height: 65px; left: 0px; top: 0px;">',
                                				size: new naver.maps.Size(35, 30),
                                                origin: new naver.maps.Point(0, 0),
                                                anchor: new naver.maps.Point(16, 32),
                                			}
                                	};
                                	
                                	cmarker = new naver.maps.Marker(markerOptions);
                                	initMap();
                                }
                                
                                function initMap(){
                                	setTimeout(() => {
	                                	for(var i=0; i<positions.length; i++){
	                                	 	marker = new naver.maps.Marker({
	                                			map: map,
	                                			position: new naver.maps.LatLng(positions[i].lat, positions[i].lng),
	                                			icon: {
	                                				content: '<a onclick="innerInfo(\''+positions[i].keywordNo+'\');"><img src="<c:url value="/resources/images/hospitalMark.png"/>" alt="marker" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; max-width: none; max-height: none; -webkit-user-select: none; position: absolute; left: 0px; top: 0px;"></a>',
	                                                size: new naver.maps.Size(20, 27),
	                                                origin: new naver.maps.Point(0, 0),
	                                                anchor: new naver.maps.Point(16, 32),
	                                			}
	                                	 	});
	                                	 	infoWindow = new naver.maps.InfoWindow({
	                                            content: '<form method="get" action="/take/list"><div class="p-2 gotoTake" style="width:200px;"><div class="text-center w-100"><input type="hidden" value="' + positions[i].lat + '" name="latitude"/><input type="hidden" value="' + positions[i].lng+'" name="longitude"/><input type="submit" class="btn btn-sm btn-outline-dark w-100" style="background-color: rgb(242, 101, 45); color: white; text-decoration:none;" value="주변매물 보러가기" /></div></div></form>',
												
	                                	 	});
	                                	 	markers.push(marker);
	                                        infoWindows.push(infoWindow);
	                                	}
                                		for(var i=0, ii=markers.length; i<ii; i++) {
                                            naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i)); // 클릭한 마커 핸들러
                                        }
                                	}, 1000);
                               }

                                //지도위의 현재위치 버튼을 클릭하면 실행되는 함수로, 현재위치가 찍힌 마커로 지도가 이동한다.
                                function moveMapCurrentLoc(e){
                                    e.preventDefault();
                                    var curPosition = cmarker.position;
                                    var currentLoc = new naver.maps.LatLng(curPosition.y, curPosition.x);
                                    map.panTo(currentLoc);
                                }

                                function getClickHandler(seq){
                                	return function(e){
                                		var marker = markers[seq],
                                			infoWindow = infoWindows[seq];
                                		if(infoWindow.getMap()){
                                			contentFlag = false;
                                			infoWindow.close();
                                		}else {
                                			contentFlag = true;
                                            infoWindow.open(map, marker); // 표출
                                        }
                                	}
                                }
                                
                                function keywordSearch(){
                                	var elements = document.querySelectorAll("td > .active");
                                	var keywordlst = new Array();
                                    var keyword = new Object();
                                    var jsonObject;
                                    document.querySelector("#msgBox").innerHTML = "";
                                    for(var i=0; i<elements.length; i++){
                                    	keyword["value"+i] = elements[i].id;
                                    	jsonObject = JSON.stringify(keyword);
                                    } 
                                    callData(jsonObject);
                                }
                                
								function callData(keyword){
									var sendData = JSON.parse(keyword);
									var addr;
									document.getElementById("msgBox").innerHTML = '';
									
									var xhr = new XMLHttpRequest(); 
							        xhr.open("POST", "/opening/keyword", true);
							        xhr.setRequestHeader("Content-Type", "application/json");
							        xhr.send(keyword);
							        xhr.onreadystatechange = function() {
							        	if (xhr.readyState === 4) {
							            	if (xhr.status === 200) {
							            		const data = JSON.parse(xhr.responseText);
							            		positions = [];
		                                		for(var i=0; i<markers.length; i++){
		                                			markers[i].setMap(null);
		                                			infoWindows[i].setMap(null);
		                                		}
												setTimeout(() => {
													for(var i=0; i<data.keywordsLength; i++){
			                                			positions.push(
			                                				{
			                                					keywordNo: data.keywords[i].keyword_no,
			                                					lat: data.keywords[i].latitude, 
			                                					lng: data.keywords[i].longitude,
			                                				},
			                                			);
			                                		}	
												}, 1000);
		                                		initMap();
							            	}
							          	}
							        };
								}
								
								function innerInfo(kNo){
									var addr;
									document.getElementById("msgBox").innerHTML = '';
									var xhr = new XMLHttpRequest(); 

							        xhr.open("POST", "/opening/oneKeyword", true);
							        xhr.setRequestHeader("Content-Type", "application/json");
							        xhr.send(kNo);
							        
							        xhr.onreadystatechange = function() {
							        	if (xhr.readyState === 4) {
							            	if (xhr.status === 200) {
							            		const data = JSON.parse(xhr.responseText);
							            		naver.maps.Service.reverseGeocode({
		                                            location: new naver.maps.LatLng(data.latitude, data.longitude),
		                                        }, function(status, response) {
		                                            if (status !== naver.maps.Service.Status.OK) {
		                                                return alert('Something wrong!');
		                                            }
		                                            result = response.result; // 검색 결과의 컨테이너
		                                            items = result.items.address; // 검색 결과의 배열
		                                            addr = result.items[1].address;
		                                        });
												setTimeout(() => {
													var html = '';
													html += '<div class="ml-4 mt-3" style="max-width: 400px;">';
													html += '    <p>주소 : <b>' + addr + '</b></p>';
													if(data.keyword1 != null){
														html += '    <span>임플란트 - ' + data.keyword1 + '</span><br>';
													}
													if(data.keyword2 != null){
														html += '    <span>역세권 - ' + data.keyword2 + '</span><br>';
													}
													if(data.keyword3 != null){
														html += '    <span>소아치료전문 - ' + data.keyword3 + '</span><br>';
													}
													if(data.keyword4 != null){
														html += '    <span>노인치료전문 - ' + data.keyword4 + '</span><br>';
													}
													if(data.keyword5 != null){
														html += '    <span>교정전문 - ' + data.keyword5 + '</span><br>';
													}
													if(data.keyword6 != null){
														html += '    <span>턱관절교정 - ' + data.keyword6 + '</span><br>';
													}
													if(data.keyword7 != null){
														html += '    <span>사랑니발치 - ' + data.keyword7 + '</span><br>';
													}
													if(data.keyword8 != null){
														html += '    <span>편의시설 - ' + data.keyword8 + '</span><br>';
													}
													html += '<div class="mt-2"><sapn>주변시설 - '+data.current_use+'</span></div>';
													html += '<div class="mt-4"><button onclick="openPano(\''+data.latitude+'\','+'\''+data.longitude+'\');" type="button" style="background-color: rgb(242, 101, 45); color: white; text-decoration:none;" class="btn text-center" data-toggle="modal" data-target=".bd-example-modal-lg">로드뷰 보기</button></div>';
													html += '</div>';
													if(contentFlag == true){
														document.getElementById("msgBox").innerHTML = html;	
													} else {
														document.getElementById("msgBox").innerHTML = '';
													}
												}, 100)
							            	}
							          	}
							        };
								}
								
								function openPano(lat, lng){
									
									var pano = new naver.maps.Panorama(document.getElementById("pano"), {
									    size: new naver.maps.Size(790, 600),
									    position: new naver.maps.LatLng(lat, lng),
									    
									});
								}
                            </script>
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>