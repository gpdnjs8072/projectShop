<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/review/detail.jsp</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap-theme.min.css">

<style>
/* 글 내용을 출력할 div에 적용할 css */
.contents {
	width: 100%;
	border: 1px dotted #cecece;
	box-shadow: 3px 3px 5px 6px #ccc;
}
/* 댓글에 관련된 css */
.comments ul {
	padding: 0;
	margin: 0;
	list-style-type: none;
}

.comments ul li {
	border-top: 1px solid #888; /* li 의 윗쪽 경계선 */
}

.comments dt {
	margin-top: 5px;
}

.comments dd {
	margin-left: 26px;
}

.comments form textarea, .comments form button {
	float: left;
}

.comments li {
	clear: left;
}

.comments form textarea {
	width: 85%;
	height: 100px;
}

.comments form button {
	width: 15%;
	height: 100px;
}
/* 댓글에 댓글을 다는 폼과 수정폼을 일단 숨긴다. */
.comment form {
	display: none;
}

.comment {
	position: relative;
}

.comment .reply_icon {
	width: 8px;
	height: 8px;
	position: absolute;
	top: 10px;
	left: 30px;
}

.comments .user-img {
	width: 20px;
	height: 20px;
	border-radius: 50%;
}

.star-rating {
	width: 75px;
}

.star-rating, .star-rating span {
	display: inline-block;
	height: 14px;
	overflow: hidden;
	background:
		url(${pageContext.request.contextPath}/resources/images/star.png)
		no-repeat;
}

.star-rating span {
	background-position: left bottom;
	line-height: 0;
	vertical-align: top;
}
</style>
</head>
<body>

<div id="root">
	<header id="heder_box">
		<div>
			<%@ include file="../include/header.jsp" %>
		</div>
	</header>
	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../include/nav.jsp" %>
		</div>
	</nav>
	<section id="container">
		<aside>
			<%@ include file="../include/users_aside.jsp" %>
		</aside>
		<div id="container_box">
			<h3>리뷰 글 상세 보기</h3>
		
			<table class="table table-bordered table-condensed">
				<colgroup>
					<col class="col-xs-3" />
					<col class="col-xs-9" />
				</colgroup>
				<tr>
					<th>글 번호</th>
					<td>${dto.reviewNum }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${dto.reviewWriter }</td>
				</tr>
				<tr>
					<th>별점</th>
					<td><span class="wrap-star"> <span class='star-rating'>
								<span
								style="width:<fmt:formatNumber value="${dto.likeCount *10}" pattern=".0"/>%"></span>
						</span> <c:if test="${dto.likeCount gt 0 }">
								<fmt:formatNumber value="${dto.likeCount }" pattern=".0" />
							</c:if>
					</span></td>
				</tr>
				<tr>
					<th>좋아요</th>
					<td>${dto.upCount }</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>${dto.regdate }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${dto.reviewContent }</td>
				</tr>
			</table>
			<br />
			<br />
		
			<c:if test="${dto.reviewWriter eq userDto.userId }">
				<a
					href="delete.do?reviewNum=${dto.reviewNum}&itemNum=${dto.itemNum } ">삭제하기</a>
				<a
					href="updateform.do?reviewNum=${dto.reviewNum}&itemNum=${dto.itemNum }  ">수정하기</a>
			</c:if>
			<br />
			<br />
			<div class="comments">
				<ul>
					<c:forEach items="${commentList }" var="tmp">
						<c:choose>
							<c:when test="${tmp.deleted ne 'yes' }">
								<li class="comment" id="comment${tmp.num }"
									<c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>
									<c:if test="${tmp.num ne tmp.comment_group }">
										<img class="reply_icon"
											src="${pageContext.request.contextPath}/resources/images/re.gif" />
									</c:if>
									<dl>
										<dt>
		
											<span>${tmp.writer }</span>
											<c:if test="${tmp.num ne tmp.comment_group }">
											to <strong>${tmp.target_id }</strong>
											</c:if>
											<span>${tmp.regdate }</span> <a href="javascript:"
												class="reply_link">답글</a>
											<c:choose>
												<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
												<c:when test="${userDto.userId eq tmp.writer }">
													<a href="javascript:" class="comment-update-link">수정</a>&nbsp;&nbsp;
												<a href="javascript:deleteComment(${tmp.num })">삭제</a>
												</c:when>
												<c:otherwise>
													<a href="javascript:">신고</a>
												</c:otherwise>
											</c:choose>
										</dt>
										<dd>
											<pre>${tmp.content }</pre>
										</dd>
									</dl>
									<form class="comment-insert-form" action="comment_insert.do"
										method="post">
										<!-- 덧글 그룹 -->
										<input type="hidden" name="ref_group" value="${dto.reviewNum }" />
										<!-- 덧글 대상 -->
										<input type="hidden" name="target_id" value="${tmp.writer }" />
										<input type="hidden" name="comment_group"
											value="${tmp.comment_group }" />
										<textarea name="content"><c:if
												test="${empty userDto.userId }">로그인이 필요합니다.</c:if></textarea>
										<button type="submit">등록</button>
									</form> <!-- 로그인한 아이디와 댓글의 작성자와 같으면 수정폼 출력 --> <c:if
										test="${userDto.userId eq tmp.writer }">
										<form class="comment-update-form" action="comment_update.do"
											method="post">
											<input type="hidden" name="num" value="${tmp.num }" />
											<textarea name="content">${tmp.content }</textarea>
											<button type="submit">수정</button>
										</form>
									</c:if>
								</li>
							</c:when>
							<c:otherwise>
								<li
									<c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>삭제된
									댓글 입니다.</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
				<div class="clearfix"></div>
		
				<!-- 원글에 댓글을 작성할 수 있는 폼 -->
		
				<div class="comment_form">
					<form action="comment_insert.do" method="post">
						<!-- 댓글의 그룹번호는 원글의 글번호가 된다.-->
						<input type="hidden" name="ref_group" value="${dto.reviewNum }" />
						<!-- 댓글의 대상자는 원글의 작성자가 된다. -->
						<input type="hidden" name="target_id" value="${dto.reviewWriter}" />
						<textarea name="content">
							<c:if test="${empty userDto.userId }">로그인이 필요합니다</c:if>
						</textarea>
						<button type="submit">등록</button>
					</form>
				</div>
			</div>
		
	
		</div>
	</section>
	<footer id="footer">
			<div id="footer_box">
				<%@ include file="../include/footer.jsp" %>
			</div>
		</footer>
</div>
<script>
	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(".comment-update-link").click(function(){
		$(this)
		.parent().parent().parent()
		.find(".comment-update-form")
		.slideToggle(200);
	});
	
	//댓글 수정 폼에 submit 이벤트가 일어났을때 호출되는 함수 등록
	$(".comment-update-form").on("submit", function(){
		// "comment_update.do"
		var url=$(this).attr("action");
		//폼에 작성된 내용을 query 문자열로 읽어온다.
		// num=댓글번호&content=댓글내용
		var data=$(this).serialize();
		//이벤트가 일어난 폼을 선택해서 변수에 담아 놓는다.
		var $this=$(this);
		$.ajax({
			url:url,
			method:"post",
			data:data,
			success:function(responseData){
				// responseData : {isSuccess:true}
				if(responseData.isSuccess){
					//폼을 안보이게 한다 
					$this.slideUp(200);
					//폼에 입력한 내용 읽어오기
					var content=$this.find("textarea").val();
					//pre 요소에 수정 반영하기 
					$this.parent().find("pre").text(content);
				}
			}
		});
		//폼 제출 막기 
		return false;
	});
	
	//댓글 삭제를 눌렀을때 호출되는 함수
	function deleteComment(num){
		var isDelete=confirm("확인을 누르면 댓글이 삭제 됩니다.");
		if(isDelete){
			//페이지 전환 없이 ajax 요청을 통해서 삭제하기
			$.ajax({
				url:"comment_delete.do",  //"/review/comment_delete.do" 요청
				method:"post",
				data:{"num":num},   //num 이라는 파라미터명으로 삭제할 댓글의 번호 전송
				success:function(responseData){
					if(responseData.isSuccess){
						var sel="#comment"+num;  
						$(sel).text("삭제된 댓글 입니다.");   //아이디가 comment${tmp.num}인 것을 삭제한다.
					}
				}
			});
		}
	}
	
	//폼에 submit 이벤트가 일어 났을때 실행할 함수 등록 
	$(".comments form").on("submit", function(){
		//로그인 여부
		var isLogin=${not empty userDto.userId};
		if(isLogin==false){
			alert("로그인 페이지로 이동 합니다.");
			location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/review/detail.do?reviewNum=${dto.reviewNum}";
			return false;//폼 전송 막기 
		}
	});
	
	//폼에 click 이벤트가 일어 났을때 실행할 함수 등록 
	$(".comments form textarea").on("click", function(){
		//로그인 여부
		var isLogin=${not empty userDto.userId};
		if(isLogin==false){
			var isMove=confirm("로그인 페이지로 이동 하시겠습니까?");
			if(isMove){
				location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/review/detail.do?reviewNum=${dto.reviewNum}";
			}
		}
	});
	
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(".comment .reply_link").click(function(){
		$(this)
		.parent().parent().parent()
		.find(".comment-insert-form")   //세번 올라간 parent의 자손요소에서 ".comment-insert-form"을 찾는다.
		.slideToggle(200);    //접혀있으면 펼치고 펼쳐있으면 접는다.
		
		// 답글 <=> 취소가 서로 토글 되도록 한다. 
		if($(this).text()=="답글"){
			$(this).text("취소");
		}else{
			$(this).text("답글");
		}
	});
	function deleteConfirm(){
		var isDelete=confirm("글을 삭제하시겠습니까?");
		if(isDelete){
			location.href="delete.do?reviewNum=${dto.reviewNum}";
		}
	}
</script>
</body>
</html>