<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 마이페이지</title>
<style>
.mypage_table  {
   width:400px;
   margin-top : 30px;
}
</style>
</head>
<body>
<div class="container" style="margin-top : 55px;">
   <div style="display : flex; justify-content : space-between;">   
      <div style="flex-basis : 20%;">
         <%@ include file="mypageSideBar2.jsp" %>
      </div>
      
      <div style="flex-basis : 80%;" >
      <h1 class="mb-3">회원정보</h1>
      <div class="row">
      <div class="mypageInfo col-6" >
         <table class="mypage_table w3-table w3-bordered">
              <tr>
                  <td>아이디</td>
                  <td>${user.user_id}</td>
               </tr>
               <tr>
                  <td>이름</td>
                     <td>${user.user_name}</td>
               </tr>   
               <tr>
                  <td>성별</td>
                  <td>${user.user_gender}</td>
               </tr>   
               <tr>
                  <td>전화번호</td>
                  <td>${user.user_tel}</td>
               </tr>   
               <tr>
                  <td>이메일</td>
                  <td>${user.user_email}</td>
               </tr>   
               <tr>
                  <td>에버점수</td>
                  <td>${user.user_avg}</td>
               </tr>            
         </table>
      </div>
      	<div class="container col-6" id="barcontainer">
      		<input type="radio" name="barline" onchange="barGraph('${user.user_id}')">
      		<canvas id="canvas2" style="width:100%"></canvas>
      	</div>
      	</div>
      </div>
   </div>   
</div>   
<script type="text/javascript"
src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js">
</script>
<script>
    // JavaScript 코드
    function barGraph(id) {
        $.ajax({
            url: "${path}/ajax/graph1?id=" + id,
            success: function(data) {
                var dates = []; // 예약 날짜를 담을 배열
                var scores = []; // 에버점수를 담을 배열
				console.log(data);
                for (var i = 0; i < data.length; i++) {
                    dates.push(data[i].rv_date);
                    scores.push(data[i].vi_avg);
                }

                // 막대그래프 생성 코드 작성
                var ctx = document.getElementById("canvas2").getContext("2d");
                var myChart = new Chart(ctx, {
                    type: "bar",
                    data: {
                        labels: dates,
                        datasets: [{
                            label: "에버점수",
                            data: scores,
                            backgroundColor: "rgba(54, 162, 235, 0.5)", // 막대 색상 설정
                            borderColor: "rgba(54, 162, 235, 1)", // 막대 테두리 색상 설정
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            },
            error: function(e) {
                console.error("서버 오류: " + e.status);
            }
        });
    }
</script>

</body>
</html>