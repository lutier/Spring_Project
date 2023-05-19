<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %>
<script>

$(function(){
	$(".login_button").on("click",function(e){
		e.preventDefault();
		if(isValid()){
			$("form").submit();
		}
	});
	
	function isValid(){
		const user_id = $("#user_id").val();
		const user_pw = $("#user_pw").val();
		
		$("#error_user_id").text("");
		$("#error_user_pw").text("");
		
		if (user_id === ""){
			$("#error_user_id").text("E-mail을 입력하세요.");
			$("#user_id").focus();
			return false;
		}
		
		if(user_pw === ""){
			$("#error_user_pw").text("비밀번호를 입력하세요.");
			$("#user_pw").focus();
			return false;
		}
		return true;
	}
	
	let error = "${error}";
	console.log(error);
	
	if(error === ""){
		return;
	}
	if(error === "nonuser"){
		$("#user_id").focus();
	} else {
		$("#user_pw").focus();
	}
	let msg = (error === "nonuser") ? "존재하지 않는 E-mail입니다." : "비밀번호가 일치하지 않습니다.";
	alert(msg);
});
</script>

<div class="wrapped_login">
	<form action="/member/login" class="login_form" method="post">
		<div class="form_id">
			<label for="user_name">E-mail</label>
			<input type="email" class="id_control" id="user_id" name="user_id" placeholder="E-mail을 입력하세요" value="${memberVO.user_id }" />
			<div class="error" id="error_user_id"></div>
		</div>
		<div class="form_pw">
			<label for="password">비밀번호</label>
			<input type="password" class="pw_control" id="user_pw" name="user_pw" placeholder="비밀번호를 입력하세요"/>
			<div class="error" id="error_uesr_pw"></div>
		</div>
		<div class="form_login_button">
			<button class="login_button" type="submit">
				로그인
			</button>
		</div>
	</form>
</div>

<%@ include file="../includes/footer.jsp"%>