<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 아이디 찾기</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript">
var code;
var isCodeValid = true; // 인증번호 유효성 검사를 위한 변수, 초기값을 true로 설정

$(document).on('click', '#mail-Check-Btn', function() {
    const email = $('#user_email').val() + $('#user_email_domain').val();
    const checkInput = $('.mail-check-input');

    $.ajax({
        type: 'get',
        url: '<c:url value="/user//idMailCheck?email="/>' + email,
        success: function (data) {
            checkInput.attr('disabled', false);
            code = data;
            isCodeValid = true; // 인증번호 유효함을 표시
            alert('인증번호가 전송되었습니다.');
        }            
    });
});

$(document).on('keyup', '.mail-check-input', function() {
    const inputCode = $(this).val();
    const warnSpan = $('#mail-check-warn');

    if (inputCode.length === 6) {
        if (inputCode === code) {
            warnSpan.text('일치합니다.').css('color', 'green');
            isCodeValid = true; // 인증번호 유효함을 표시
        } else {
            warnSpan.text('인증번호가 다릅니다.').css('color', 'red');
            isCodeValid = false; // 인증번호 유효하지 않음을 표시
        }
    } else {
        warnSpan.text('');
        isCodeValid = false; // 인증번호 유효하지 않음을 표시
    }
});

$(document).on('click', 'input[type="submit"]', function(event) {
    if (!isCodeValid || $('.mail-check-input').val().length !== 6) { // 인증번호 유효하지 않거나 인증번호 입력란의 길이가 6이 아닌 경우
        event.preventDefault();
        alert('정확한 인증번호를 입력하세요.');
    } else {
        // 이메일 주소값을 생성하여 필드에 설정
        const emailValue = $('#user_email').val() + $('#user_email_domain').val();
        $('#user_email').val(emailValue);
    }
});
</script>
</head>
<body>
	<h3>아이디찾기</h3>
	<form:form  modelAttribute="user" action="idsearch" method="post">
  	<spring:hasBindErrors name="user">
    	<font color="red">
    		<c:forEach items="${errors.globalErrors}" var="error">
    			<spring:message code="${error.code}" />
      	</c:forEach>
    	</font>
    </spring:hasBindErrors>
		<table class="w3-table">
			<tr>
    		<td>이메일</td>
   				<td>
     		   <div class="form-group email-form">
            <div class="input-group">
                <input type="text" class="form-control" name="user_email" id="user_email" placeholder="이메일">
                <select class="form-control" name="user_email_domain" id="user_email_domain">
                    <option value="@naver.com">@naver.com</option>
                    <option value="@daum.net">@daum.net</option>
                    <option value="@gmail.com">@gmail.com</option>
                    <option value="@hanmail.com">@hanmail.com</option>
                </select>
            </div>
            <div class="input-group-addon">
                <button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
            </div>
            <div class="mail-check-box">
                <input class="form-control mail-check-input" placeholder="인증번호 6자리 입력" disabled="disabled" maxlength="6">
            </div>
            <span id="mail-check-warn"></span>
        		</div>
  			  </td>
			</tr>
  		<tr>
		  	<td colspan="2" class="w3-center">
 				<input type="submit" value="아이디찾기" class="w3-btn w3-blue">
 				</td>
 			</tr>
 			</table>
	</form:form>
</body>
</html>