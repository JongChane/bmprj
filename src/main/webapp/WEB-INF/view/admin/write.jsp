<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
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
         background-color: black;
         color: #fff;
         border: none;
         border-radius: 30px;
         cursor: pointer;
         width : 25%;
         height : 50px;
         font-size : 1.5rem;
      }
   </style>
</head>
<body>
<div>
<h2 class="mt-5 mb-5">공지사항 작성</h2>
	<form:form modelAttribute="notice" action="write" method="post">
		<table class="table table-bordered align-middle">
			<tr>
				<th class="text-center w3-black">제목</th>
				<td>
					<form:input path="notice_title" class="form-control" maxlength="30"/>
					<font color="red"><form:errors path="notice_title"/></font>
				</td>
			</tr>
			<tr>
				<th class="text-center w3-black">내용</th>
				<td>
					<form:textarea path="notice_content" class="form-control" rows="15"/>
					<font color="red"><form:errors path="notice_content"/></font>
				</td>
				<script>CKEDITOR.replace("notice_content",{filebrowserImageUploadUrl : "imgupload"})</script>
			</tr>
		</table>
		<div class="mt-5 text-center"><input type="submit" value="공지작성"></div>
		</form:form>
</div>
</body>
</html>