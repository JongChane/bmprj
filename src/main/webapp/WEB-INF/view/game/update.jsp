<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매치 수정</title>
<style>
	.w3-table {
		width : 60%;
		margin : 0 auto;
</style>
</head>
<body>
<h2>매치 수정</h2>
<hr>
<form:form modelAttribute="game" action="update" method="post">
	<input type="hidden" name="game_num" value="${game.game_num }">
  <table class="w3-table"  >
<tr>
	<td>
		작성자  <input class="form-control mt-1" type="text" name="user_id" value="${game.user_id}" readonly>
	</td>
</tr>
<tr>
	<td>
		제목 <form:input path="game_title" class="form-control mt-1" type="text" value="${game.game_title}" name="game_title"  maxlength="10"/>
		<font color="red">
               <form:errors path="game_title"/>
            </font>
	</td>
</tr>
<tr>
	<td>
		경기인원 
		<select class="form-select mt-1" name="game_max" style="height:40px;">
			 <option value="2">2명</option>
			 <option value="3">3명</option>
			 <option value="4">4명</option>
			 <option value="5">5명</option>
			 <option value="6">6명</option>
			 <option value="7">7명</option>
			 <option value="8">8명</option>
		</select>
		  <font color="red">
	               <form:errors path="game_max"/>
	            </font>
	</td>
</tr>
	<tr>
	<td>
		성별 
		  <select class="form-select mt-1" name="game_gender" style="height:40px;">
			  <option value="남성">남성</option>
			  <option value="여성">여성</option>
			  <option value="성별무관">성별무관</option>
		  </select>
		   <font color="red">
	               <form:errors path="game_gender"/>
	            </font>
	</td>
	</tr>


<tr>
	<td>
		평균에버리지 
		<form:input path="game_avg" class="form-control mt-1" type="text" value="${game.game_avg}" name="game_avg"/>
		 <font color="red">
               <form:errors path="game_avg"/>
            </font>
	</td>
</tr>
<tr>
	<td>
		나이제한 
		 <select class="form-select mt-1" name="game_age" style="height:40px;">
	       	<option value="10">10대</option>
		    <option value="20">20대</option>
			<option value="30">30대</option>
			<option value="40">40대</option>
			<option value="50">50대</option>
		 </select>
		  <font color="red">
	               <form:errors path="game_gender"/>
	            </font>
	</td>
</tr>
<tr>
	<td>
		경기날짜  
		<form:input path="game_date" class="form-control mt-1" value="${game_date}" type="date" name="game_date" id="game_date_input"/>
		<font color="red">
	               <form:errors path="game_date"/>
	            </font>
	</td>
</tr>
</table>
<table class="w3-table" >
<tr>
	<td>
		제한사항
	</td>
</tr>
<tr>
	<td>
		<form:textarea path="game_content" value="${game.game_content}" class="form-control mt-1" type="text" name="game_content"  maxlength="300"/>	
		  <font color="red">
               <form:errors path="game_content"/>
            </font>	
	</td>
</tr>

</table>

<div class="row mx-auto mt-5" style="width: 5%;">
   		<button type="submit" class="btn btn-success">수정</button>
   </div>
   <script>
    var today = new Date().toISOString().split("T")[0];
    document.getElementById("game_date_input").setAttribute("min", today);
</script>
</form:form>
</body>
</html>