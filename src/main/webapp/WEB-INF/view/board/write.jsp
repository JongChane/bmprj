<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
   <style>
      h2 {
         margin-bottom: 20px;
      }

      table {
         width: 100%;
      }

      td {
         padding: 10px;
      }

      input[type="text"] {
         width: 50%;
         padding: 5px;
         border: 1px solid #ddd;
         border-radius: 3px;
      }

      input[type="submit"] {
         padding: 5px 10px;
         background-color: #4CAF50;
         color: #fff;
         border: none;
         border-radius: 30px;
         cursor: pointer;
         width : 25%;
         height : 50px;
         font-size : 1.5rem;
      }

      font.error {
         color: red;
      }
      
      
   </style>
</head>
<body>
<div style="margin-top : 55px">
<h2>건의하기 작성</h2>
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
			<td colspan="2" style="text-align: center;">
				<input type="submit" value="건의하기">
			</td>
		</tr>
	</table>
</form:form>
</div>
</body>
</html>