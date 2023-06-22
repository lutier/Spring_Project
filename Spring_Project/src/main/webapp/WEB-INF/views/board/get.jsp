<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@ include file="../includes/header.jsp" %>
<script src="/resources/js/replyService.js" defer></script>


<script>
$(function() {
   const operForm = $("#operForm");
   $("#list_btn").on("click", function(e) {
      operForm.find("#bno").remove();
      operForm.attr("action","/board/list");
      operForm.submit();
   });
   
   getReplyList();
   function getReplyList(){
	   ReplyService.getList(
			   {bno:'<c:out value="${board.bno}"/>'},
			   function(list){
				 console.log("list: " + list);
				 showReplyList(list);
			   }, 
			   function(error){
				alert(error);   
			   
			   });
   }
   
   
   function showReplyList(){
	   
   }
   
   $("#modify_btn").on("click", function(e) {
      operForm.attr("action","/board/modify").submit();
   });
   
   $("#addReplyBtn").on("click",function(){
		$("#reply").val("");
		$("#modalModBtn").hide();
		$("#modalRegisterBtn").show();
		$("#modalCloseBtn").show();
		$(".modal").modal("show");
	});
   
   $("#modalCloseBtn").on("click",function(){
	   $(".modal").modal("hide");
   });
   
   $("#modalRegisterBtn").on("click",function(){
	   let reply = {reply: $("#reply").val(),
			   replyer: $("#replyer").val(),
			   bno: '<c:out value="${board.bno}"/>'
			   };
	   ReplyService.add(reply,
		   function(result){
	   			alert(result);
	   			$(".modal").modal("hide");
	   			getReplyListWithPaging(pageNum);
   			},
   			function(error){
   				alert(error);
   			});
   });
   
   //reply list with paging
   let pageNum = 1;
   let replyPageFooter = $(".panel-footer");
   
 	getReplyListWithPaging(pageNum);
   function getReplyListWithPaging(pageNum){
	   ReplyService.getListWithPaging(
			{bno:'<c:out value="${board.bno}"/>', page: pageNum},
			function(replyCnt, list){
				console.log("list: " + list);
				showReplyList(list);
				showReplyPaging(replyCnt);
			},
			function (error){
				alert(error);
			});
   }
   
   function showReplyPaging(replyCnt){
	   let endNum = Math.ceil(pageNum / 10.0) * 10;
	   let startNum = endNum - 9;
	   let prev = startNum != 1;
	   let next = false;
	   let str = "";
	   if (endNum * 10 >= replyCnt){
		   endNum = Math.ceil(replyCnt/10.0);
	   }
	   if (endNum * 10 < replyCnt){
		   next = true;
	   }
	   
	   str +="<ul class='pagination'>";
	   if (prev){
		   str += "<li class='paginate_button'><a href='"+(startNum -1)+"'>Previous</a></li>";
	   }
	   for (let i = startNum; i<=endNum; i++){
		   let active = pageNum == i? "active_list":"";
		   str += "<li calss='paginate_button "+active+" '><a href='"+i+"'>"+i+"</a></li>";
	   }
	   if(next){
		   str += "<li calss='paginate_button'><a href='"+(endNum +1)+"'>Next</a></li>";
	   }
	   str += "</ul></div>";
	   console.log(str);
	   replyPageFooter.html(str);
    }
   
   //paging
   replyPageFooter.on("click", "li a", function(e){
	   e.preventDefault();
	   console.log("page click");
	   let targetPageNum = $(this).attr("href");
	   console.log("targetPageNum: " + targetPageNum);
	   pageNum = targetPageNum;
	   getReplyListWithPaging(pageNum);
   });
   
   
   
   
   function showReplyList(list){
		let str = "";
		let replyUL = $(".reply");
		if(list == null || list.length == 0){
			replyUL.html(str);
			return;
		}
		
		for(var i=0, len = list.length || 0; i<len; i++){
			str +="<li>";
			str +="	<div>";
			str +="		<div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
			str +="			<small class='pull-right text-muted'>"+ReplyService.displayTime(list[i].regdate)+"</small>";
			str +="		</div>";
			str +="		<div data-rno='"+ list[i].rno +"' data-replyer='" + list[i].replyer + "'>";
			str +="			<strong id='modify' class='primary-font'>"+list[i].reply+"</strong>";
			if("${auth.user_id}" === list[i].replyer){
				str +="		<button id='remove' type='button' class='close' data-rno='" + list[i].rno + "'>";
				str +="			<span>x</span></button>";
			}
			str +="		</div>";
			str +="	</div>";
			str +="</li>";
		}
		replyUL.html(str);
	}
   
   // modify reply
   $(".reply").on("click", "li #modify", function(e){
	   let replyer = $(this).parent().closest('div').data("replyer");
	   let rno = $(this).parent().closest('div').data("rno");
	   let auth = "${auth.user_id}";
	   if(auth !== replyer){
		   return;
	   }
	
	   //alert('modify ' + auth + ' ' + replyer + ' ' + rno);
	   ReplyService.get(rno, function(reply){
		   $("#reply").val(reply.reply);
		   $("#replyer").val(reply.replyer);
		   $(".modal").data("rno", reply.rno);
		   $("#modalModBtn").show();
		   $("#modalRegisterBtn").hide();
		   $(".modal").modal("show");
	   });
   });
   
   $("#modalModBtn").on("click", function(e){
	   let reply = { reply: $("#reply").val(), rno:$(".modal").data("rno")};
	   ReplyService.update(reply, function(result){
		   alert(result);
		   $(".modal").modal("hide");
		   getReplyListWithPaging(pageNum);
	   }, function(error){
		   alert(error);
	   });
   });
   
   $(".reply").on("click", "li #remove",function(e){
	   
	   let rno = $(this).parent().closest('div').data("rno");
	   ReplyService.remove(rno,
			   function(result){
		   			alert(result);
		   			getReplyListWithPaging(pageNum);
	   },
	   function(error){
		   alert(error);
	   });
	   alert(rno + "번 댓글을 삭제 했습니다.");
   });
   
   let bno = '<c:out value="${board.bno}"/>';
   $.getJSON("/board/getAttachList/"+bno, function(attachList){
	   console.log(attachList);
	   let str = "";
	   $(attachList).each(function(i, attach){
		   if(attach.filetype) {
			   let fileCallPath = encodeURIComponent(attach.uploadpath+"/s_"+attach.uuid+"_"+attach.filename);
			   str += "<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"'";
			   str += "	data-type='"+attach.filetype+"'>";
			   str += "	<div>";
			   str += "		<span> "+attach.filename+"</span><br>";
			   str += "		<img src='/display?filename="+fileCallPath+"'/>";
			   str += "	</div>";
			   str += "</li>";
		   } else {
			   str += "<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"'";
			   str += "	data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>";
			   str += "	<div>";
			   str += "		<span> "+ attach.filename+"</span><br>";
			   str += "		<img src='/resources/img/attach.png' width='100px' height='100px'/>";
			   str += "	</div>";
			   str += "</li>";
		   }
	   });
	   $(".uploadResult ul").html(str);
   });
   
   function showImage(fileCallPath){
	   $(".bigPictureWrapper").css("display","flex").show();
	   $(".bigPicture").html("<img src='/display?filename="+fileCallPath+"'>").animate({width:'100%', top:'0'}, 600);
   }
   $(".uploadResult").on("click", "li", function(e){
	   console.log("view Image");
	   let liObj = $(this);
	   let path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
	   console.log(path);
	   if(liObj.data("type")){
		   showImage(path);
	   } else {
		   if(path.toLowerCase().endsWith("pdf")){
			   //new window
			   window.open("/pdfviewer?filename="+path);
		   } else {
			   //download
			   self.location = "/downloadFile?filename="+path;
		   }
	   }
   });
   $(".bigPictureWrapper").on("click", function(e){
	   $(".bigpictureWrapper").hide();
	   $(".bigPicture").css("top", "15%");
   });
   
   
});

</script>

<<style>
	.bigPictureWrapper{position: fixed/*absolute*/; display:none; left:0px; justify-content:center; align-items:center; top:0; 
		width:100%; height:100%; backgrount-color:gray; z-index:1100; background:rgba(0,0,0,0,5);}
	.bigPicture{position:relative; display:flex; justify-content:center; align-content:center; top:15%; left:0;}
	.bigPicture img{width:650px;}
</style>

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
	<div class="article-bottom">
		<div class="field3 get-th fielr-style">
			<p><b>첨부파일</b></p>
		</div>
		<div class="field3 get-td">
			<div class="uploadResult">
				<ul></ul>
			</div>
		</div>
	</div>
	<div class="read_bottom">
		<button class="read_button" id="list_btn">목록</button>
		<c:if test="${auth.user_id eq board.writer }">
			<button class="read_button" id="modify_btn">수정</button>
			<button type="submit" data-oper='remove' class="read_button">삭제</button>
		</c:if>
		<form id='operForm' action="/board/modify" method="get">
			<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
			<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
			<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
		</form>
	</div>
	<div class="read_reply">
		<c:if test="${not empty auth }">
			<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글 작성</button>
		</c:if>
	</div>
	<div>
		<h4>댓글 목록</h4>
	</div>
	<div class="reply_list">
		<ul class="reply"></ul>
		<div class="panel-footer"></div>
	</div>
	
	<!-- modal -->
	<div class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">REPLY MODAL</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label>
						<input class="form-control" id='reply' name='reply'>
					</div>
					<div class="form-group">
						<label>Replyer</label>
						<input class="form-control" id='replyer' name='replyer' value="${auth.user_id }" readonly="readonly">
					</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
						<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
						<button id='modalCloseBtn' type="button" class="btn btn-btn-info">Close</button>					
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>
	
<%@include file="../includes/footer.jsp" %>