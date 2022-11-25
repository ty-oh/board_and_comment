<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.joonzis.model.Paging"%>
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
		// 1. Paging 객체 생성
		Paging pvo = new Paging();
		
		// 2. 전체 게시글의 개수 구하기
		pvo.setTotalRecord(BDao.totalRecord());
		
		// 3. 전체 페이지 개수 구하기
		pvo.setTotalPage();
		
		// 4. 현재 페이지 번호 구하기
		String currentPage = request.getParameter("currentPage");
		if (currentPage != null && !currentPage.isEmpty()) {
			pvo.setNowPage(Integer.parseInt(currentPage));
		}
		
		//5. 현재 페이지 번호에 따른 begin, end 구하기
		pvo.setBegin((pvo.getNowPage()-1) * pvo.getRecordPerPage() + 1);
		pvo.setEnd(pvo.getBegin() + pvo.getRecordPerPage() - 1);
		//---------------begin, end 사이의 게시글을 DB에서 가져오기.
		//1. begin, end 변수 지정;
		int begin = pvo.getBegin();
		int end = pvo.getEnd();
		
		//2. begin, end를 저장하는 Map 생성
		Map<String, Integer> map = new HashMap<>();
		map.put("begin", begin);
		map.put("end", end);

		List<BVO> list = BDao.getList(map);
		pageContext.setAttribute("list", list);
		
		/*****페이징 처리를 위한 block  계산****/
		//1. beginBlock, endBlock 계산
		pvo.setBeginBlock((pvo.getNowPage()-1) / pvo.getPagePerBlock() * pvo.getPagePerBlock() + 1);
		pvo.setEndBlock(pvo.getBeginBlock() + pvo.getPagePerBlock() -1);
		
		//2. endBlock 조정하기
		if(pvo.getEndBlock() > pvo.getTotalPage()) {
			pvo.setEndBlock(pvo.getTotalPage());
		}
		
		//3. 화면에서 페이징 사용할수 있도록 객체에 저장
		pageContext.setAttribute("pvo", pvo);
		
		//4. 게시물이 열린 경우 session에 저장
		String open = (String)session.getAttribute("open");
		if (open != null) {
			session.removeAttribute("open");
		}
		
	%>
	<div class="wrap">
		<h1>BBS 게시판</h1>
		<form action="insert_page.jsp">
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
									<td><a class="view" href="view.jsp?b_idx=${vo.b_idx }&currentPage=${pvo.nowPage}">${vo.title}</a></td>
									<td>${vo.writer}</td>
									<td>${vo.reg_date}</td>
									<td>${vo.hit}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5">
							<%-- 페이징 처리예정 --%>		
							<%-- 1. 이전 버튼 --%>				
							<c:choose>
								<c:when test="${pvo.beginBlock <= pvo.pagePerBlock }">
										<span class ="disable"> ◀ &nbsp; </span>
								</c:when>
								<c:otherwise>
										<a class="view" href="index.jsp?currentPage=${pvo.beginBlock - 1 }"> ◀ &nbsp; </a>
								</c:otherwise>
							</c:choose>		
							<%-- 2. 페이지 번호 --%>			
							<c:forEach var="p" begin="${pvo.beginBlock }" end="${pvo.endBlock }" step="1">
								<c:choose>
									<c:when test="${p eq pvo.nowPage }">
										<span class="now">${p }&nbsp;</span>
									</c:when>
									<c:otherwise>
										 <a class="view" href="index.jsp?currentPage=${p}"> ${p }&nbsp;</a>
									</c:otherwise>
								</c:choose>	
							</c:forEach>		
							<%-- 3. 다음 버튼 --%>						
							<c:choose>
								<c:when test="${pvo.endBlock >= pvo.totalPage  }">
									<span class ="disable"> &nbsp;▶ </span>
								</c:when>
								<c:otherwise>
									<a class="view" href="index.jsp?currentPage=${pvo.beginBlock + pvo.pagePerBlock }" > &nbsp;▶ </a>
								</c:otherwise>
							</c:choose>	
						</td>
					</tr>
				</tfoot>
			</table>
			<p>
				<input type="submit" value="게시글 작성">
			</p>
		</form>
	</div>
</body>
</html>