<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<%@ include file="../includes/header.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function() {
	var rmItem = '<c:out value="${param.rmItem}"/>';
	if(rmItem){
		alert("글이 삭제 되었습니다.");
		history.replaceState(null, null, "?");
		console.log(location.pathname);
	}
});

$(function(){
	$(".write_btn").on("click", function(){
		self.location = "/board/register";
	});
	let result = '<c:out value="${result}"/>';
	checkModal(result);
	history.replaceState({}, null, null)
	function checkModal(result){
		if (result === '' || history.state){
			return;
		}
		if (parseInt(result) > 0){
			result = parseInt(result) + " 번이 등록되었습니다."
		} else {
			result = "처리가 완료 되었습니다."
		}
		alert(result);
	}
	
	/* if (result != ""){
		result += "번 글이 등록되었습니다.";
		alert(result);
	} */
	$(".get").on("click", function(e){
		e.preventDefault();
		let form = $('<form></form>');
		form.attr("method","get");
		form.attr("action", "/board/get");
		form.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='pageNum' value='" + <c:out value="${pageDTO.criteria.pageNum}"/> + "'>");
		form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/> + "'>");
		
		form.appendTo('body');
		form.submit();
	});
	
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		let form = $('<form></form>');
		form.attr("method","get");
		form.attr("action","/board/list");
		form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/> + "'>");
		form.appendTo('body');
		form.submit();
	});
	
});

</script>
<style>
	.cls1 {text-deciration:none;}
	.cls2{text-align:center; font-size:30px;}
</style>
<meta charset="UTF-8">
<title>글 목록 창</title>
</head>
<body>
	<table class="board_table">
		<thead>
			<tr class="table_title">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody class="board_content">
			<c:forEach items="${list }" var="board">
				<tr class="tr_list">
					<td><c:out value="${board.bno }"/></td>
					<td>
						<a class="get" href='<c:out value="${board.bno }"/>'>
							<c:out value="${board.title }"/>
						</a>
					</td>
					<td><c:out value="${board.writer }"/></td>
					<td>
						<c:choose>
							<c:when test="${board.regdate} == ${board.updatedate }">
								<fmt:formatDate pattern="YY-MM-DD hh:mm" value="${board.regdate }"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate pattern="YY-MM-DD hh:mm" value="${board.updatedate }"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- page -->
	<div class="board_page">
		<ul class="pagination">
			<c:if test="${pageDTO.prev }">
				<li class="paginate_button previous">
					<a href="${pageDTO.startPage-1 }">Prev</a>
				</li>
			</c:if>
			<c:forEach var="num" begin="${pageDTO.startPage }" end="${pageDTO.endPage }">
				<li class="paginate_button ${pageDTO.criteria.pageNum==num ? 'active_list' :'' }">
					<a href="${num }">${num }</a>
				</li>
			</c:forEach>
			<c:if test="${pageDTO.next }">
				<li class="paginate_button next">
					<a href="${pageDTO.endPage+1 }">Next</a>
				</li>
			</c:if>
		</ul>
	</div>
	
	<div class="board_bottom">
		<button class="write_btn" id="write_btn">글쓰기</button>
	</div>
<%@include file="../includes/footer.jsp" %>