<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면</title>
</head>
<body>
<div class="container" style="margin-top:100px;">
	<h3><img src="${path}/image/bollpin.png" style="width:40px; height:40px;"> 시설 안내</h3>
	<div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
	  <div class="carousel-inner">
	    <div class="carousel-item active" data-bs-interval="3000" >
	      <img src="${path}/image/image1.jpg" class="d-block w-100" alt="..." style="height:500px;">
	    </div>
	    <div class="carousel-item" data-bs-interval="3000" >
	      <img src="${path}/image/image2.jpg" class="d-block w-100" alt="..." style="height:500px;">
	    </div>
 	    <div class="carousel-item" data-bs-interval="3000">
	      <img src="${path}/image/image4.jpg" class="d-block w-100" alt="..." style="height:500px;">
	    </div>
 	    <div class="carousel-item" data-bs-interval="3000">
	      <img src="${path}/image/image5.jpg" class="d-block w-100" alt="..." style="height:500px;">
	    </div>
 	    <div class="carousel-item" data-bs-interval="3000">
	      <img src="${path}/image/image3.jpg" class="d-block w-100" alt="..." style="height:500px;">
	    </div>
	  </div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	</div>	
	
	<hr>
	
	<div>
		<h3><img src="${path}/image/bollpin.png" style="width:40px; height:40px;"> 레인현황</h3>
	</div>
	
	<hr>
	
	<div>
		<h3><img src="${path}/image/bollpin.png" style="width:40px; height:40px;"> 오시는길</h3>
		<!-- 지도를 표시할 div 입니다 -->
		<div id="map" style="width:100%;height:350px;"></div>
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebdf41bcbf7f9f26d534e2bb8a0094ff"></script>
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.48450202986353, 126.81144938527626), // 지도의 중심좌표
		        level: 1 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(37.48433952425129, 126.81124627512985); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		</script>
	</div>
</div>
</body>
</html>