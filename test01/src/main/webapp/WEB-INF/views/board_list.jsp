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
	text-align: center;
	border-bottom: 2px solid #ccc; /* 연한 회색, 굵기 조절 */
	width: 25%;
}

th {
	background-color: #fff; /* 흰색 */
	color: #333; /* 어두운 회색 */
	border-bottom: 2px solid #999; /* 테두리 색상 변경 */
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
	function search(f) {
		var option = f.type.value;
		var keyword = f.keyword.value;
		if (keyword == '') {
			alert('검색어를 입력하세요');
			return;
		} else {
			f.action = "search_board.do";
			f.submit();
		}
	}
	function selChange() {
		var orderby = document.getElementById('sort').value;
		var sel = document.getElementById('cntPerPage').value;
		location.href = "board_list.do?nowPage=${paging.nowPage}&cntPerPage="
				+ sel + "&orderby=" + orderby;
	}
	document.addEventListener("keydown", function(event) {
	    if (event.key === "Enter") {
	    	search(document.querySelector("form"));
	    }
	});
	function version3(){
		
	}
</script>
</head>
<body>

	<form>
	<table border="1" align="center">
		<tr>
			<th colspan="4">
				<c:choose>
					<c:when test="${empty account}">
						<input type="button" value="로그인"
							onclick="location.href='login_form.do'">
						<input type="button" value="회원가입"
							onclick="location.href='member_insert_form.do'">
						<input type="button" value="게시물 작성"
							onclick="location.href='board_insert_form.do'">
					</c:when>
					<c:when test="${not empty account}">
						<input type="button" value="${account.m_id}"
							onclick="location.href='member_info.do?m_idx=${account.m_idx}'">
						<input type="button" value="로그아웃"
							onclick="location.href='logout.do'">
						<input type="button" value="게시물 작성"
							onclick="location.href='board_insert_form.do'">
					</c:when>
				</c:choose>
			</th>
		</tr>
		<tr>
			<td colspan="4" style="text-align: center;">
				전체 게시판
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<span>
					<select id="type" name="type">
						<option value="b_title">제목</option>
						<option value="b_content">내용</option>
						<option value="m_id">작성자</option>
					</select>
				</span>
				<span>
					<input type="text" name="keyword" placeholder="검색어를 입력하세요.">
				</span>
				<span>
					<input type="submit" value="검색" onclick="search(this.form)" style="width: 50px; height: 30px; padding: 0px;">
					<input type="button" value="초기화" onclick="location.href='board_list.do'" style="width: 50px; height: 30px; padding: 0px;">
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="ii">
					<span style="padding-right: 10px;">총 게시물 <b style="color: red">${paging.total}</b> 건</span>
					<span>현재 페이지 <b style="color: red">${paging.nowPage} / ${paging.lastPage}</b></span>
				</div>
			</td>
			<td>
				<div class="ii">
					<select id="sort" name="sort" onchange="selChange()">
						<option value="b_date" <c:if test="${paging.orderby eq 'b_date'}">selected</c:if>>
						최신순으로 보기	
						</option>
						<option value="b_idx" <c:if test="${paging.orderby eq 'b_idx'}">selected</c:if>>
						글번호순으로 보기
						</option>
					</select>
				</div>
			</td>
				<td>
					<div>
					<select id="cntPerPage" name="sel" onchange="selChange()">
						<option value="5"
							<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5개씩
							보기</option>
						<option value="10"
							<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10개씩
							보기</option>
						<option value="15"
							<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15개씩
							보기</option>
						<option value="20"
							<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20개씩
							보기</option>
					</select>
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
				<c:if test="${vo.b_auth eq 1}">
					<td>삭제된 글입니다.</td>
				</c:if>
				<c:if test="${vo.b_auth eq 0}">
					<td>${vo.b_title}</td>
				</c:if>

				<td>${vo.m_id}</td>
				<td>${vo.b_date}</td>
			</tr>
		</c:forEach>
	</table>
	</form>
	<!-- 페이지 선택 -->
	<div class="paging">
		<c:if test="${paging.startPage != 1}">
			<span onclick="location.href='board_list.do?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}'">&lt;</span>
		</c:if>
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage}">
					<b>${p}</b>
				</c:when>
				<c:when test="${p != paging.nowPage}">
					<span onclick="location.href='board_list.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}'">${p}</span>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<span onclick="location.href='board_list.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}'">&gt;</span>
		</c:if>
	</div>
</body>
</html>