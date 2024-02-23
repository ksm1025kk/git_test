<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td {
	padding: 15px;
	text-align: left;
	border-bottom: 2px solid #ccc; /* 연한 회색, 굵기 조절 */
}

th {
	padding: 15px;
	text-align: left;
	background-color: #fff; /* 흰색 */
	color: #333; /* 어두운 회색 */
	border-bottom: 2px solid #999; /* 테두리 색상 변경 */
}

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

input[type="button"] {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	background-color: #ddd; /* 회색 */
	color: #333; /* 어두운 회색 */
	border: 2px solid #999; /* 어두운 회색 */
	cursor: pointer;
	transition: background-color 0.3s;
}

input[type="button"]:hover {
	background-color: #ccc; /* 연한 회색 */
}

td input[type="text"], td input[type="password"] {
	width: 100%;
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

	var id_check = false;

	function member_insert(f) {
		var m_pwd = f.m_pwd.value.trim();
		var m_pwd_check = f.m_pwd_check.value.trim();

		if (m_pwd == '') {
			alert('비밀번호를 입력하세요');
			return;
		}
		if (m_pwd_check == '') {
			alert('비밀번호를 다시 입력하세요');
			return;
		}
		if (m_pwd != m_pwd_check) {
			alert('비밀번호가 다릅니다.');
			return;
		}
		if (!id_check) {
			alert('아이디 중복체크하세요');
			return;
		}

		f.action = "member_insert.do";
		f.method = "post";
		f.submit();

	}
	function idcheck() {
		var m_id = document.getElementById("m_id").value.trim();
		if (m_id == '') {
			alert('아이디를 입력하세요.');
			return;
		}

		var url = "check_id.do";
		var param = "m_id=" + encodeURIComponent(m_id);

		sendRequest(url, param, resultFn, "POST");
	}
	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			var json = (new Function("return" + data))();

			if (json[0].res == 'no') {
				alert('이미 사용중인 아이디입니다.');
				id_check = false;
			} else {
				alert('사용 가능한 아이디입니다.');
				id_check = true;
			}
		}
	}

	function change1() {
		id_check = false;
	}
	document.addEventListener("keydown", function(event) {
	    if (event.key === "Enter") {
	    	member_insert(document.querySelector("form"));
	    }
	});
</script>
</head>
<body>
	<form>
		<table border="1" align="center">
			<tr>
				<th>id</th>
				<td><input type="text" name="m_id" id="m_id"
					onchange="change1()"></td>
			</tr>
			<tr>
				<th colspan="2"><input type="button" value="중복체크"
					onclick="idcheck()"></th>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="m_pwd"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="m_pwd_check"></td>
			</tr>
			<tr>
				<th colspan="2"><input type="button" value="회원가입"
					onclick="member_insert(this.form)"> <input type="button"
					value="돌아가기" onclick="location.href='board_list.do'"></th>
			</tr>
		</table>
	</form>
</body>
</html>
