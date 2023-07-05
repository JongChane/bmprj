<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<nav style="width:200px;" id="mySidebar">
  <div class="w3-container w3-row">
    <div class="w3-col s8 w3-bar" style="width : 70%;">
      <h3>마이페이지</h3>
    </div>   
  </div>
  <hr>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>&nbsp; Close Menu</a>
    <a href="${path}/user/mpgameList?user_id=${sessionScope.login}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="user" }'>w3-blue</c:if>">
    &nbsp; · 매칭 내역</a>
    <a href="${path}/user/reserveList?user_id=${sessionScope.login}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="user" }'>w3-blue</c:if>">
    &nbsp; · 예약 내역</a>
    <a href="${path}/user/boardList?user_id=${sessionScope.login}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="user" }'>w3-blue</c:if>">
    &nbsp; · 건의 내역</a>
    <hr>
    
    <hr>
    <a href="${path }/user/mypage?user_id=${sessionScope.login}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url ==  "user"}'>w3-blue</c:if>">
    &nbsp; · 회원정보 조회</a>
    <a href="${path }/user/update?user_id=${sessionScope.login}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url ==  "user"}'>w3-blue</c:if>">
    &nbsp; · 회원정보 수정</a>
    <a href="${path }/user/password" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url ==  "user"}'>w3-blue</c:if>">
    &nbsp; · 비밀번호 수정</a>
    <a href="${path }/user/delete?user_id=${sessionScope.login}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url ==  "user"}'>w3-blue</c:if>">
    &nbsp; · 회원 탈퇴</a>
  </div>
  <br>    
</nav>