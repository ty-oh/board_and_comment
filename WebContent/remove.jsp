<%@page import="org.joonzis.mybatis.BVO"%>
<%@page import="org.joonzis.mybatis.BDao"%>
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
		BVO bbsInfo = (BVO)session.getAttribute("bbsInfo"); 
		
		int result = BDao.removeBbs(bbsInfo.getB_idx());
	%>
	<script type="text/javascript">
		location.href='index.jsp';
	</script>
</body>
</html>