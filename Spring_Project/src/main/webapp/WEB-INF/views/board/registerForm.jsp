<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="../includes/header.jsp" %>
<script>
$(function(){
	let regex = new RegExp("(.*)\(exe|zip|alz)$");
	let maxSize = 5*1024*1024;
	function checkExtension(filename, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(filename)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	$("#uploadFile").on("change", function(e){
		let formData = new FormData();
		let inputFile = $("#uploadFile");
		let files = inputFile[0].files;
		for (let i = 0; i < files.length; i++){
			
			if (!checkExtension(files[i].name, files[i].size)){
				console.log("bbb");
				return false;
			}
			console.log(files[i]);
			formData.append("uploadFile", files[i]);
		}
		console.log(formData.get("uploadFile"));
		$.ajax({
			type: 'post',
			url: '/uploadFileAjax',
			processData: false,
			contentType: false,
			data: formData,
			success: function(result){
				console.log(result);
				showUploadResult(result);
			}
		});
	});
	function showUploadResult(result){
		if(!result || result.length == 0) {return;}
		let uploadUL = $(".uploadResult ul");
		let str = "";
		$(result).each( function (i, obj){
			console.log(obj.uploadPath);
			if(obj.image){
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.filename);
				str += "<li data-path='"+obj.uploadPath+"'";
				str += "	data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
				str += "		<div>";
				str += "			<span> "+ obj.filename+"</span>";
				str += "			<button type='button' data-file=\'"+fileCallPath+"\'";
				str += "				data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "			<img src='/display?filename="+fileCallPath+"'/>"; //use rest api
				str += "		</div>";
				str += "</li>";
			} else {
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.filename);
				str += "<li data-path='"+obj.uploadPath+"'";
				str += "	data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
				str += "		<div>";
				str += "			<span> " + obj.filename + "</span>";
				str += "			<button type='button' data-file=\'"+fileCallPath+"\'";
				str += "				data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "			<img src='/resources/img/attach.png' height='100px' width='100px'/>";
				str += "		</div>";
				str += "</li>";
			}
		});
		uploadUL.append(str);
	}
	
	$(".uploadResult").on("click", "li button", function(e){
		console.log("delete file");
		let targetFile = $(this).data("file");
		let type = $(this).data("type");
		let targetLi = $(this).parent().closest("li");
		let attach = {filename: targetFile, type: type};
		$.ajax({
			type: 'delete',
			url: '/deleteFile',
			data : JSON.stringify(attach),
			contentType : "application/json; charset=utf-8",
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		});
	});
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		let formObj = $(".register_form");
		let str="";
		$(".uploadResult ul li").each(function(i, listItem){
			let liObj = $(listItem);
			console.log("-----------------------");
			console.log(liObj.data("filename"));
			str += "<input type='hidden' name='attachList["+i+"].filename' value='" + liObj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + liObj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='" + liObj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='" + liObj.data("type")+"'>";
		});
		console.log(str);
		formObj.append(str).submit();
	});
});


  
</script>
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
			<div class="article-bottom">
				<div class="field1 get-th field-style">
					<label><b>첨부파일</b></label>
				</div>
				<div class="field2 get-td">
					<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple />
				</div>
				<div class="uploadResult">
					<ul></ul>
				</div>
			</div>
			<div class="register_submit">
				<button class="register_submit_button" type="submit">작성</button>
				<button class="register_submit_button" type="reset">취소</button>
			</div>
		</form>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>