<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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

caption {
	font-weight: bold;
	font-size: 1.2em;
	margin-bottom: 10px;
}

th, td {
	padding: 10px;
	text-align: left;
	border-bottom: 2px solid #ccc; /* 연한 회색, 굵기 조절 */
}

th {
	width: 30%; /* 각 라벨 열의 너비를 조정 */
	background-color: #fff; /* 흰색 */
	color: #333; /* 어두운 회색 */
	border-bottom: 2px solid #999; /* 테두리 색상 변경 */
}

td {
	width: 70%; /* 각 입력 칸의 너비를 조정 */
	background-color: #f2f2f2; /* 연한 회색 */
}

input[type="text"], input[type="password"] {
	width: 98%;
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
	var account = "${account}";

	if (account != '') {
		location.href = "board_list.do";
	}

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

	var id_checked = false;
	var pwd_checked = false;

	function id_check() {
		var m_id = document.getElementById("m_id").value;
		if (m_id == "") {
			alert('아이디를 입력하세요');
			return;
		}
		var url = 'id_checked.do';
		var param = "m_id=" + encodeURIComponent(m_id);
		sendRequest(url, param, resultFn, "post");
	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			var json = (new Function('return' + data))();
			if (json[0].res == 'yes') {
				alert('아이디가 확인되었습니다.');
				id_checked = true
			} else {
				alert('존재하지 않는 이메일입니다.');
				idchecked = false;
				return;
			}
		}
	}

	function che() {
		id_checked = false;
	}
	function chee() {
		pwd_checked = false;
	}

	function pwd_found(f) {
		var m_pwd = f.m_pwd.value;
		var re_pwd = f.re_pwd.value;

		if (m_pwd == "") {
			alert('비밀번호를 입력하세요');
			return;
		}
		if (re_pwd == "") {
			alert('비밀번호를 다시 입력하세요');
			return;
		}
		if (m_pwd != re_pwd) {
			alert('비밀번호가 일치하지 않습니다.');
			return;
		}
		pwd_checked = false;

		f.action = "pwd_found.do";
		f.method = "post";
		f.submit();

	}
</script>
</head>
<body>
	<form>
		<table border="1" align="center">
			<caption>비밀번호 찾기</caption>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="m_id" id="m_id" onchange="che()"></td>
				<th><input type="button" onclick="id_check()" value="확인하기"></th>
			</tr>
			<tr>
				<th>변경할 비밀번호</th>
				<td colspan="2"><input type="password" onchange="chee()"
					name="m_pwd"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td colspan="2"><input type="password" onchange="chee()"
					name="re_pwd"></td>
			</tr>
			<tr>
				<th colspan="3"><input type="button" value="변경하기"
					onclick="pwd_found(this.form)"> <input type="button"
					value="목록으로" onclick="location.href='board_list.do'"></th>
			</tr>
		</table>
	</form>
</body>
</html>
