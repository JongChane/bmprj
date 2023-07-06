<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 유저정보 수정</title>
</head>
<body>
	<h2>정보 수정</h2>
	<form:form modelAttribute="user" method="post" action="update">
 		<spring:hasBindErrors name="user">
    <font color="red">
      <c:forEach items="${errors.globalErrors}" var="error">
        <spring:message code="${error.code}" /><br>
      </c:forEach>
    </font>
 		</spring:hasBindErrors>
  <table class="w3-table">
  	<tr>
  		<td width="10%">아이디</td>
  		<td>
  			<form:input path="user_id" readonly="true" class="w3-input"/>
        <font color="red">
        	<form:errors path="user_id" />
        </font>
      </td>
    </tr>
    <tr>
    	<td>비밀번호</td>
    	<td>
    		<form:password path="user_pass" />
        <font color="red">
        	<form:errors path="user_pass" />
        </font>
      </td>
    </tr>
		<tr>
   		<td>이름</td>
   			<td>
   				<form:input path="user_name" />
       		<font color="red">
       			<form:errors path="user_name" />
       		</font>
       	</td>
       </tr>
   			<tr>
   				<td>나이</td>
   				<td>
   					<form:input path="user_age" readonly="true" class="w3-input"/>
        		<font color="red">
        			<form:errors path="user_age" />
        		</font>
        	</td>
        </tr>       
  		<tr>
  			<td>성별</td>
  			<td>
  				<form:input path="user_gender" readonly="true" class="w3-input"/>
  				<font color="red">
       			<form:errors path="user_gender" />
       		</font>
  			</td>
  		</tr>
   		<tr>
   			<td>전화번호</td>
   			<td>
   				<form:input path="user_tel" />
   				<font color="red">
       			<form:errors path="user_tel" />
       		</font>
   			</td>
   		</tr>
		   <tr>
		   	<td>이메일</td>
		   	<td>
		   		<form:input path="user_email" readonly="true" class="w3-input"/>
		   		<font color="red">
       			<form:errors path="user_email" />
       		</font>
       	</td>
       </tr>
   		<tr>
   			<td>에버점수</td>
   			<td>
   				<form:input path="user_avg" readonly="true" class="w3-input" />
       		<font color="red">
       			<form:errors path="user_avg" />
       		</font>
       	</td>
       </tr>
		 	<tr>
		 		<td class="w3-center" colspan="2">
      		<input type="submit" value="회원수정" class="w3-btn w3-blue">
        	<input type="reset" value="초기화" class="w3-btn w3-blue">
   			</td>
   		</tr>
  	</table>
	</form:form>
</body>
</html>