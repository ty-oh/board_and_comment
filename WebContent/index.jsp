<%@page import="org.joonzis.mybatis.BDao"%>
<%@page import="org.joonzis.mybatis.BVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
	   div {
	      width: 800px;
	      margin:auto;
	      text-align: center;   
	   }
	   
	   table {
	      width: 800px;
	      border-collapse: collapse;   
	   }
	   
	   td, th {
	      border : 1px solid #1e90ff;
	      padding: 10px;
	   }
	   
	   thead { 
	      background-color: #0078aa;
	      color: white;   
	   }
	      
	   th:nth-of-type(1) {
	      width:50px;
	   }
	   
	   th:nth-of-type(2) {
	      width:300px;
	   }
	   
	   th:nth-of-type(3) {
	      width:100px;
	   }
	   
	   th:nth-of-type(4) {
	      width:100px;
	   }   
	   
	   th:nth-of-type(5) {
	      width:50px;
	   }   
	   
	   h1 {
	      color : #0078aa;   
	   }
	   a.view {
	      text-decoration: none;
	      color : black;
	   }
	   a.view:hover {
	      font-weight:bold;
	      color : tomato;
	   }
	   ul.paging {
	      list-style-type: none;
	      overflow: hidden;
	      margin: auto;
	      width:350px;
	   }
	   ul.paging li {
	      float: left;
	      margin:20px;
	      color: #0078ff;
	   
	   }
	   ul.paging li a{
	      font-weight: bold;
	      display : block;
	      text-decoration: none;
	      color:  #0078ff;
	   }
	   ul.paging a:hover {
	       background: #1e90ff;
	       color: white;       
	   }
	   ul.paging li.disable {
	      color: silver;
	   }
	   ul.paging li.now{
	      color: tomato;
	      font-weight: bold;
	   }
	   tfoot tr {
	      margin: auto;
	   }
	   .disable {
	      color: silver;
	   }
	   .now{
	      color: tomato;
	      font-weight: bold;
	   }
	</style>
</head>
<body>
	<%
		List<BVO> list = BDao.getList();
		pageContext.setAttribute("list", list);
	%>
	<div class="wrap">
		<h1>BBS 게시판</h1>
		<form action="">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list }">
							<tr>
								<td colspan="5">게시물이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="vo" items="${list }">
								<tr>
									<td>${vo.b_idx}</td>
									<td>${vo.title}</td>
									<td>${vo.writer}</td>
									<td>${vo.reg_date}</td>
									<td>${vo.hit}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
			<p>
				<input type="submit" value="게시글 작성">
			</p>
		</form>
	</div>
</body>
</html>