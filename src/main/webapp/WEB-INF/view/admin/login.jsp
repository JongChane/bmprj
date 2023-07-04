<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
</head>
<body>
<div style="margin-top : 55px">
   <h2>관리자 로그인</h2>
   <form:form modelAttribute="admin" method="post" action="login">
      <spring:hasBindErrors name="admin">
       <font color="red">
          <c:forEach items="${errors.globalErrors}" var="error">
            <spring:message code="${error.code}" />
         </c:forEach>
       </font>
     </spring:hasBindErrors>
      <table>
         <tr>
            <td>아이디</td>
            <td>
               <form:input path="admin_id" />
                 <font color="red">
                    <form:errors path="admin_id" />
                 </font>
          </td>
        </tr>
         <tr>
            <td>비밀번호</td>
            <td>
               <form:password path="admin_pass" />
            			<font color="red">
               <form:errors path="admin_pass" />
            </font>
          </td>
        </tr>
         <tr>
            <td colspan="2" align="center">
               <input type="submit" value="관리자로그인">
               <input type="button" value="회원페이지로" onclick="location.href='../user/login'">
            </td>
         </tr>
      </table>
   </form:form>
</div>   
</body>
</html>