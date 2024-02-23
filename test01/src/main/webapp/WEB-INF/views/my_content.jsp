<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td, th{
	padding: 15px;
	text-align: center;
	border-bottom: 2px solid #ccc; /* 연한 회색, 굵기 조절 */
	width: 25%;
}

th {
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
.paging {
  text-align: center; /* 중앙 정렬 */
  margin-top: 20px; /* 위쪽 여백 추가 */
}

.paging span, .paging b {
  padding: 5px 10px; /* 각 페이지 번호의 여백 설정 */
  cursor: pointer; /* 마우스 오버 시 커서 모양 변경 */
}

.paging span:hover {
  background-color: #ddd; /* 마우스 오버 시 배경색 변경 */
}
.ii{
	padding: 5px;
	text-align: center;
}
.class_hr:hover{
	background-color: red;
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
</script>
</head>
<body>
	<table border="1">
		<tr>
			<th><input type="button" value="프로필"
				onclick="location.href='member_info.do?m_idx=${account.m_idx}'">
				<input type="button" value="목록으로"
				onclick="location.href='board_list.do'"></th>
		</tr>
	</table>
	<table border="1" align="center">
		<tr>
			<th colspan="4" style="text-align: center;">${vo.m_id}님의 게시글</th>
		</tr>
		<tr>
			<td colspan="4">
				<div class="ii">
				<span style="padding-right: 10px;">총 게시물 <b style="color: red">${paging.total}</b> 건</span>
				<span>현재 페이지 <b style="color: red">${paging.nowPage} / ${paging.lastPage}</b></span>
			</div>
			</td>
		</tr>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일자</th>
		</tr>
		<c:forEach var="vo" items="${list}">
			<tr onclick="location.href='board_view.do?b_idx=${vo.b_idx}'" class="class_hr">
				<td>${vo.b_idx}</td>
				<td>${vo.b_title}</td>
				<td>${vo.m_id}</td>
				<td>${vo.b_date}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 페이지 선택 -->
	<div class="paging">
		<c:if test="${paging.startPage != 1}">
			<span
				onclick="location.href='my_content.do?m_idx=${account.m_idx}&nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}'">&lt;</span>
		</c:if>
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage}">
					<b>${p}</b>
				</c:when>
				<c:when test="${p != paging.nowPage}">
					<span
						onclick="location.href='my_content.do?m_idx=${account.m_idx}&nowPage=${p}&cntPerPage=${paging.cntPerPage}'">${p}</span>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<span
				onclick="location.href='my_content.do?m_idx=${account.m_idx}&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}'">&gt;</span>
		</c:if>
	</div>
</body>
</html>
