<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.form-select{
		width: 60%;
		height: 50px;
	}
	.form-control{
	width: 60%;
	height: 50px;
	background : white;
	}
	
</style>
    <title>날짜 선택</title>
    <link rel="stylesheet" type="text/css" href="reservation.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(function() {
	  $(".datepicker").datepicker({
	    onSelect: updateReservations,
	    dateFormat: "yy-mm-dd",
	    minDate: 0,
	    maxDate: "+2w",
	    monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	    dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"]
	  });
	 
	  // 레인 선택 radio 버튼 변경 이벤트 핸들러 추가
	  $("input[name='lane_num[]']").change(updateReservations);
	});

	function updateReservations() {
	  let date = $(".datepicker").datepicker('getDate');
	  let laneNumbers = [];
	  
	  $("input[name='lane_num[]']:checked").each(function() {
	    laneNumbers.push($(this).val());
	  });

	  // 기존에 disable된 시간 선택 radio 버튼을 다시 enable 상태로 바꿉니다.
	 var currentTime = new Date();

	 $(".ul_class li").each(function() {
		  var li = $(this);
		  var li_time = li.find('input').val().split(":");
		  var li_minutes = parseInt(li_time[0]) * 60 + parseInt(li_time[1]);

		  var selectedDate = new Date(date);
		  var currentDate = new Date();
		  currentDate.setHours(0,0,0,0);
		  
		  if (selectedDate.getTime() === currentDate.getTime() && li_minutes < currentTime.getHours() * 60 + currentTime.getMinutes()) {
		    li.find('input[type="radio"]').prop('disabled', true);
		  } else {
		    li.find('input[type="radio"]').prop('disabled', false);
		  }
		});
	 
	  // laneNumbers가 비어있으면 함수를 종료합니다.
	  if (laneNumbers.length === 0) {
	    return;
	  }

	  $.ajax({
	    url: 'checkReservations',
	    data: {
	      'date': $.datepicker.formatDate("yy-mm-dd", date),
	      'laneNumbers': laneNumbers
	    },
	    type: 'GET',
	    traditional: true,
	    dataType: 'json',
	    success: function(data) {
	      if (!data.reservations || data.reservations.length === 0) {
	        console.error("No reservation data received from server");
	        return;
	      }

	      data.reservations.forEach(function(reservation) {
	        var rv_start = reservation.rv_start;
	        var rv_end = reservation.rv_end;

	        var start_time = rv_start.split(":");
	        var end_time = rv_end.split(":");

	        var start_minutes = parseInt(start_time[0]) * 60 + parseInt(start_time[1]);
	        var end_minutes = parseInt(end_time[0]) * 60 + parseInt(end_time[1]);

	        $(".ul_class li").each(function() {
	          var li = $(this);
	          var li_time = li.find('input').val().split(":");
	          var li_minutes = parseInt(li_time[0]) * 60 + parseInt(li_time[1]);

	          if (li_minutes >= start_minutes && li_minutes < end_minutes) {
	            li.find('input[type="radio"]').prop('disabled', true);
	          }
	        });
	      });
	    },
	    error: function (xhr, ajaxOptions, thrownError) {
	      console.error("Error occurred while getting reservation data: ", thrownError);
	    }
	  });
	}
	  function validateForm() {
          var date = $("input[name='rv_date']").val();
          var game = $("select[name='rv_game']").val();
          var people = $("select[name='rv_people']").val();
          var memberId = $("select[name='memberCount']").val();
          var memberIdInputs = $("input[name='vi_id']");
          var lanes = $("input[name='lane_num[]']:checked").length;
          var startTime = $("input[name='rv_start']:checked:not(:disabled)").val();

          if (date === "" || game === "" || people === "" || memberId === "" || lanes === 0 || startTime === undefined || startTime===null) {
              if (date === "") {
                  alert("날짜를 선택하세요.");
              } else if (game === "") {
                  alert("게임 수를 선택하세요.");
              } else if (people === "") {
                  alert("인원을 선택하세요.");
              } else if (memberId === "") {
                  alert("회원 아이디를 적어도 한 개 이상 입력하세요.");
              } else if (lanes === 0) {
                  alert("레인을 선택하세요.");
              } else if (startTime === undefined) {
                  alert("시간을 선택하세요.");
              } else if (startTime === null) {
                  alert("시간을 선택하세요.");
              }
              return false;
          }
					
          if (parseInt(people) >= 4 && lanes < 2) {
              alert("4명 이상일 때는 최소 2개의 레인을 선택해야 합니다.");
              return false;
          }
          
          if (parseInt(memberId) > parseInt(people)) {
        	    alert("회원 수는 예약인원 수보다 클 수 없습니다.");
        	    return false;
        	}
          
          var validationMessages = $(".validation-message");
          for (var i = 0; i < validationMessages.length; i++) {
              var messageElement = $(validationMessages[i]);
              if (messageElement.text() !== "아이디 검증 완료") {
                  alert("올바른 회원 아이디를 입력하세요.");
                  return false;
              }
          }
          return true;
      }
</script>
</head>
<body>
    <form:form modelAttribute="reservation" action="checkout" method="post" onsubmit="return validateForm();">
    <input type="hidden" name="user_id" value="${sessionScope.login}">
   <div style="margin-top: 70px">
      <h1>예약날짜</h1>
          <input type="text" name="rv_date" class="datepicker form-control" readonly/>
   </div><!-- 예약날짜 -->
   <div>
      <h1>게임 수</h1>
      <select name="rv_game" class="form-select">
         <option value="3">3게임</option>
         <option value="4">4게임</option>
         <option value="5">5게임</option>
      </select>
   </div><!-- 게임 수 -->
   
   <div>
      <h1>인원선택</h1>
      <h5>4명 이상부터 레인을 두 개 선택할 수 있습니다.</h5>
      <select name="rv_people" id="personSelect" class="form-select">
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
   		<h1>회원 아이디 입력</h1>
   		<h5>방문 회원의 아이디를 입력하세요. 게임 종료 후 에버점수를 업데이트 합니다.</h5>
   		<select id="memberCount" name="memberCount" class="form-select">
				 <option value="">선택</option>
         <option value="1">1명</option>
         <option value="2">2명</option>
         <option value="3">3명</option>
         <option value="4">4명</option>
         <option value="5">5명</option>
         <option value="6">6명</option>
         <option value="7">7명</option>
         <option value="8">8명</option>
       </select>
       <table id="memberTable" ></table>
   </div><!-- 회원 점수등록 -->
   <script type="text/javascript">
   $(document).ready(function() {
       $("#memberCount").change(function() {
           var count = $(this).val();
           var formHtml = "";
           for (var i = 1; i <= count; i++) {
               formHtml += "<tr>";
               formHtml += "<td>회원 " + i + " ID:</td>";
               formHtml += "<td><input type='text' name='vi_id' class='vi-id'></td>";
               formHtml += "<td class='validation-message' style='color: red;'></td>";
               formHtml += "</tr>";
           }
           $("#memberTable").html(formHtml);
       });
       
       // vi_id 입력칸에 입력이 있을 때마다 AJAX 요청 실행
       $(document).on("blur", ".vi-id", function() {
           var user_id = $(this).val();
           var row = $(this).closest("tr");
           var messageElement = row.find(".validation-message");

           // AJAX 요청을 통해 회원 ID가 DB에 존재하는지 검증
           $.ajax({
               url: "checkUser",
               type: "POST",
               data: { user_id: user_id },
               success: function(response) {
                   if (response === "true") {
                       messageElement.text("아이디 검증 완료").css("color", "green");
                   } else {
                       messageElement.text("존재하지 않는 회원입니다").css("color", "red");
                   }
               },
               error: function(jqXHR, textStatus, errorThrown) {
               		console.log(user_id);
                   console.log("HTTP Status: " + jqXHR.status); // HTTP 상태 코드
                   console.log("Ajax Error: " + textStatus); // Ajax가 처리하는 에러 메시지
                   console.log("Error Thrown: " + errorThrown); // 서버에서 반환하는 오류 메시지
                   messageElement.text("검증에 실패했습니다");
               }
           });
       });
   });
   </script> 
   <div>
      <h1>레인선택</h1>
   <ul class="rain_ul">
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="1" >
         1번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="2">
         2번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="3">
         3번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="4">
         4번레인
      </label>
   </li>
   </ul>
   </div>
   <div>
   <ul class="rain_ul">
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="5">
         5번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="6">
         6번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="7">
         7번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="8">
         8번레인
      </label>
   </li>
   </ul>
   </div>
   <div>
   <ul class="rain_ul">
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="9">
         9번레인
      </label>
   </li>
   <li class="rain_li">
      <label>
         <input type="checkbox" name="lane_num[]" value="10">
         10번레인
      </label>
   </li>
</ul>
  <script>
  const rainItems = document.querySelectorAll('.rain_li');
  const personSelect = document.getElementById('personSelect');
  let selectedItems = [];
  
  rainItems.forEach(item => {
     item.addEventListener('click', function() {
    	    if (event.target.tagName === 'LABEL' || event.target.tagName === 'INPUT') {
    	        event.preventDefault();
    	      }
       if (parseInt(personSelect.value) >= 4) {
         // 선택된 li 태그의 색상 변경 (두 개 선택)
         if (selectedItems.length < 2) {
           this.classList.toggle('click');
           if (this.classList.contains('click')) {
             selectedItems.push(this);
           } else {
             selectedItems = selectedItems.filter(item => item !== this);
           }
         } else if (selectedItems.includes(this)) {
           this.classList.toggle('click');
           selectedItems = selectedItems.filter(item => item !== this);
         }
       } else {
         // 선택된 li 태그의 색상 변경 (한 개 선택)
         rainItems.forEach(item => item.classList.remove('click'));
         this.classList.add('click');
         selectedItems = [this];
       }

       // 라디오 버튼 체크
      	selectedItems.forEach(selectedItem => {
  			const checkboxInput = selectedItem.querySelector('input[type="checkbox"]');
  			checkboxInput.checked = true;
  			$(checkboxInput).change();
				});

       // 나머지 태그들의 라디오 버튼 체크 해제
       rainItems.forEach(item => {
         if (!selectedItems.includes(item)) {
           const radioInput = item.querySelector('input[type="checkbox"]');
           radioInput.checked = false;
         }
       });
     });
   });
  personSelect.addEventListener('change', function() {
     // 인원 선택 값 변경 시 레인 선택 초기화
     rainItems.forEach(item => {
        item.classList.remove('click');
        selectedItems = [];
        const checkboxInput = item.querySelector('input[type="checkbox"]');
        checkboxInput.checked = false;
     });
  });
   </script>
   </div><!-- 레인선택 --> 
   <div>
     <h1>예약시간</h1>
     <div class="1_div">
       <ul class="ul_class">
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="09:00" class="hidden-input">
               9:00 ~ 10:30
             </label>
         </li>
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="10:30" class="hidden-input">
               10:30 ~ 12:00 
           </label>
         </li>
         <li class="li_class">
           <label>
           	 <input type="radio" name="rv_start" value="12:00" class="hidden-input">
               12:00 ~ 13:30
           </label>
         </li>
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="13:30" class="hidden-input">
               13:30 ~ 15:00
           </label>
         </li>
       </ul>
     </div>
     <div class="2_div">
       <ul class="ul_class">
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="15:00" class="hidden-input">
               15:00 ~ 16:30
           </label>
         </li>
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="16:30" class="hidden-input">
               16:30 ~ 18:00
           </label>
         </li>
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="18:00" class="hidden-input">
               18:00 ~ 19:30
           </label>
         </li>
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="19:30" class="hidden-input">
               19:30 ~ 21:00
           </label>
         </li>         
       </ul>
     </div>
     <div class="3_div">
       <ul class="ul_class">
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="21:00" class="hidden-input">
              21:00 ~ 22:30
           </label>
         </li>
         <li class="li_class">
           <label>
             <input type="radio" name="rv_start" value="22:30" class="hidden-input">
              22:30 ~ 24:00
           </label>
         </li>
       </ul>
     </div>  
   <script>
    const liItems = document.querySelectorAll('.li_class');
   
      liItems.forEach(item => {
      item.addEventListener('click', function() {
        // 선택된 li 태그의 색상 변경
        liItems.forEach(item => item.classList.remove('click'));
        this.classList.add('click');
        
        // 라디오 버튼 체크
        const radioInput = this.querySelector('.hidden-input');
        radioInput.checked = true;
      });
    });  
  </script>   
   </div><!-- 예약시간 -->
   <div>
      <button type="button" onclick="window.history.back()" class="btn btn-outline-success">취소</button>
      <button type="submit" class="btn btn-outline-success">예약</button>
   </div>
</form:form>
</body>
</html>