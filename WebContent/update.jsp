<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		String realPath = request.getServletContext().getRealPath("/upload");
		MultipartRequest mr = new MultipartRequest(
				request,
				realPath,
				1024*1024*10,
				"utf-8",
				new DefaultFileRenamePolicy()
				);
				
		BVO bvo = new BVO();
		/* 
			첨부파일 수정
			1. 기존 첨부가 있는경우
				1) 새 첨부가 없으면 기존 첨부 그대로 사용
				2) 새 첨부가 있으면 기존 첨부 삭제 후 첨부 사용
			2. 기존 첨부가 없는 경우
				1) 새 첨부 사용
		*/
		File newfile = mr.getFile("filename");
		String oldfile = mr.getParameter("oldfile");
		if(newfile != null) {		// 새 첨부 파일 O
			if(oldfile != null) {	// 기존 첨부 파일 O
				File removeFile = new File(realPath + "/" + oldfile);
				if (removeFile.exists()) {	// 기존 첨부파일 유무 확인
					removeFile.delete();	// 기존 첨부 파일 삭제
				}
			}
			bvo.setFilename(newfile.getName()); // 새 첨부 파일 이름 가져오기
		} else {	// 새 첨부파일 X
			if(oldfile != null) {		// 기존 첨부 파일 O
				bvo.setFilename(oldfile);
			} else {
				bvo.setFilename("");	// 새 첨부파일 X, 기존 첨부파일 X
			}
		}
		 
		bvo.setB_idx(Integer.parseInt(mr.getParameter("b_idx")));
		bvo.setWriter(mr.getParameter("writer"));
		bvo.setTitle(mr.getParameter("title"));
		bvo.setContent(mr.getParameter("content"));
		
		int result = BDao.updateBbs(bvo);
		pageContext.setAttribute("result", result);
		
		String currentPage = mr.getParameter("currentPage");
		pageContext.setAttribute("currentPage", currentPage);
	%>
	<c:choose>
		<c:when test="${result gt 0 }">
			<script type="text/javascript">
				alert('게시글을 수정하였습니다.');
				var b_idx= "${bbsInfo.b_idx}";
				var currentPage="${currentPage}"
				location.href='view.jsp?b_idx='+b_idx+'&currentPage='+currentPage;
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