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
   text-align: center;
}

</style>
</head>
<body>
<div class="container" style="margin-top : 60px;">
   <div style="display : flex; justify-content : space-between;">   
      <div style="flex-basis : 20%;">
         <%@ include file="mypageSideBar2.jsp" %>
      </div>
      
      <div style="flex-basis : 80%;" >
      <h1 class="mb-3">회원정보</h1>
      <div class="row">
      <div class="mypageInfo" >
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
      </div>
      </div>
   </div>   
</div>   
</body>
</html>