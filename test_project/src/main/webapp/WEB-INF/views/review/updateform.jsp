<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<title>/review/updateform.jsp</title>
</head>
<style>
 #star_grade a{
    text-decoration: none;
    color: gray;
}
#star_grade a.on{
    color: red;
}
.star_rating a:first-child {margin-left:0;}
.star_rating a.on {color:#777;}
</style>
<body>
<div class="container">
	<form action="update.do" method="post">
		<input type="hidden" name="itemNum" value="${dto.itemNum }" />
		<input type="hidden" name="reviewNum" value="${dto.reviewNum }" />
		<input type="hidden" name="reviewWriter" value="${sessionScope.userDto.userId }" />
		<input type="hidden" id="likeCount" name="likeCount" value=2 />
		<div class="container">
			<label for="reviewContent">상품 리뷰</label>
			<input type="text" name="reviewContent" id="reviewContent" value="${dto.reviewContent }" />
		</div>
		<div class="container">
		<p id="star_grade">
			<a href="#">★</a>
			<a href="#">★</a>
			<a href="#">★</a>
			<a href="#">★</a>
			<a href="#">★</a>
		</p>
		</div>
		<button type="submit" >수정확인</button>
		<button type="reset">취소</button>
		<button type="button" id="back_btn" class="btn btn-warning">취소</button>
			<script>
				$("#back_btn").click(function(){
					location.href="itemView_form.do?itemNum=" + ${dto.itemNum};
				})
			</script>
	</form>
</div>
<script>
	$('#star_grade a').click(function(){
	    $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
	    $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
	      var likeCount = document.querySelectorAll(".on").length*2;
	      $("#likeCount").val(likeCount);
	    return false;
	});
</script>
</body>
</html>