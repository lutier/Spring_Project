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
		let type = $('select[name=type]').val();
		let keyword = $('input[name=keyword]').val();
		form.attr("method", "get");
		form.attr("action","/board/get");
		form.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='pageNum' value='"+<c:out value="${pageDTO.criteria.pageNum}"/>+"'>");
		form.append("<input type='hidden' name='amount' value='"+<c:out value="${pageDTO.criteria.amount}"/>+"'>");
		form.append("<input type='hidden' name='type' value='"+ type + "'>");
		form.append("<input type='hidden' name='keyword' value='"+ keyword + "'>");
		form.appendTo('body');
		form.submit();
	});
	
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		let form = $('<form></form>');
		let type = $('select[name=type]').val();
		let keyword = $('input[name=keyword]').val();
		form.attr("method","get");
		form.attr("action","/board/list");
		form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/> + "'>");
		form.append("<input type='hidden' name='type' value='"+ type + "'>");
		form.append("<input type='hidden' name='keyword' value='"+ keyword + "'>");
		form.appendTo('body');
		form.submit();
	});
	
	let list = new Array();
	<c:forEach items="${list}" var="board">
		list.push(<c:out value="${board.bno}" />);
	</c:forEach>
	if(list.length == 0){
		return;
	}
	
	$.getJSON("/replies/cnt", {list: list}, function(data){
		let keys=Object.keys(data);
		$(keys).each (function(i, bno){
			let replyCnt = data[bno];
			let text = $("a[name="+bno+"]").text().trim() + "[" + replyCnt + "]";
			$("a[name="+bno+"]").text(text);
		})
	});
	
	let searchForm = $("#searchForm");
	$("#searchForm button").on("click", function (e){
		if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요.");
			return false;
		}
		if (!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요.")
			return false;
		}
		searchForm.find("input[name='keyword']").val("1");
		e.preventDefault();
		searchForm.submit();
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
				<th>첨부파일</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody class="board_content">
			<c:forEach items="${list }" var="board">
				<tr class="tr_list">
					<td><c:out value="${board.bno }"/></td>
					<td>
						<a class="get" href='<c:out value="${board.bno }"/>' name='<c:out value="${board.bno }"/>'>
							<c:out value="${board.title }"/>
						</a>
					</td>
					<td><c:out value="${board.writer }"/></td>
					<td id='<c:out value="${board.bno }"/>'></td>
					<td>
						<c:choose>
							<c:when test="${board.regdate == board.updatedate}">
								<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.regdate}"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.updatedate}"/>
								<c:out value="수정됨"/>
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
					<a href="${num }">&nbsp;${num }&nbsp;</a>
				</li>
			</c:forEach>
			<c:if test="${pageDTO.next }">
				<li class="paginate_button next">
					<a href="${pageDTO.endPage+1 }">Next</a>
				</li>
			</c:if>
		</ul>
	</div>
	
	<!-- search -->
	<div class="searchform">
		<form action="/board/list" id="searchForm">
			<select name="type" class="select-style">
				<option value="" <c:out value="${pageDTO.criteria.type == null ? 'selected' : '' }"/>>--</option>
				<option value="T" <c:out value="${pageDTO.criteria.type eq 'T' ? 'selected' : '' }"/>>제목</option>
				<option value="C" <c:out value="${pageDTO.criteria.type eq 'C' ? 'selected' : '' }"/>>내용</option>
				<option value="W" <c:out value="${pageDTO.criteria.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
				<option value="TC" <c:out value="${pageDTO.criteria.type eq 'TC' ? 'selected' : '' }"/>>제목 or 내용</option>
				<option value="TW" <c:out value="${pageDTO.criteria.type eq 'TW' ? 'selected' : '' }"/>>제목 or 작성자</option>
				<option value="TWC" <c:out value="${pageDTO.criteria.type eq 'TWC' ? 'selected' : '' }"/>>제목 or 내용 or 작성자</option>
			</select>
			<input type="text" class="select-style" name="keyword" value="<c:out value="${pageDTO.criteria.keyword }"/>"/>
			<input type="hidden" name="pageNum" value="<c:out value="${pageDTO.criteria.pageNum }"/>"/>
			<input type="hidden" name="amount" value="<c:out value="${pageDTO.criteria.amount }"/>"/>
			<button class="button">검색</button>
		</form>
	</div>
	
	<div class="board_bottom">
		<button class="write_btn" id="write_btn">글쓰기</button>
	</div>
<%@include file="../includes/footer.jsp" %>