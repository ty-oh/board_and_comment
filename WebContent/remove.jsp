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
		request.setCharacterEncoding("utf-8");
		BVO bbsInfo = (BVO)session.getAttribute("bbsInfo"); 
		
		int result = BDao.removeBbs(bbsInfo.getB_idx());
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