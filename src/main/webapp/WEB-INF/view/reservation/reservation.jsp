<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
    <title>날짜 선택</title>
    <link rel="stylesheet" type="text/css" href="reservation.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(function() {
	  $(".datepicker").datepicker({
	    dateFormat: "yy-mm-dd", // 날짜 형식 설정 (년-월-일)
	    minDate: 0, // 오늘 날짜 이전은 선택할 수 없음
	    maxDate: "+2w", // 오늘 날짜 기준 2주 뒤까지 선택 가능
	    monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	    dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"]
	  });
	});
</script>
</head>
<body>
	 <form:form modelAttribute="reservation" action="reservation" method="post">
	 <input type="hidden" name="user_id" value="${sessionScope.login}">
   <div>
      <h1>예약날짜</h1>
   		 <input type="text" name="rv_date" class="datepicker"/>
   </div><!-- 예약날짜 -->
   
   <div>
         <h1>예약시간</h1>
      <div class="am_div">
      <p>오전</p>
      <ul class="ul_class">
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="09:00" class="hidden-input">
               09:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="10:00" class="hidden-input">
               10:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="11:00" class="hidden-input">
               11:00
            </label>
         </li>
      </ul>
   </div>
   <div class="pm_div">
      <p>오후</p>
      <ul class="ul_class">
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="12:00" class="hidden-input">
               12:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="13:00" class="hidden-input">
               13:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="14:00" class="hidden-input">
               14:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="15:00" class="hidden-input">
               15:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="16:00" class="hidden-input">
               16:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="17:00" class="hidden-input">
               17:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="18:00" class="hidden-input">
               18:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="19:00" class="hidden-input">
               19:00
            </label>
         </li>
         <li class="li_class">
            <label>
               <input type="radio" name="rv_start" value="20:00" class="hidden-input">
               20:00
            </label>
         </li>
      </ul>
      <script>
    const liItems = document.querySelectorAll('.li_class');
   
		liItems.forEach(item => {
      item.addEventListener('click', function() {
        // 선택된 li 태그의 색상 변경
        liItems.forEach(item => item.classList.remove('click'));
        this.classList.add('click');
      });
    });
		
  </script>   
   </div>
   </div><!-- 예약시간 -->
   
   <div>
      <h1>게임 수</h1>
      <select name="rv_game">
         <option value="1">1게임</option>
         <option value="2">2게임</option>
         <option value="3">3게임</option>
         <option value="4">4게임</option>
         <option value="5">5게임</option>
      </select>
   </div><!-- 게임 수 -->
   
   <div>
      <h1>인원선택</h1>
      <select name="rv_people">
         <option value="1">1명</option>
         <option value="2">2명</option>
         <option value="3">3명</option>
         <option value="4">4명</option>
         <option value="5">5명</option>
         <option value="6">6명</option>
         <option value="7">7명</option>
         <option value="8">8명</option>
      </select>
   </div><!-- 인원선택 -->
   <div>
      <h1>레인선택</h1>
     <ul class="rain_ul">
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="1">
         1번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="2">
         2번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="3">
         3번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="4">
         4번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="5">
         5번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="6">
         6번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="7">
         7번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="8">
         8번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="9">
         9번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="radio" name="lane_num" value="10">
         10번레인
      </label>
   </li>
</ul>
  <script>
    const liItems2 = document.querySelectorAll('.rain_li');
   
		liItems2.forEach(item => {
      item.addEventListener('click', function() {
        // 선택된 li 태그의 색상 변경
        liItems2.forEach(item => item.classList.remove('click'));
        this.classList.add('click');
      });
    });
		
  </script>
   </div><!-- 레인선택 -->
   <div>
      <button>취소</button>
      <button type="submit">예약</button>
   </div>
</form:form>
    
    
</body>
</html>
