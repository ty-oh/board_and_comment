<%@page import="org.joonzis.mybatis.CDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		int c_idx = Integer.parseInt(request.getParameter("c_idx"));
		int b_idx = Integer.parseInt(request.getParameter("b_idx"));
		String currentPage = request.getParameter("currentPage");

		int result = CDao.removeComment(c_idx);
		
		response.sendRedirect("view.jsp?b_idx=" + b_idx + "&currentPage=" + currentPage);
	%>
</body>
</html>