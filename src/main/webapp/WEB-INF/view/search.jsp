<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/search.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>볼링매니아 아이디찾기</title>
<script type="text/javascript">
   function sendclose() {
	   opener.document.loginform.user_id.value='${result}';
	   self.close();
   }
</script>
</head>
<body>
	<table>
  	<tr>
  		<th>아이디 : </th><td>${result}</td></tr>
  		<tr>
  	<td>
      <input type="button" value="아이디전송" onclick="sendclose()">
		</td>
	</tr>
</table></body></html>