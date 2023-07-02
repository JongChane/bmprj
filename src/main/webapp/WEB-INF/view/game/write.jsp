<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매치등록</title>
</head>
<body>
<h1>매치 작성</h1>
<form:form modelAttribute="game" action="write" method="post">
   <table class="w3-table">
      <tr>
         <th>작성자</th>
         <td>
            <form:input path="user_id" class="w3-input" readonly="true"/>
            <font color="red">
               <form:errors path="user_id"/>
            </font>
         </td>
      </tr>
       <tr>
         <th>제목</th>
         <td>
            <form:input path="game_title" class="w3-input"/>
            <font color="red">
               <form:errors path="game_title"/>
            </font>
         </td>
      </tr>
      <tr>
         <th>나이제한</th> 
	         <td>
		         <select class="w3-select" name="game_age">
			         <option value="10">10대</option>
			         <option value="20">20대</option>
			         <option value="30">30대</option>
			         <option value="40">40대</option>
			         <option value="50">50대</option>
		         </select>
	            <font color="red">
	               <form:errors path="game_age"/>
	            </font>
	         </td>
      </tr>
	  <tr>
	         <th>성별</th>
	          <td>
		         <select class="w3-select" name="game_gender">
			         <option value="1">남성</option>
			         <option value="2">여성</option>
			         <option value="3">성별무관</option>
		         </select>
	            <font color="red">
	               <form:errors path="game_gender"/>
	            </font>
	         </td>
	   </tr>
	   <tr>
	   		<td>경기인원</td>
	          <td>
		         <select class="w3-select" name="game_max">
			         <option value="2">2명</option>
			         <option value="3">3명</option>
			         <option value="4">4명</option>
			         <option value="5">5명</option>
			         <option value="6">6명</option>
			         <option value="7">7명</option>
			         <option value="8">8명</option>
		         </select>
	            <font color="red">
	               <form:errors path="game_max"/>
	            </font>
	         </td>
	   </tr>
	  <tr>
	   		<td>경기날짜</td>
	          <td>
		       <form:input path="game_date" class="w3-input" type="date"/>
	            <font color="red">
	               <form:errors path="game_date"/>
	            </font>
	         </td>
	   </tr>
       <tr>
         <th>평균에버리지</th>
         <td>
            <form:input path="game_avg" class="w3-input"/>
            <font color="red">
               <form:errors path="game_avg"/>
            </font>
         </td>
      </tr>
      <tr>
         <th>제한사항</th>
         <td>
            <form:textarea path="game_content" class="w3-input"/>
            <font color="red">
               <form:errors path="game_content"/>
            </font>
         </td>
      </tr>
      <tr>
      	<td>
      		<input type="submit" value="매치개설">
      	</td>
      </tr>
   </table>
</form:form>
</body>
</html>