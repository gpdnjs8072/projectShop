<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<jsp:include page="/resources/style/total.jsp"></jsp:include>
</head>
<body>
	<div id="root">
		<header>
			<div class="header_box">
				<nav id="nav">
					<div class="navbar-right">
						<%@ include file="../include/nav.jsp"%>
					</div>
					<div id="index_logo_div">
						<a href="../index.do"><img id="index_logo_img"
							src="${pageContext.request.contextPath }/resources/images/project.png" /></a>
					</div>
					<div class="navbar-left">
						<c:choose>
							<c:when test="${not empty sessionScope.id }">
								<%@ include file="../include/users_aside.jsp"%>
							</c:when>
							<c:otherwise>
								<%@ include file="../include/unknown_aside.jsp"%>
							</c:otherwise>
						</c:choose>
					</div>
				</nav>

			</div>
		</header>
	</div>
	<div class="container">
		<ol class="breadcrumb">
			<li><a
				href="${pageContext.request.contextPath }/Users_Item/itemView_form.do?itemNum=${itemNum}&pageNum=1&reviewNum=1">목록</a></li>
			<li>새글 작성</li>
		</ol>
		<form action="insert.do" method="post">
			<input type="hidden" name="itemNum" value="${itemNum }" />
			<div class="form-group">
				<label for="writer">작성자</label> <input class="form-control"
					type="text" value="${id }" disabled />
			</div>
			<div class="form-group">
				<label for="title" style="margin-right: 14px;">제목</label> <input class="form-control"
					type="text" name="title" id="title" />
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea class="form-control" name="content" id="content" cols="30" rows="10"></textarea>
				<script type="text/javascript">
					$(function() {
						CKEDITOR.replace('content',{
							filebrowserUploadUrl : '${pageContext.request.contextPath }/fileupload.do'
						});
					});
				</script>
			</div>
			<div class="sbtn">
			<button class="btn" type="submit" id="insertBtn">저장</button>
			<button class="btn" type="reset">초기화</button>
			</div>
			<!--  뒤로가기 버튼 삭제
			<button class="btn btn-danger" type="button" id="btn_back">뒤로가기</button>
			<script>
				$("#btn_back").click(function() {
					location.href = "${pageContext.request.contextPath }/Users_Item/itemView_form.do?itemNum="
								+ ${itemNum}+"&pageNum=1&reviewNum=1";
				})
			</script>  -->
			<script>
				$("#insertBtn").on("click",function(){
					//제출 전 제목을 변수에 저장
					var title=$("#title").val();
					if(title==""){
						alert("제목을 입력하세요.",function(){
							//제목에 포커스 on
							$("#title").focus();
						},"warning");
						return false;
					}
					
					//제출 전 에디터 내용을 변수에 저장
					var content=CKEDITOR.instances.content.getData();
					//제출 전 에디터 내용 길이를 변수에 저장
					var content_len=CKEDITOR.instances.content.getData().length;
					//내용이 없는 경우
					if(content==""){
						alert("내용을 입력하세요.",function(){
							//에디터 내용에 포커스 on
							CKEDITOR.instances.content.focus();
							
						},"warning");
						return false;
					}
					//내용이 30글자 미만인 경우
					//기본적으로 8글자를 가짐 빈문자열+<p></p> =8글자
					if(content_len<38){
						alert("내용을  30자 이상 입력하세요.",function(){
							//에디터 내용에 초기화
							CKEDITOR.instances.content.setData("");
							//에디터 내용에 포커스 on
							CKEDITOR.instances.content.focus();
						},"warning");
						return false;
					}
				});
			</script>
		</form>
	</div>

</body>
</html>