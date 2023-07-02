<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        $("#Date").datepicker({
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
	 <form action="reservation" method="post">
   <div>
      <h1>예약날짜</h1>
   		 <input type="text" id="Date">
   </div><!-- 예약날짜 -->
   
   <div>
      <h1>예약시간</h1>
         <div class="am_div">
      <p>오전</p>
      <ul class="am_ul">
         <li class="am_li">09:00</li>
         <li class="am_li">10:00</li>
         <li class="am_li">11:00</li>
      </ul>
   </div>
   <div class="pm_div">
      <p>오후</p>
      <ul class="pm_ul">
         <li class="pm_li">12:00</li>
         <li class="pm_li">13:00</li>
         <li class="pm_li">14:00</li>
         <li class="pm_li">15:00</li>
         <li class="pm_li">16:00</li>
         <li class="pm_li">17:00</li>
         <li class="pm_li">18:00</li>
         <li class="pm_li">19:00</li>
         <li class="pm_li">20:00</li>
      </ul>
<script>
    // JavaScript 코드
    document.addEventListener("DOMContentLoaded", function() {
      var liElements = document.querySelectorAll("li");

      // 각 li 요소에 클릭 이벤트 리스너를 추가합니다.
      for (var i = 0; i < liElements.length; i++) {
        liElements[i].addEventListener("click", function() {
          // 선택된 li 요소에 .selected 클래스를 추가합니다.
          this.classList.toggle("click");

          // 다른 li 요소의 .selected 클래스를 제거합니다.
          var siblings = this.parentElement.children;
          for (var j = 0; j < siblings.length; j++) {
            if (siblings[j] !== this) {
              siblings[j].classList.remove("click");
            }
          }
        });
      }
    });
  </script>
      
   </div>
   </div><!-- 예약시간 -->
   
   <div>
      <h1>게임 수</h1>
      <select>
         <option>1게임</option>
         <option>2게임</option>
         <option>3게임</option>
         <option>4게임</option>
         <option>5게임</option>
      </select>
   </div><!-- 게임 수 -->
   
   <div>
      <h1>인원선택</h1>
      <select>
         <option>1명</option>
         <option>2명</option>
         <option>3명</option>
         <option>4명</option>
         <option>5명</option>
         <option>6명</option>
         <option>7명</option>
         <option>8명</option>
      </select>
   </div><!-- 인원선택 -->
   <div>
      <h1>레인선택</h1>
      <ul class="rain_ul">
         <li class="rain_li">1번레인</li>
         <li class="rain_li">2번레인</li>
         <li class="rain_li">3번레인</li>
         <li class="rain_li">4번레인</li>
         <li class="rain_li">5번레인</li>
         <li class="rain_li">6번레인</li>
         <li class="rain_li">7번레인</li>
         <li class="rain_li">8번레인</li>
         <li class="rain_li">9번레인</li>
         <li class="rain_li">10번레인</li>
      </ul>
   </div><!-- 레인선택 -->
   <div>
      <button>취소</button>
      <button type="submit">예약</button>
   </div>
</form>
    
    
</body>
</html>
