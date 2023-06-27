<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 게임결과</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#memberCount").change(function() {
            var count = $(this).val();
            var formHtml = "";
            for (var i = 1; i <= count; i++) {
                formHtml += "<tr>";
                formHtml += "<td>회원 " + i + " ID:</td>";
                formHtml += "<td><input type='text' name='visitList[" + (i-1) + "].vi_id'></td>";
                formHtml += "<td>총게임수:</td>";
                formHtml += "<td><input type='number' name='visitList[" + (i-1) + "].vi_game' oninput='calculateAvg(" + (i-1) + ")'></td>";
                formHtml += "<td>총점:</td>";
                formHtml += "<td><input type='number' name='visitList[" + (i-1) + "].vi_total' oninput='calculateAvg(" + (i-1) + ")'></td>";
                formHtml += "<td>에버점수:</td>";
                formHtml += "<td><input type='number' name='visitList[" + (i-1) + "].vi_avg' readonly></td>";
                formHtml += "</tr>";
            }
            $("#memberTable").html(formHtml);
        });
    });

    function calculateAvg(index) {
        var total = parseFloat($("input[name='visitList[" + index + "].vi_total']").val());
        var gameCount = parseFloat($("input[name='visitList[" + index + "].vi_game']").val());
        var avg = Math.round(total / gameCount);
        $("input[name='visitList[" + index + "].vi_avg']").val(avg);
    }
</script>
</head>
<body>
<h2>게임결과</h2>
<form:form modelAttribute="visitForm" method="post" action="visit">
    <table>
        <tr>
            <td>참여 회원 수:</td>
            <td>
                <select id="memberCount" name="memberCount">
                    <option value="1">1명</option>
                    <option value="2">2명</option>
                    <option value="3">3명</option>
                    <option value="4">4명</option>
                    <option value="5">5명</option>
                    <option value="6">6명</option>
                    <option value="7">7명</option>
                    <option value="8">8명</option>
                </select>
            </td>
        </tr>
    </table>

    <table id="memberTable"></table>

    <input type="submit" value="점수 등록">
</form:form>
</body>
</html>
