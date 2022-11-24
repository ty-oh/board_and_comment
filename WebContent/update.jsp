<%@page import="org.joonzis.mybatis.BDao"%>
<%@page import="org.joonzis.mybatis.BVO"%>
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
		BVO vo = new BVO();
		vo.setB_idx(bbsInfo.getB_idx());
		vo.setWriter(bbsInfo.getWriter());
		vo.setTitle(request.getParameter("title"));
		vo.setContent(request.getParameter("content"));
		
		out.println(vo.getB_idx());
		out.println(vo.getWriter());
		out.println(vo.getTitle());
		out.println(vo.getContent());
		
		int result = BDao.updateBbs(vo);
		pageContext.setAttribute("result", result);
	%>
	
	<c:choose>
		<c:when test="${result gt 0 }">
			<script type="text/javascript">
				alert('게시글을 수정하였습니다.');
				var b_idx= "${bbsInfo.b_idx}";
				location.href='view.jsp?b_idx='+b_idx;
			</script>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				alert('게시글을 수정하지 못했습니다.');
				history.back();
			</script>
		</c:otherwise>
	</c:choose>
	
</body>
</html>