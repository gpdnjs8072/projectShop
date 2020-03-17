<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/qna/updateform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>

<div class="container">
	<ol class="breadcrumb">
		<li><a href="${pageContext.request.contextPath }/qna/list.jsp">목록</a></li>
		<li>글 수정 양식</li>
	</ol>	
	<form action="update.do" method="post">
		<input type="hidden" name="num" value="${dto.num }"/>
		<div class="form-group">
			<label for="num">글번호</label>
			<input class="form-control" type="text" id="num" value="${dto.num }" disabled/>
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<input class="form-control" type="text" id="title" name="title" 
				value="${dto.title }"/>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea class="form-control" name="content" id="content">
				${dto.content }
			</textarea>
		</div>
		<button class="btn btn-primary" type="submit" onclick="submitContents(this);">수정확인</button>
		<button class="btn btn-warning" type="reset">취소</button>
	</form>
</div>

</body>
</html>