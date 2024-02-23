<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
}

td {
	background-color: #f2f2f2; /* 연한 회색 */
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
	var account = "${account}"

	if (account == '') {
		if (confirm('로그인이 필요한 서비스입니다.')) {
			location.href = "login_form.do";
		} else {
			history.back();
		}
	}
	function insert(f) {
		var b_title = f.b_title.value;
		var b_content = f.b_content.value;

		if (b_title == '') {
			alert('제목을 입력하세요');
			return;
		}

		if (b_content == '') {
			alert('내용을 입력하세요');
			return;
		}

		f.action = "board_insert.do";
		f.method = "post";
		f.submit();

	}
</script>
</head>
<body>
	<form>
		<input type="hidden" name="m_idx" value="${account.m_idx}">
		<table border="1">
			<tr>
				<th>제목</th>
				<td><input type="text" name="b_title"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${account.m_id}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea cols="90" rows="25" name="b_content" ></textarea></td>
			</tr>
			<tr>
				<th colspan="2"><input type="button" value="작성"
					onclick="insert(this.form)"> <input type="button"
					value="목록으로" onclick="location.href='board_list.do'"></th>
			</tr>
		</table>
	</form>
</body>
</html>
