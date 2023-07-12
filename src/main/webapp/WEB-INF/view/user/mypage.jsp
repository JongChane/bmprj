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
      <div class="mypageInfo col-5" >
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
      	<div class="container col-7" id="barcontainer">
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

	document.addEventListener("DOMContentLoaded", function(event) {
	    barGraph('${user.user_id}');
	});

    // JavaScript 코드
function barGraph(id) {
    $.ajax({
        url: "${path}/ajax/graph1?id=" + id,
        success: function(data) {
            console.log(data);
            var labels = []; // 레이블을 담을 배열
            var scores = []; // 에버점수를 담을 배열

            // 데이터 개수를 최대 다섯개로 제한
            var limitedData = data.slice(0, 5);

            for (var i = 0; i < limitedData.length; i++) {
                var label = limitedData[i].rv_date + " " + limitedData[i].lane_num + "번레인";
                labels.push(label);
                scores.push(limitedData[i].vi_avg);
            }

            var ctx = document.getElementById("canvas2").getContext("2d");
            var myChart = new Chart(ctx, {
                type: "line",
                data: {
                    labels: labels, // 레이블로 설정
                    datasets: [{
                        label: "에버점수",
                        data: scores,
                        backgroundColor: [
                            "rgba(255, 0, 0, 0.5)", // 빨간색
                            "rgba(255, 165, 0, 0.5)", // 주황색
                            "rgba(255, 255, 0, 0.5)", // 노란색
                            "rgba(0, 128, 0, 0.5)", // 초록색
                            "rgba(0, 0, 255, 0.5)", // 파란색
                        ],
                        borderColor: [
                            "rgba(255, 0, 0, 1)", // 빨간색
                            "rgba(255, 165, 0, 1)", // 주황색
                            "rgba(255, 255, 0, 1)", // 노란색
                            "rgba(0, 128, 0, 1)", // 초록색
                            "rgba(0, 0, 255, 1)", // 파란색
                        ],
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