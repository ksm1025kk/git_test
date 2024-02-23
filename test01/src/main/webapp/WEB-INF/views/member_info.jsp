<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	background-color: #fff; /* 흰색 */
	color: #333; /* 어두운 회색 */
	border-bottom: 2px solid #999; /* 테두리 색상 변경 */
	width: 30%;
}

td {
	background-color: #f2f2f2; /* 연한 회색 */
	width: 70%;
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

td input[type="text"], td input[type="password"] {
	width: 99%;
}
</style>
<script type="text/javascript">
	var account = "${account}";

	if (account == '') {
		if (confirm('로그인이 필요한 서비스입니다.')) {
			location.href = "login_form.do";
		} else {
			history.back();
		}
	}
	var pwd_check = false;
	 function change(){
		pwd_check = false;
		
		var origin_pwd = "${account.m_pwd}";
		var m_pwd = document.getElementById("m_pwd").value;
		var re_pwd = document.getElementById("re_pwd").value;
		
		var re_pwd_text = document.getElementById("re_pwd");
		var re_pwd_tr = document.getElementById("re_pwd_tr");
		var modify_tr = document.getElementById("modify_tr");
		
		if(m_pwd != origin_pwd){
			re_pwd_tr.style.display = "";
			modify_tr.style.display = "";
		}else{
			re_pwd_tr.style.display = "none";
			modify_tr.style.display = "none";
			re_pwd_text.value = "";
			pwd_check = true;
		}
	}
	function pwd_modified(f) {
		var m_pwd = f.m_pwd.value;
		var re_pwd = f.re_pwd.value;
		
		if (m_pwd == '') {
			alert('비밀번호를 입력하세요');
			return;
		}
		if(m_pwd == re_pwd){
			pwd_check = true;
		}
		if(!pwd_check){
			alert('비밀번호를 확인하세요.');
			return;
		}
		
		f.action = "member_modify.do"
		f.method = "post";
		f.submit();
	}
	function cchange(){
		pwd_check = false;
	}
	
	document.addEventListener("keydown", function(event) {
	    if (event.key === "Enter") {
			var modify_tr = document.getElementById("modify_tr");
	    	if(modify_tr.style.display==""){
	       		pwd_modified(document.querySelector("form"));
	    	}
	    }
	});
</script>
</head>
<body>
	<table border="1">
		<tr>
			<th><input type="button" value="내글보기"
				onclick="location.href='my_content.do?m_idx=${account.m_idx}'">
				<input
					type="button" value="목록으로" onclick="location.href='board_list.do'">
			</th>
		</tr>
	</table>

	<form>
		<input type="hidden" value="${account.m_idx}" name="m_idx">
		<table border="1" align="center">
			<tr>
				<th>아이디</th>
				<td>${account.m_id}</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" value="${account.m_pwd}" id="m_pwd"
					name="m_pwd" oninput="change()"></td>
			</tr>
			<tr id="re_pwd_tr" style="display: none">
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="re_pwd" id="re_pwd" oninput="cchange()">
				</td>
			</tr>
			<tr id="modify_tr" style="display: none">
				<td colspan="2">
					<input type="button" value="비밀번호 수정" id="moidfied_btn" onclick="pwd_modified(this.form)">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
