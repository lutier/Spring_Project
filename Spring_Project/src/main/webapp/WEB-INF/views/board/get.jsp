<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%@ include file="../includes/header.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function() {
   const operForm = $("#operForm");
   $("#list_btn").on("click", function(e) {
      operForm.find("#bno").remove();
      operForm.attr("action","/board/list");
      operForm.submit();
   });
   $("#modify_btn").on("click", function(e) {
      operForm.attr("action","/board/modify").submit();
   });
});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="wrapper_read">
   <div class="read_head">
      <h3>게시글 읽기</h3>
   </div>
   <div class="read_line"></div>
   <table class="read_table">
      <thead>
	      	<tr class="read_table_title">
	      		<th>작성일</th>
	      		<td>
	      		<c:choose>
	      			<c:when test="${board.regdate } == ${board.updatedate }">
	      				<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.regdate }"/>
	      			</c:when>
	      			<c:otherwise>
	      				<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.updatedate }"/>
	      			</c:otherwise>
	      		</c:choose>
	      	</tr>
      </thead>
   	</table>
	<div class="read_table_content">
		<textarea class="read_content" name="content" readonly="readonly">${board.content }</textarea>
	</div>
	<div class="read_bottom">
		<button class="read_button" id="list_btn">목록</button>
		<c:if test="${auth.user_id eq board.writer }">
			<button class="read_button" id="modify_btn">수정</button>
		</c:if>
		<form id='operForm' action="/board/modify" method="get">
			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
			<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
			<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
		</form>
	</div>

<%@include file="../includes/footer.jsp" %>