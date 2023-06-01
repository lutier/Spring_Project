<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="../includes/header.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="wrapper_register">
	<div class="register_head">
		<h3>게시판 작성 화면 입니다.</h3>
	</div>
	<div class="register_line"></div>
	<div class="register_body">
		<form class="register_form" method="post" action="/board/register">
			<div class="register_title">
				<input class="text_area" maxlength="50" placeholder="제목" name="title" required="required"/>
				<input class="text_area" maxlength="50" readonly="readonly" name="writer" value="${auth.user_id }"/>
			</div>
			<div class="register_written">
				<textarea type="text" class="written_area" palceholder="내용" name="content" required="required"></textarea>
			</div>
			<div class="register_submit">
				<button class="register_submit_button" type="submit">작성</button>
				<button class="register_submit_button" type="reset">취소</button>
			</div>
		</form>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>