<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매치 리스트</title>
</head>
<body>
<h1>매치 목록</h1>
<form:form >
<table class="w3-table w3-border">
<tr>
	<td>
		제목 : ${game_title}
	</td>
	<td>
		작성자 : ${user_id}
	</td>
</tr>
<tr>
	<td>
		경기인원 : ${game_max}
	</td>
	<td>
		성별 : ${game_gender}
	</td>
</tr>

<tr>
	<td>
		평균에버리지 : ${game_avg}
	</td>
	<td>
		나이제한 : ${game_age}
	</td>
</tr>
<tr >
	<td>
		경기날짜 : ${game_date}
	</td>
	
</tr>
</table>
</form:form>
<input type="button" value="매치등록하기" onclick="location.href='write'">
</body>
</html>