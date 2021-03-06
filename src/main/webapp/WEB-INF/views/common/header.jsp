<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en" style="height: 100%;">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>START:DEN</title>
    <link rel="icon" type="image/png"  href="${pageContext.request.contextPath}/resources/images/bigMascot.png"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pannellum@2.5.6/build/pannellum.css" />
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/pannellum@2.5.6/build/pannellum.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/board.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lt1xd5ne5c&submodules=geocoder"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lt1xd5ne5c&submodules=panorama"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
	<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <style>
        @font-face {
            src : url("${pageContext.request.contextPath}/resources/font/EliceDigitalBaeum_TTF/EliceDigitalBaeum_Regular.ttf"); 
            font-family: "elice";
        }
        *{
             font-family: "elice";
         }
        .dropdown:hover>.dropdown-menu {
	        display: block;
	    }
	    
	    #panorama {
        height: 400px;
        z-index: 1000;
        -moz-transform-origin: top left;
        -webkit-transform-origin: top left;
        -ms-transform-origin: top left;
        transform-origin: top left;
      	}
      	.btn-top {position: fixed; right: 15px; bottom: 100px; border-radius: 50%; overflow: hidden; z-index: 10;transition: all 0.5s; display: none;}
		.btn-top.on {display: block;}
		.btn-top.active {bottom: 235px;}
		.btn-top>a {display: block; width: 50px; height: 50px; text-indent: -9999px; background: url("${pageContext.request.contextPath}/resources/images/totop.png") 50% no-repeat;}
		.btn-top .progress1 {
		    width: 100%;
		    height: 100%;
		    position: absolute;
		    left: 0;
		    top: 0;
		    /*box-shadow: inset 0 0 0 2px #eee;*/
		    border-radius: 50%;
		}
		
		.btn-top .progress1>span {
		    width: 50%;
		    height: 100%;
		    overflow: hidden;
		    position: absolute;
		    top: 0;
		    z-index: 1;
		}
		
		.btn-top .progress1 .left {
		    left: 0;
		}
		
		.btn-top .progress1 .progress-bar1 {
		    width: 100%;
		    height: 100%;
		    border: 2px solid #F58345;
		    position: absolute;
		    top: 0;
		    box-sizing: border-box;
		}
		
		.btn-top .progress1 .left .progress-bar1 {
		    left: 100%;
		    border-top-right-radius: 40px;
		    border-bottom-right-radius: 40px;
		    border-left: 0;
		    -webkit-transform-origin: center left;
		    transform-origin: center left;
		}
		
		.btn-top .progress1 .right {
		    right: 0;
		}
		
		.btn-top .progress1 .right .progress-bar1 {
		    left: -100%;
		    border-top-left-radius: 40px;
		    border-bottom-left-radius: 40px;
		    border-right: 0;
		}
		
		.btn-top .progress1 .right .progress-bar1 {
		    -webkit-transform-origin: center right;
		    transform-origin: center right;
		}
		
		::-webkit-scrollbar {
		    width: 13px;  /* ??????????????? ?????? */
		}
		
		::-webkit-scrollbar-thumb {
		    height: 17%; /* ??????????????? ?????? */
		    background: #adb5bd; /* ??????????????? ?????? */
		    
		    border-radius: 3px;
		}
		
		::-webkit-scrollbar-track {
		    background: #e9ecef;  /*???????????? ??? ?????? ??????*/
		}
		.nav-link.active[aria-selected="true"]{
	         border-color: gray; 
	         border-bottom-color: transparent;
	      }
	      .nav-link[aria-selected="false"]{
	         border-bottom-color: gray;
	      }
		
		      	
    </style> 
</head>
<body style="height: 100%; display: flex; flex-direction: column;">
    <header>
        <nav class="navbar navbar-light" style="border-bottom: 1px solid rgb(242, 101, 34); margin-top:15px;">
            <a class="navbar-brand" href="/">
              <img src="${pageContext.request.contextPath}/resources/images/startden.png"/>
            </a>
            <a href="${pageContext.request.contextPath}/opening/opening" class="text-dark h3 font-weight-bold" style="text-decoration: none;">??????</a>
            <a href="${pageContext.request.contextPath}/take/list" class="text-dark h3 font-weight-bold" style="text-decoration: none;">??????</a>
            <a href="${pageContext.request.contextPath}/interior/example" class="text-dark h3 font-weight-bold" style="text-decoration: none;">????????????</a>
            <div class="dropdown">
	             <a class="text-dark h3 dropdown font-weight-bold" data-toggle="dropdown" style="text-decoration: none;">????????????</a>
	             <div class="dropdown-menu mr-5" style="z-index: 1001;">
	                 <a class="dropdown-item" href="${pageContext.request.contextPath}/community/notice/list">????????????</a>
	                 <a class="dropdown-item" href="${pageContext.request.contextPath}/community/board/list">???????????????</a>
	                 <a class="dropdown-item" href="${pageContext.request.contextPath}/community/market/list">???????????????</a>
	             </div>
            </div>
            <div class="myinfo">
	            <sec:authorize access="isAnonymous()">
	            	<span class="logout pr-3 font-weight-bold">
	            			<a href = "${pageContext.request.contextPath}/index/loginForm" class ="text-dark" style="text-decoration: none;">?????????</a> 
	                </span>
	            </sec:authorize>
            	<sec:authorize access="isAuthenticated()">
            		<form id="logoutForm" method="post" action="${pageContext.request.contextPath}/logout">
		            	<span class="logout pr-3 font-weight-bold">
		            		<a onClick="logout1()" type = "submit" class ="text-dark" style="">????????????</a> 
		                </span>
		                <span class="mypage pr-3 font-weight-bold">
	            			<a href="${pageContext.request.contextPath}/mypage/modify" class="text-dark" style="text-decoration: none;">???????????????</a>
	                	</span>
	                </form>
	                <script>
	                	function logout1(){
	                		document.getElementById('logoutForm').submit();
	                	}
	                </script>
	                
            	</sec:authorize>
               
                <%-- <span id="alarm" class="btn area" onclick="visibleAlarmContent()">
                	<c:if test="${sessionUserId != null}">
            			<img id="alarmImg" class="pb-1 area" src="${pageContext.request.contextPath}/resources/images/alarmUse.png" width="35px"/>
            		</c:if>
                </span>
            </div>
            <div id="alarmContent" class="position-absolute" style="right:10px; top:70px; visibility:hidden;" onclick="visibleAlarmContent()">
            	<img src="${pageContext.request.contextPath}/resources/images/alramContent.png" width="300px"/>
            	<div class="d-flex flex-column position-relative" style="bottom:150px; left:10px;">
	            	<a href="#">???? ????????? 5??? ?????????????????????.</a>
	            	<a href="#">???? '?????? ??????..'???????????? ????????? ????????????</a>
	            	<a href="#">???? '?????? ?????????..'???????????? ????????? ????????????</a>
            	</div>
          	</div> --%>
          </nav>
    </header>
	<script>
		//????????? ?????????
		function visibleAlarmContent(){
			$("#alarmContent").css("visibility","visible");
		}
	
		//????????? ????????????
	  	$('body').click(function(e){
			if(!$(e.target).hasClass("area")){
				$("#alarmContent").css("visibility","hidden");
				$("#alarmImg").attr("src","${pageContext.request.contextPath}/resources/images/alarmNo.png");
			}
		});
	</script>