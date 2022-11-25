<%@page import="org.joonzis.mybatis.CDao"%>
<%@page import="org.joonzis.mybatis.BVO"%>
<%@page import="org.joonzis.mybatis.BDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		/* 
			comment_t 테이블에서 b_idx를 외래키로 가지고 있기 떄문에
			comment가 있을때 해당글을 바로 삭제 할수 없다.
			이를 해결하기 위한 방법으로 크게 두가지가 있다.
			1. 제약조건에 cascading을 사용하여 연쇄적으로 삭제 할수 있다.
				-> 편리하나 위험하기 때문에 추천하지 않음
			2. 트랜젝션을 활용하여 해당글의 댓글을 삭제하고 글을 삭제하는
			   과정을 하나의 작업으로 묶어준다.
				-> 코드가 좀 길어질 수는 있으나 이 방법을 추천
		*/
		
		request.setCharacterEncoding("utf-8");
		BVO bbsInfo = (BVO)session.getAttribute("bbsInfo");
		
		int result = 0;
		/* 
		boolean hasComment = CDao.countComment(bbsInfo.getB_idx()) > 0;
		
		if (hasComment) {
			boolean isCommentRemoved = (CDao.removeAllComment(bbsInfo.getB_idx()) > 0);
			if (isCommentRemoved) {
				result = BDao.removeBbs(bbsInfo.getB_idx());
				System.out.println(result);
			}
			
		} else {
			result = BDao.removeBbs(bbsInfo.getB_idx());
			
		} */
		
		
		result = BDao.removeBbs(bbsInfo.getB_idx());
		pageContext.setAttribute("result", result);
	%>
	<c:choose>
		<c:when test="${result gt 0 }">
			<script type="text/javascript">
				alert('게시글을 삭제하였습니다.');
				location.href='index.jsp';
			</script>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				alert('게시글을 삭제하지 못했습니다.');
				history.go(-2);
			</script>
		</c:otherwise>
	</c:choose>
	
</body>
</html>