

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ include file="./includes/header.jsp" %>

<br>
    
<script>
$(function() {
	let msg = "${msg}";
	if(msg == "") {
		return;
		}
	let txt;
	if(msg === "logout"){
		txt = "로그아웃 되었습니다.";
		history.replaceState(null, null, location.pathname);
	}
	alert(txt);
});
</script>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>


<br>

<%@include file="./includes/footer.jsp" %>