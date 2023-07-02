<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>날짜 선택</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(function() {
            $("#Date").datepicker({
                minDate: 0, // 오늘 날짜 이전은 선택할 수 없음
                maxDate: "+2w" // 오늘 날짜 기준 2주 뒤까지 선택 가능
            });
        });
    </script>
</head>
<body>
    <h3>예약 날짜 선택</h3>
    <input type="text" id="Date" readonly>
</body>
</html>

