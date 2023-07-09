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
<div style="margin-top : 60px; width:60%" class=" container text-center">
<h2 class="mt-5 mb-5">건의하기 작성</h2>
<form:form modelAttribute="board" action="write" name="f">
	<table class="table table-bordered align-middle">
		<tr>
			<th class="text-center w3-green">제목</th>
			<td>
				<form:input path="board_title" class="form-control" maxlength="30"/>
				<font color="red"><form:errors path="board_title"/></font>
			</td>
		</tr>
		<tr>
			<th class="text-center w3-green">내용</th>
			<td>
				<form:textarea path="board_content" class="form-control" rows="15"/>
				<font color="red"><form:errors path="board_content"/></font>
			</td>
<!-- 		<script>CKEDITOR.replace("board_content",{filebrowserImageUploadUrl :  "imgupload" })</script>-->
		<tr>
	</table>
				<div class="mt-5 text-center"><input type="submit" value="건의하기"></div>
</form:form>
</div>

</body>
</html>