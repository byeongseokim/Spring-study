<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시물 읽기</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">읽기 페이지</div>
			<!-- /.panel-heading -->
			<div class="panel-body">


				<div class="form-group">
					<label>번호</label> <input class="form-control" name="bno"
						value='<c:out value="${board.bno}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>제목</label> <input class="form-control" name="Title"
						value='<c:out value="${board.title}"/>' readonly="readonly">
				</div>


				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="3" name="content"
						readonly="readonly"><c:out value="${board.content}" /></textarea>
				</div>

				<div class="form-group">
					<label>작성자</label> <input class="form-control" name="writer"
						value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>

				<button data-oper='modify' class="btn btn-default">수정</button>
				<button data-oper='list' class="btn btn-info">리스트</button>

				<form id='operForm' action="/board/modify" method="get">
					<input type='hidden' id='bno' name='bno'
						value='<c:out value="${board.bno }"/>'> <input
						type='hidden' name='pageNum'
						value='<c:out value="${cri.pageNum}" />'> <input
						type='hidden' name='amount'
						value='<c:out value="${cri.amount}" />'> <input
						type='hidden' name='keyword'
						value='<c:out value="${cri.keyword}" />'> <input
						type='hidden' name='type' value='<c:out value="${cri.type}" />'>
				</form>





			</div>
			<!-- end panel-body -->

		</div>
		<!-- end panel-body -->
	</div>
	<!--  end panel -->
</div>
<!-- /.row -->

<!---------------------------------댓글-------------------------------->
<div class="col-lg-12">
		<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> 댓글
					<button id='addReplyBtn' class='btn-primary btn-xs pull-right'>새 댓글</button>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<ul class="chat">
						<!-- start reply -->
						<li class="left clearfix" data-rno='12'>
							<div>
								<div class="header">
									<strong class="primary-font">user00</strong>
									<small class="pull-right text-muted">2018-01-01 13:13</small>
								</div>
								<p>Good job!</p>
							</div>
						</li>
						<!--  end reply -->
					</ul>
					<!--  ./end ul -->
				</div>
				<!-- ./ end row -->
			</div>
		</div>

<!-- Modal 추가-->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">댓글 추가</h4>
						</div>
						<div class="modal-body">
						
						<div class="form-group">
						<label>댓글</label>
						<input class="form-control" name='reply' value='New Reply!!!!'>
						</div>
						
						<div class="form-group">
						<label>댓글 작성자</label>
						<input class="form-control" name='replyer' value='Replyer'>
						</div>
						
						<div class="form-group">
						<label>댓글 시간</label>
						<input class="form-control" name='replyDate' value=''>
						</div>
						
						</div>
						<div class="modal-footer">
							<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
							<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
							<button id="modalRegisterBtn" type="button" class="btn btn-primary">등록</button>
							<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss='modal'>닫기</button>
							<button id="modalClassBtn" type="button" class="btn btn-default" data-dismiss='modal'>닫기</button>
							<!-- 댓글 모달 닫기 창 안나옴 수정중 -->
							
						</div>
					</div>
					<!-- modal-content -->
				</div>
				<!-- modal-dialog -->
			</div>
			<!-- modal -->




<script src="../resources/js/reply.js"></script>

<script>
$(document).ready(function() {
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page) {
		replyService.getList({bno:bnoValue, page: page||1}, function(list) {
			var str = "";
			if(list == null || list.length==0) {
				replyUL.html("");
				return;
			}
			for(var i=0, len=list.length || 0; i<len; i++) {
				str+= "<li class='left cleafix' data-rno='"+list[i].rno+"'>";
				str+= "    <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
				str+= "        <small class='pull-right text-muted'>" +replyService.displayTime(list[i].replyDate)+"</small></div>";
				str+= "            <p>"+list[i].reply+"</p></div></li>";
			}
			
			replyUL.html(str);
		});
	}
	
	var modal = $(".modal");
    var modalInputReply = modal.find("input[name='reply']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModBtn = $("#modalModBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modalRegisterBtn = $("#modalRegisterBtn");
    
    $("#modalCloseBtn").on("click", function(e){
    	
    	modal.modal('hide');
    });
    
    $("#addReplyBtn").on("click", function(e){
        
        modal.find("input").val("");
        modalInputReplyDate.closest("div").hide();
        modal.find("button[id !='modalCloseBtn']").hide();
        
        modalRegisterBtn.show();
        
        $(".modal").modal("show");
        
      });
	
    modalRegisterBtn.on("click",function(e){
        
        var reply = {
              reply: modalInputReply.val(),
              replyer:modalInputReplyer.val(),
              bno:bnoValue
            };
        replyService.add(reply, function(result){
          
          alert(result);
          
          modal.find("input").val("");
          modal.modal("hide");
          
          showList(-1);
          
         });
        
      });
        
    $(".chat").on("click", "li", function(e) {
		
    	var rno = $(this).data("rno");
		
		replyService.get(rno, function(reply){
			
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
			.attr("readonly","readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id !='midalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");   
	
		});
	});
	
});

	
	
	/* console.log("====================");
	console.log("JS TEST");

	var bnoValue = '<c:out value="${board.bno}"/>';
 */
	//for replyService add test
	/* replyService.add({
		reply : "JS TEST",
		replyer : "tester",
		bno : bnoValue
	}, function(result) {
		alert("RESULT: " + result);
	}); */

	/* replyService.getList({
		bno : bnoValue,
		page : 1
	}, function(list) {

		for (var i = 0, len = list.length || 0; i < len; i++) {
			console.log(list[i]);
		} */

		/* 		 replyService.remove(23, function(count) {
		
		 console.log(count);
		
		 if (count === "success") {
		 alert("REMOVED");
		 }
		 }, function(err) {
		 alert('ERROR...');
		 })
		 }); 
		
		 replyService.update({
		 rno : 22,
		 bno : bnoValue,
		 reply : "Modify Reply......"
		 }, function(result) {
		
		 alert("수정완료...");
		 */


</script>

<script>
	$(document).ready(function() {

		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {

			operForm.attr("action", "/board/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {

			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();
		});
	});
</script>


<%@include file="../includes/footer.jsp"%>
