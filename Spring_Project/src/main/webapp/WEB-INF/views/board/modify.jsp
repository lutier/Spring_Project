<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%@ include file="../includes/header.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form");
		$('button').on("click", function(e){
			e.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			
			if (operation === 'remove'){
				formObj.attr("action","/board/remove");
			} else if(operation === 'list'){
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				formObj.empty();
				formObj.attr("action","/board/list").attr("method","get");
				formObj.append(pageNumTag);
				formObj.append(amountTag);
			}
			formObj.submit();
		});
	});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="wrapper_read">
	<div class="read_head">
		<h3>게시글 수정화면 입니다.</h3>
	</div>
	<div class="read_line"></div>
	<form action="/board/modify" method="post">
		<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum }"/>'>
		<input type='hidden' name='amount' value='<c:out value="${criteria.amount }"/>'>
		<table class="read_table">
			<thead>
				<tr class="read_table_title">
					<th>번호</th>
					<td><input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly"></td>
				</tr>
				<tr class="read_table_title">
					<th>제목</th>
					<td><input class="form-control" name="title" value='<c:out value="${board.title }"/>'></td>
				</tr>
				<tr class="read_table_title">
					<th>작성자</th>
					<td><input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly"></td>
				</tr>
				<tr class="read_table_title">
					<th>작성일</th>
					<td><input class="form-control" name="regDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/>' readonly="readonly"></td>
				</tr>
				
			</thead>
		</table>
		<div class="read_table_content">
			<textarea class="read_content" name="content"><c:out value="${board.content }"/></textarea>
		</div>
		<c:if test="${auth.user_id eq board.writer }">
			<button type="submit" data-oper='modify' class="read_button">수정</button>
			<button type="submit" data-oper='remove' class="read_button">삭제</button>
		</c:if>
		<button type="submit" data-oper="list" class="read_button">List</button>
	</form>
</div>
<%@include file="../includes/footer.jsp" %>
</html>