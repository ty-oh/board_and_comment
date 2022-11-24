<%@page import="org.joonzis.mybatis.CDao"%>
<%@page import="org.joonzis.mybatis.BDao"%>
<%@page import="java.net.Inet4Address"%>
<%@page import="org.joonzis.mybatis.CVO"%>
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
	
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		String pw = request.getParameter("pw");
		String ip = Inet4Address.getLocalHost().getHostAddress();
		int b_idx = Integer.parseInt(request.getParameter("b_idx"));
		
		CVO cvo = new CVO();
		cvo.setWriter(writer);
		cvo.setContent(content);
		cvo.setPw(pw);
		cvo.setIp(ip);
		cvo.setB_idx(b_idx);
		
		int result = CDao.insertComment(cvo);
		pageContext.setAttribute("result", result);
		pageContext.setAttribute("b_idx", b_idx);
		pageContext.setAttribute("currentPage", request.getParameter("currentPage"));
	%>
	
	<c:choose>
		<c:when test="${result gt 0}">
			<script type="text/javascript">
				alert('댓글을 입력하였습니다.');
				var b_idx='${b_idx}';
				var currentPage ='${currentPage}';
				location.href='view.jsp?b_idx='+b_idx+'&currentPage='+currentPage;
			</script>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				alert('댓글을 입력을 실패하였습니다...');
				location.href='view.jsp/';
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>