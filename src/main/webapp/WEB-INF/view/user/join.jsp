<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 회원가입</title>
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript">
var code;
var isCodeValid = false; // 인증번호 유효성 검사를 위한 변수 추가

$(document).on('click', '#mail-Check-Btn', function() {
    const email = $('#user_email').val() + $('#user_email_domain').val();
    const checkInput = $('.mail-check-input');

    $.ajax({
        type: 'get',
        url: '<c:url value="/user/mailCheck?email="/>' + email,
        success: function (data) {
            console.log("data : " + data);
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
    if (!isCodeValid) { // 인증번호 유효하지 않으면 회원가입 버튼 동작 막기
        event.preventDefault();
        alert('인증번호가 다릅니다. 회원가입을 진행할 수 없습니다.');
    } else {
        // 이메일 주소값을 생성하여 필드에 설정
        const emailValue = $('#user_email').val() + $('#user_email_domain').val();
        $('#user_email').val(emailValue);
    }
});
</script>
</head>
<body>
	<h2>볼링매니아 회원가입</h2>
		<form:form modelAttribute="user" method="post" action="join">
 			<spring:hasBindErrors name="user">
    	<font color="red">
<%-- ${errors.globalErrors} : controller에서 bresult.reject(코드값)메서드로
                              추가한 error 코드 값들
 --%>      
    		<c:forEach items="${errors.globalErrors}" var="error">
<%--
    <spring:message code="${error.code}" /> : 코드값에 해당하는 메세지를 출력
				                                    현재 messages.properties 파일에 설정
    ${error.code} : reject(코드값)으로 등록한 코드값
 --%>      
        	<spring:message code="${error.code}" /><br>
      	</c:forEach>
    	</font>
 			</spring:hasBindErrors>
 			<table>
   			<tr>
   				<td>아이디</td>
   				<td>
   					<form:input path="user_id"/>
        		<font color="red">
        			<form:errors path="user_id"/>
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
  				<td>성별</td>
  				<td>
  					<form:select path="user_gender">
  						<form:option value="">성별 선택</form:option>
  						<form:option value="남성">남성</form:option>
  						<form:option value="여성">여성</form:option>
  					</form:select>
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
     		   <div class="form-group email-form">
            <div class="input-group">
                <input type="text" class="form-control" name="user_email" id="user_email" placeholder="이메일">
                <select class="form-control" name="user_email_domain" id="user_email_domain">
                    <option value="@naver.com">@naver.com</option>
                    <option value="@daum.net">@daum.net</option>
                    <option value="@gmail.com">@gmail.com</option>
                    <option value="@hanmail.com">@hanmail.com</option>
                    <option value="@yahoo.co.kr">@yahoo.co.kr</option>
                </select>
            </div>
            <div class="input-group-addon">
                <button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
            </div>
            <div class="mail-check-box">
                <input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
            </div>
            <span id="mail-check-warn"></span>
        		</div>
  			  </td>
				</tr>
   			<tr>
   				<td>에버점수</td>
   				<td>
   					<form:input path="user_avg" />
        		<font color="red">
        			<form:errors path="user_avg" />
        		</font>
        	</td>
        </tr>
   			<tr>
   				<td>
   					<input type="submit" value="회원가입">
            <input type="reset" value="초기화">
  				</td>
  			</tr>
  		</table>
  	</form:form>
  </body>
</html>