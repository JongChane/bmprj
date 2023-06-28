<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
</head>
<body>
<form:form modelAttribute="board" action="write" name="f">
	<table>
		<tr>
			<td>제목</td>
			<td>
				<form:input path="board_title"/>
				<font color="red"><form:errors path="board_title"/></font>
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<form:textarea path="board_content"/>
				<font color="red"><form:errors path="board_content"/></font>
			</td>
		</tr>
		<script>CKEDITOR.replace("board_content",{filebrowserImageUploadUrl :  "imgupload" })</script>
		<tr>
			<td colspan="2">
				<input type="submit" value="글 등록">
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>