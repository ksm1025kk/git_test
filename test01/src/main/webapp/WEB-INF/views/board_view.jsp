<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	  text-align: center;
	  border-bottom: 2px solid #ccc; /* 연한 회색, 굵기 조절 */
	}

	th {
	  background-color: #fff; /* 흰색 */
	  color: #333; /* 어두운 회색 */
	  border-bottom: 2px solid #999; /* 테두리 색상 변경 */
	  width: 40%;
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
	var status = "${vo.b_auth}"
	if(status == 1){
		alert("삭제된 게시글입니다");
		history.back();
	}

	var click = true;
	function modify() {
		var b_title = document.getElementById('b_title');
		var b_content = document.getElementById('b_content');

		var modified_btn = document.getElementById('modified_btn');
		var modify_btn_value = document.getElementById('modify_btn').value;
		

		if (click) {
			b_title.disabled = false;
			b_content.disabled = false;
			modified_btn.style.display = 'block';
			modify_btn.value = "취소";
			click = false;
		} else {
			b_title.disabled = true;
			b_content.disabled = true;
			modified_btn.style.display = 'none';
			modify_btn.value = "수정하기";
			click = true;
		}
	}

	function modified(f) {
		if (!confirm("글을 수정하시겠습니까?")) {
			return;
		}
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

		f.action = "board_modifiy.do";
		f.method = "post";
		f.submit();
	}
	
	function delete_content(f){
		if(!confirm("글을 삭제하시겠습니까?")){
			return;
		} 
		f.action="board_delete.do";
		f.method = 'post';
		f.submit();
	}
</script>
</head>
<body>
	<form>
		<input type="hidden" name="b_idx" value="${vo.b_idx}"> 
		<input type="hidden" name="m_idx" value="${vo.m_idx}">
		<table border="1" align="center">
			<tr>
				<th>글번호</th>
				<td>${vo.b_idx}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" id="b_title" name="b_title"
					value="${vo.b_title}" disabled="disabled" style="width: 100%;"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea id="b_content" name="b_content" cols="80"
						rows="20" disabled="disabled">${vo.b_content}</textarea></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${vo.m_id}</td>
			</tr>
			<tr>
				<th>작성일자</th>
				<td>${vo.b_date}</td>
			</tr>
			<tr>
				<th colspan="5" align="center">
				<c:if test="${account.m_idx eq vo.m_idx}">
					<input type="button" value="삭제하기(${vo.b_idx})"
						onclick="delete_content(this.form)">
					<input type="button" id="modify_btn" value="수정하기" onclick="modify()">
					<input type="button" id="modified_btn" value="수정완료"
						onclick="modified(this.form)" style="display: none;">
				</c:if> 
					<input type="button" value="목록으로"
						onclick="location.href='board_list.do'"></th>
			</tr>
		</table>
	</form>
</body>
</html>
