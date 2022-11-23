<%@page import="org.joonzis.mybatis.BDao"%>
<%@page import="org.joonzis.mybatis.BVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	/* 
		데이터가 DB로 넘어가는 순서
		insert_page -> insert -> BDao -> bbs.xml -> DB
		-- insert_page에서 넘어온 parameter들은 insert.jsp에서 BVO로 만들어지고,
		BVO를 BDao로 전달 후 bbs.xml로 전달
	 */
	 
	 //vo.setIp(request.getRemoteAddr()); // IPv6
	 //vo.setIp(InetAddress.getLocalHost().getHostAddress()); // IPv4
	
	 String realPath = request.getServletContext().getRealPath("/upload");
	 
	 MultipartRequest mr = new MultipartRequest(
			 request,
			 realPath,
			 1024*1024*10,
			 "utf-8",
			 new DefaultFileRenamePolicy()
			 );
	 
	 BVO vo = new BVO();
	 vo.setWriter(mr.getParameter("writer"));
	 vo.setTitle(mr.getParameter("title"));
	 vo.setPw(mr.getParameter("pw"));
	 vo.setContent(mr.getParameter("content"));
	 vo.setIp(InetAddress.getLocalHost().getHostAddress());
	 
	 if (mr.getFile("filename") != null) {
		 vo.setFilename(mr.getFilesystemName("filename"));
	 } else {
		 vo.setFilename("");
	 }
	 
	 int result = BDao.insertBbs(vo);
	 pageContext.setAttribute("result", result);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${result gt 0 }">
			<script type="text/javascript">
				alert('게시글을 작성하였습니다.');
				location.href = 'index.jsp';
			</script>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				alert('게시글을 실패하였습니다.');
				location.href = 'index.jsp';
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>