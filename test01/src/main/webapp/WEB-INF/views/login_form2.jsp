<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<style type="text/css">
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f2f2f2; /* 연한 회색 */
}

table {
    width: 50%;
    margin: 20px auto;
    border-collapse: collapse;
    background-color: #fff; /* 흰색 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 2px solid #ccc; /* 연한 회색, 굵기 조절 */
}

th {
    width: 33.33%; /* 각 라벨 열의 너비를 퍼센트로 설정하여 테이블을 세 등분 */
    background-color: #fff; /* 흰색 */
    color: #333; /* 어두운 회색 */
    border-bottom: 2px solid #999; /* 테두리 색상 변경 */
}

td {
    width: 33.33%; /* 각 입력 칸의 너비를 퍼센트로 설정하여 테이블을 세 등분 */
    background-color: #f2f2f2; /* 연한 회색 */
}

td input[type="text"], 
td input[type="password"] {
    width: 97%;
}

td:last-child,
th:last-child {
    width: 33.33%; /* 버튼 열의 너비를 퍼센트로 설정하여 테이블을 세 등분 */
}


input[type="button"] {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	background-color: #f2f2f2; /* 흰색 */
	color: #333; /* 어두운 회색 */
	border: 2px solid #ccc; /* 연한 회색 테두리 */
	cursor: pointer;
	transition: background-color 0.3s;
}

input[type="button"]:hover {
	background-color: #ddd; /* 밝은 회색 */
}
</style>
<script type="text/javascript">
	var xhr = null;

	function createRequest() {
		if (xhr != null)
			return;
		if (window.ActiveXObject)
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		else
			xhr = new XMLHttpRequest();
	}

	function sendRequest(url, param, callBack, method) {
		createRequest();
		var httpMethod = (method != 'POST' && method != 'post') ? 'GET'
				: 'POST';
		var httpParam = (param == null || param == '') ? null : param;
		var httpURL = url;

		if (httpMethod == 'GET' && httpParam != null)
			httpURL = httpURL + "?" + httpParam;

		xhr.open(httpMethod, httpURL, true);
		xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhr.onreadystatechange = callBack;
		xhr.send(httpMethod == 'POST' ? httpParam : null);
	}

	var account = "${account}";

	if (account != '') {
		location.href = "board_list.do";
	}

	function login(f) {
		var m_id = f.m_id.value;
		var m_pwd = f.m_pwd.value;

		if (m_id == "") {
			alert("아이디를 입력하세요");
			return;
		}
		if (m_pwd == "") {
			alert("비밀번호를 입력하세요");
			return;
		}
		var url = "login.do";
		var param = "m_id=" + encodeURIComponent(m_id) + "&m_pwd="
				+ encodeURIComponent(m_pwd);

		sendRequest(url, param, LoginCheck, "post");

	}

	function LoginCheck() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			var json = (new Function("return" + data))();

			if (json[0].param == "no_m_id") {
				alert("아이디가 존재하지 않음");
			} else if (json[0].param == "no_m_pwd") {
				alert("비밀번호가 틀림.");
			} else {
				alert("로그인 성공");
				location.href = "board_list.do";
			}
		}
	}
	document.addEventListener("keydown", function(event) {
	    if (event.key === "Enter") {
	    	login(document.querySelector("form"));
	    }
	});
</script>
</head>
<body>
	<form>
		<table border="1" align="center">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="m_id"></td>
				<td rowspan="2"><input type="button" value="비밀번호 찾기"
					onclick="location.href='pwd_find.do'"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="m_pwd"></td>
			</tr>
			<tr>
				<th colspan="3"><input type="button" value="로그인"
					onclick="login(this.form)"> <input type="button"
					value="목록으로" onclick="location.href='board_list.do'"></th>
			</tr>
		</table>
	</form>
</body>
</html>
