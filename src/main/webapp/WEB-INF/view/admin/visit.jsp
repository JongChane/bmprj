<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 점수등록</title>
<style>
   .noline { text-decoration: none;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
	  $('input[name="vi_total"]').on('input', function() {
	    var totalScore = $(this).val();
	    var gameNumber = $(this).closest('tr').find('input[name="vi_game"]').val();
	    var maxScore = gameNumber * 300; // vi_game이 1이면 최대값 300, vi_game이 2이면 최대값 600, ...

	    // 음수나 0 또는 최대값을 초과한 경우 알림 창 표시하고 입력칸 초기화
	    if (totalScore <= 0 || totalScore > maxScore) {
	      alert('총점을 올바르게 입력하세요. 최대값: ' + maxScore);
	      $(this).val(''); // 입력칸 초기화
	      return; // 함수 실행 중지
	    }
	    
	    var averageScore = Math.round(totalScore / gameNumber);
	    $(this).closest('tr').find('input[name="vi_avg"]').val(averageScore);
	  });
	});

</script>
</head>
<body>
<h2>점수등록</h2>
<form method="post" action="visit">
	<input type="hidden" name="rv_num" value="${param.rv_num}">
	<table class="w3-table-all">
  	<tr>
  		<th>예약번호</th>
  		<th>아이디</th>
  		<th>총점</th>
  		<th>게임수</th>
  		<th>에버점수</th>
  	</tr>
  	<c:forEach items="${visitList}" var="visit">
  	<tr>
  		<td>${visit.rv_num}</td>
  		<td><input type="hidden" name="vi_id" value="${visit.vi_id}">${visit.vi_id}</td>
  		<td><input type="number" name="vi_total"></td>
  		<td><input type="number" name="vi_game" value="${visit.vi_game}" readonly></td>
  		<td><input type="text" name="vi_avg" readonly></td>				
  	</tr>
  	</c:forEach>
   </table>
   <button type="submit">점수등록</button>
</form>
</body>
</html>
