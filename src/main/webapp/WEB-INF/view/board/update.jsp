<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<form:form modelAttribute="board" action="update" name="f">
		<form:hidden path="board_num"/>
		<table>
			<tr>
				<td>작성자</td>
				<td>
					<form:input path="user_id" /> 
					<font color="red">
						<form:errors path="user_id" /> 
					</font>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<form:input path="board_title" /> 
					<font color="red">
						<form:errors path="board_title" />
					</font>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<form:textarea path="board_content" rows="15" cols="80" />
					<script>
					CKEDITOR.replace("board_content", {
						filebrowserImageUploadUrl : "imgupload"
					});
					</script> 
					<font color="red">
						<form:errors path="board_content" />
					</font>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="javascript:document.f.submit()">[게시글수정]</a>
				</td>
			</tr>
		</table>
	</form:form>


</body>
</html>