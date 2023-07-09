<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 정보</title>
<style>
	.container {
	}
</style>
</head>
<body>
	<h3 class="mb-5 text-center">공지사항 정보</h3>
	<div class="container w-50">
		<table class="table table-bordered">
			<tr>
				<td class="w3-black">날짜</td>
				<td>2023-07-09</td>
			</tr>
			<tr>
				<td class="w3-black">제목</td>
				<td>테스트입니다.</td>
			</tr>
			<tr>
				<td class="w3-black">내용</td>
				<td><span>가나다라마바사아자차카타파하</span></td>
			</tr>
		</table>
	</div>
	
	
	<div class="text-center">
		<a href="noticeUpdate?notice_num=${notice.notice_num}" class="btn btn-outline-dark">수정</a>
		<a href="noticeUpdate?notice_num=${notice.notice_num}" class="btn btn-outline-dark">삭제</a>
	</div>
</body>
</html>