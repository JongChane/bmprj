<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 로그인</title>
<script type="text/javascript">
function win_open(page) {
      var op = "width=500, height=350, left=50,top=150";
      open(page ,"",op);
}
</script>
<style>
.container {
   width: 35%;
   margin: 200px auto;
   text-align: center;
}
.table-with-shadow {
   box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.2);
    border-radius: 10px;
    width: 500px;
    height: 500px;
}
.search-input {
   border: none;
   padding: 10px 20px;
   border-radius: 10px;
   box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.2);
   outline: none;
   transition: box-shadow 0.3s ease;
}

.search-input:focus {
   box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
}
.w3-table td {
  padding: 5px; 
   text-align: center;
  
    width: 60px;
}
.w3-table tr {
  margin-bottom: 5px; 
   height: 10px;
}
.user-id-label {
  font-size: 30px;
}
</style>
</head>
<body>
   <div class="container">
   <form:form modelAttribute="user" method="post" action="login" name="loginform">
      <input type="hidden" name="user_name" value="유효성검증을위한데이터" >
      <input type="hidden" name="user_email" value="a@a.a" >
      <input type="hidden" name="user_gender" value="유효성검증을위한데이터" >
      <input type="hidden" name="user_avg" value="1" >
     <spring:hasBindErrors name="user">
       <font color="red">
          <c:forEach items="${errors.globalErrors}" var="error">
            <spring:message code="${error.code}" />
         </c:forEach>
       </font>
     </spring:hasBindErrors>
      <table class="w3-table table-with-shadow">
      	<tr>
      		<td colspan="2" class="user-id-label">
      		사용자 로그인
      		</td>
      	</tr>
         <tr>
            <td>아이디</td>
            <td>
               <form:input path="user_id"  class="search-input" />
               <br>
                 <font color="red">
                    <form:errors path="user_id" />
                 </font>
          </td>
        </tr>
         <tr>
            <td>비밀번호</td>
            <td>
               <form:password path="user_pass"  class="search-input" />
               <br>
            <font color="red">
               <form:errors path="user_pass" />
            </font>
          </td>
        </tr>
         <tr>
            <td colspan="2" >
               <input type="submit" value="로그인" class="btn btn-success">
               <input type="button" value="회원가입"  class="btn btn-success" onclick="location.href='join'">
               <input type="button" value="아이디찾기" class="btn btn-success" onclick="win_open('idsearch')">
               <input type="button" value="비밀번호찾기" class="btn btn-success" onclick="win_open('pwsearch')">
            </td>
         </tr>
      </table>
   </form:form>
</div>   

</body>
</html>