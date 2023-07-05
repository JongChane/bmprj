<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>건의사항 내역</title>
<style>
	table {
	  margin: 55px auto;
	  border-collapse: collapse; /* 여백 제거 */
	  width : 80%;
	}

	th{
		background-color : black;
		color : white;
		height :45px;
	}	
	td{
		text-align : center;
		padding : 20px;
		border-bottom : 1px solid black;
	}
	
</style>
</head>
<body>
<div class="container" style="margin-top:55px;">
	<div style="display : flex; justify-content : space-between;">
		<div style="flex-basis : 20%;">
		   <%@ include file="mypageSideBar2.jsp" %>
		</div>
		<div style="flex-basis : 80%;">
			<h2>건의 내역</h2>
			<table>
				<tr>
					<th style="width:10%">번호</th>
					<th style="width:40%">제목</th>
					<th style="width:20%">날짜</th>
					<th style="width:10%">답변상태</th>
				</tr>
				<tr>
					<td>1</td>
					<td>안녕하세요</td>
					<td>2023-07-05</td>
					<td>답변 대기</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>