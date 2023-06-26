<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/search.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>볼링매니아 ${title} 찾기</title>
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
  		<c:if test="${title=='아이디'}">
  			<th>${title} : </th><td>${result}</td>
  		</c:if>
  		<c:if test="${title!='아이디'}">
  			<th>임시${title} : </th><td>${result}</td>
  		</c:if>  		
  	</tr>
  	<tr>
  		<td colspan="2">
     		<c:if test="${title=='아이디'}">
        	<input type="button" value="아이디전송" onclick="sendclose()">
        </c:if>
    	  <c:if test="${title!='아이디'}">
      		<input type="button" value="닫기" onclick="self.close()">
      	</c:if>
      </td>
    </tr>
	</table>
</body>
</html>