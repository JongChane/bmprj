<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="uri" value="${pageContext.request.servletPath}" />
<!DOCTYPE html>
<html> 
<head>
<title><sitemesh:write property="title"/></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
html, body {
    height: 100%;
    width:100%;
    margin 0;
    padding 0;
}
body, h1,h2,h3,h4,h5,h6 {
    font-family: 'TheJamsil5Bold'; sans-serif;
    font-weight: 400;
    font-style: normal;
    }
 footer   {
		background-color:#282a35;
  	height: 120px;
  	position : realative;
  	margin-top:-60px;
  } 
  #main {
	height : auto;
	min-height : 100%;
	padding-bottom : 120px;
	margin-top:100px;
}
.w3-row-padding img {margin-bottom: 12px}
/* Set the width of the sidebar to 120px */
/* Remove margins from "page content" on small screens */
/* @media only screen and (max-width: 600px) {#main {margin-left: 0}} */
@font-face {
    font-family: 'TheJamsil5Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 500;
    font-style: normal;
}
a{
    text-decoration-line: none;
}

</style>
<script type="text/javascript"
  src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js">
  </script>
<sitemesh:write property="head"/>
</head>
<!-- Top container -->
<div style="background-color:#00C73C; font-family:'TheJamsil5Bold'; sans-serif; font-weight: 500;"
       class="w3-container w3-center w3-bar w3-top w3-large">
  <a href="${path}/member/main" class="w3-bar-item"><img src="${path}/image/bm.png" class="w3-image" width="13%">&nbsp;&nbsp;볼링매니아</a>
  <a href="${path}/board/list?boardid=1" class="w3-bar-item w3-button">볼링장정보</a>
  <a href="${path}/game/gamelist" class="w3-bar-item w3-button">소셜매치</a>
  <span class="w3-bar-item w3-right">
  <c:if test="${empty sessionScope.login}">
     <a href="${path}/user/login">로그인</a>
     <a href="${path}/user/join">회원가입</a>
  </c:if>
  <c:if test="${!empty sessionScope.login}">
     ${sessionScope.login}님&nbsp;&nbsp;
     <a href="${path}/member/info?member_id=${sessionScope.login}">내정보</a>&nbsp;
     <a href="${path}/member/logout">로그아웃</a>
  </c:if>
  </span>
</div>

<body class="w3-white">
<!-- Page Content -->
<div id="main">
<sitemesh:write property="body"/>
 </div>
</body>
</html>