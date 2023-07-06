<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script type="text/javascript">
   function inchk(f) {
	 let pass = f.chgpass.value;
	   
	 if (pass != f.chgpass2.value) {
	        alert("변경할 비밀번호와 재입력한 비밀번호가 다릅니다.");
	        f.chgpass2.value = "";
	        f.chgpass2.focus();
	        return false;
	    }
	    
	    if (pass.length < 3 || pass.length > 10) {
	        alert("비밀번호는 3자리 이상 10자리 이하로 입력하세요.");
	        f.chgpass.value = "";
	        f.chgpass.focus();
	        return false;
	    }
   return true;
   }
</script>
</head>
<body>
<div class="container" style="margin-top : 55px">
   <div style="display : flex; justify-content : space-between;">
      <div style="flex-basis : 20%;">
         <%@ include file="mypageSideBar2.jsp" %>
      </div>
      
      <div style="flex-basis : 80%;">
   <h2>비밀번호 변경</h2>
   <form action="password" method="post" name="f" onsubmit="return inchk(this)">
      <table class="w3-table">
        <tr>
           <th width="20%">현재 비밀번호</th>
           <td>
              <input type="password" name="user_pass" class="w3-input" >
           </td>
        </tr>
        <tr>
           <th>변경 비밀번호</th>
           <td>
              <input type="password" name="chgpass" class="w3-input" >
           </td>
        </tr>
        <tr>
           <th>변경 비밀번호 재입력</th>
           <td>
              <input type="password" name="chgpass2" class="w3-input" >
           </td>
        </tr>
        <tr>
           <td colspan="2" class="w3-center">
              <input type="submit" value="비밀번호 변경">
           </td>
        </tr>
      </table>
   </form>
      </div>
   </div>   
</div>   
</body>
</html>