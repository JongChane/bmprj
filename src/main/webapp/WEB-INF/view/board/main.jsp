<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<meta charset="UTF-8">
<title>메인화면</title> 
<style>
  .ul_mclass {
    margin: 8px 0 0;
    list-style: none;
    padding: 0;
    display: flex;
    justify-content: flex-start; /* 좌측 정렬로 수정 */
    width: 100%; /* 부모 요소에 꽉 차도록 너비 조정 */
  }

  .li_mclass {
    flex-basis: calc(100% / 10);
    height: 50px;
    background-color: #edfbdc;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #c8e1af;
    color: #333;
    cursor: pointer;
    margin-right: 3px;
  }

  .lane-btn {
    border: 2px solid green;
    border-radius: 5px;
    background-color: white;
    color: black;
    text-align: center;
    padding: 5px;
    font-size: 28px;
    font-weight: 600;
  }

  .lane-btn.click {
    background-color: #edfbdc;
  }

  .reserved {
    background-color: gray;
  }
  
  ul {
    display: flex;
    list-style: none;
    padding: 0;
    margin-top: 10px;
  }

  ul li {
    display: flex;
    align-items: center;
    margin-right: 20px;
    flex-direction: column;
    text-align: center;
  }

  ul li i {
    margin-bottom: 5px;
  }
  
  P{
  	color : #ad5c38 !important;
  	font-size : 26px;
  }
  
   #map {
    position: relative;
    z-index: 0;
  }
</style>


<script>
$(document).ready(function() {
	  $(".lane-btn").click(function() {
	    var laneNumbers = $(this).text();

	    $(".ul_mclass li").removeClass("reserved");
	    $(".lane-btn").removeClass("click");
	    $(this).addClass("click");

	    $.ajax({
	      url: '../reservation/getLaneStatus',
	      type: 'GET',
	      data: { 'laneNumbers': laneNumbers },
	      traditional: true,
	      dataType: 'json',
	      success: function(response) {
	        console.log(response);

	        $(".ul_mclass li").each(function() {
	          var li = $(this);
	          var li_time = li.find('input').val().split(":");
	          var li_minutes = parseInt(li_time[0]) * 60 + parseInt(li_time[1]);

	          var currentHour = new Date().getHours();
	          var currentMinute = new Date().getMinutes();
	          var currentMinutes = currentHour * 60 + currentMinute;

	          if (currentMinutes >= li_minutes) {
	            li.addClass("reserved");
	          }

	          response.reservations.forEach(function(reservation) {
	            var rv_start = reservation.rv_start;
	            var rv_end = reservation.rv_end;

	            var start_time = rv_start.split(":");
	            var end_time = rv_end.split(":");

	            var start_minutes = parseInt(start_time[0]) * 60 + parseInt(start_time[1]);
	            var end_minutes = parseInt(end_time[0]) * 60 + parseInt(end_time[1]);

	            if (li_minutes >= start_minutes && li_minutes < end_minutes) {
	              li.addClass("reserved");
	            }
	          });
	        });
	      }
	    });
	  });
	});

</script>

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
<div style="max-width: 50%; display: flex; justify-content: space-between;">
  <button class="lane-btn" style="width: 8%;">1</button>
  <button class="lane-btn" style="width: 8%;">2</button>
  <button class="lane-btn" style="width: 8%;">3</button>
  <button class="lane-btn" style="width: 8%;">4</button>
  <button class="lane-btn" style="width: 8%;">5</button>
  <button class="lane-btn" style="width: 8%;">6</button>
  <button class="lane-btn" style="width: 8%;">7</button>
  <button class="lane-btn" style="width: 8%;">8</button>
  <button class="lane-btn" style="width: 8%;">9</button>
  <button class="lane-btn" style="width: 8%;">10</button>
</div>
	<div>
     <div class="1_div">
       <ul class="ul_mclass">
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="09:00">
               9:00 ~ 10:30
             </label>
         </li>
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="10:30">
               10:30 ~ 12:00 
           </label>
         </li>
         <li class="li_mclass">
           <label>
           	 <input type="hidden" name="rv_start" value="12:00">
               12:00 ~ 13:30
           </label>
         </li>
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="13:30">
               13:30 ~ 15:00
           </label>
         </li>
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="15:00">
               15:00 ~ 16:30
           </label>
         </li>
       </ul>
     </div>
     <div class="2_div">
       <ul class="ul_mclass">
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="16:30">
               16:30 ~ 18:00
           </label>
         </li>
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="18:00">
               18:00 ~ 19:30
           </label>
         </li>
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="19:30">
               19:30 ~ 21:00
           </label>
         </li>
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="21:00">
               21:00 ~ 22:30
           </label>
         </li>    
         <li class="li_mclass">
           <label>
             <input type="hidden" name="rv_start" value="22:30">
              22:30 ~ 24:00
           </label>
         </li>                
       </ul>
     </div>
  </div>
  </div>  
	<hr>
	
	<div>
		<h3><img src="${path}/image/bollpin.png" style="width:40px; height:40px;"> 오시는길</h3>
		<!-- 지도를 표시할 div 입니다 -->
		<div id="map" style="width:100%;height:350px;"></div>
		<div style="margin :30px 30px;">
			<h5>볼링매니아</h5>
			<p>서울특별시 금천구 가산디지털2로 95 KM타워 3층 305호 볼링매니아</p>
		</div>
		
		<hr>
		
		<div style="margin :30px 30px;">
			<i class="fa-solid fa-phone"></i>
			<span style="margin-right:50px;">전화번호</span>
			<span>02-123-4567</span>
		</div>
		
		<hr>
		
		<div style="margin :30px 30px;">
			<i class="fa-solid fa-clock"></i>
			<span style="margin-right:50px;">이용시간</span>
			<span>매일 09:00 ~ 24:00</span>
		</div>
		
		<hr>
		
		<div style="margin: 30px 30px;">
		  <div style="display: flex; align-items: center;">
		    <i class="fa-solid fa-circle-info"></i>
		    <span style="margin-left: 5px; margin-right:50px;" >이용안내</span>
		  <ul>
		    <li>
		      <i class="fa-regular fa-calendar-check fa-2xl" style="margin-bottom : 20px;"></i>
		      <span>예약</span>		
		    </li>
		    <li>
		      <i class="fa-solid fa-square-parking fa-2xl" style="margin-bottom : 20px;"></i>
		      <span>주차</span>					
		    </li>
		    <li>
		      <i class="fa-solid fa-wifi fa-2xl" style="margin-bottom : 20px;"></i>
		      <span>무선 인터넷</span>			
		    </li>
		    <li>
		      <i class="fa-solid fa-restroom fa-2xl" style="margin-bottom : 20px;"></i>
		      <span>남/녀화장실 구분</span>			
		    </li>
		  </ul>
		  </div>
		</div>
		
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebdf41bcbf7f9f26d534e2bb8a0094ff"></script>
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.47635390347122, 126.87985893857008), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(37.4764508278954, 126.87990121117487); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		</script>
</div>
</body>
</html>