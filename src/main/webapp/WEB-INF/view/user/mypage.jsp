<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 마이페이지</title>
<style>
.mypage_table  {
   width:400px;
   margin-top : 30px;
}
</style>
</head>
<body>
<div class="container" style="margin-top : 55px;">
   <div style="display : flex; justify-content : space-between;">   
      <div style="flex-basis : 20%;">
         <%@ include file="mypageSideBar2.jsp" %>
      </div>
      
      <div style="flex-basis : 80%;">
      <h1 class="mb-3">회원정보</h1>
      <div class="mypageInfo" style="width : 40%;">
         <table class="mypage_table w3-table w3-bordered">
              <tr>
                  <td>아이디</td>
                  <td>${user.user_id}</td>
               </tr>
               <tr>
                  <td>이름</td>
                     <td>${user.user_name}</td>
               </tr>   
               <tr>
                  <td>성별</td>
                  <td>${user.user_gender}</td>
               </tr>   
               <tr>
                  <td>전화번호</td>
                  <td>${user.user_tel}</td>
               </tr>   
               <tr>
                  <td>이메일</td>
                  <td>${user.user_email}</td>
               </tr>   
               <tr>
                  <td>에버점수</td>
                  <td>${user.user_avg}</td>
               </tr>            
         </table>
      </div>
       <br>
<%--       <a class="w3-button w3-white w3-border w3-border-green w3-round-large" href="update?user_id=${user.user_id}">회원정보수정</a>&nbsp;
       <a class="w3-button w3-white w3-border w3-border-green w3-round-large" href="password">비밀번호수정</a>&nbsp;
      <a class="w3-button w3-white w3-border w3-border-green w3-round-large" href="delete?user_id=${user.user_id}">회원탈퇴</a>&nbsp; --%>
      </div>
   </div>   
</div>   
</body>
</html>