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
	<style type="text/css">
		div{
			width: 800px;
			margin: auto; 
		}
		table {
			width: 100%;
			text-align: left;
			border-collapse: collapse;
		}
		td, th {
			border : 1px solid #0078aa;
			padding: 10px;
		}
		th {
			background-color: #0078aa;
			color: #fff;
			text-align: center;
		}
		#btn {
			text-align: center;
		}
	</style>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		int b_idx = Integer.parseInt(request.getParameter("b_idx"));
		String currentPage = request.getParameter("currentPage");
		
		BVO bvo = BDao.getBbs(b_idx);
		
		//session open .. 추후
		//수정, 삭제를 위해서 session에 bvo를 저장
		session.setAttribute("bbsInfo", bvo);
		pageContext.setAttribute("currentPage", currentPage);
	%>
	
	<div>
		<h2>${bbsInfo.writer }의 게시글</h2>
		<table>
			<tbody>
				<tr>
					<th>작성자</th>
					<td>${bbsInfo.writer }</td>
				</tr>
				<tr>
					<th>IP</th>
					<td>${bbsInfo.ip }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${bbsInfo.title }</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${bbsInfo.hit }</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<c:choose>
						<c:when test="${bbsInfo.filename eq null }">
							<td>첨부파일이 없습니다.</td>
						</c:when>
						<c:otherwise>
							<td><a href="download.jsp?path=upload&filename=${bbsInfo.filename }">${bbsInfo.filename }</a></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="80" name="content" placeholder="내용을 입력해주세요." readonly>${bbsInfo.content }</textarea></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td>${bbsInfo.reg_date }</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="방명록 수정" onclick="location.href='update_page.jsp'"/>&nbsp;&nbsp;
						<input type="button" value="방명록삭제" onclick="location.href='remove_page.jsp'">&nbsp;&nbsp;
						<input type="button" value="목록으로 이동" onclick="location.href='index.jsp?currentPage=${currentPage }'">
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>