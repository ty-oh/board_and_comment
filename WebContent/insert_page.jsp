<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<script type="text/javascript">
		var insert = function(f) {
			if (f.writer.value =='') {
				alert('작성자를 입력해주세요.');
				return;
			}
			if (f.title.value == '') {
				alert('제목을 입력해주세요.');
				return;
			}
			if (f.pw.value == '') {
				alert('비밀번호 입력해주세요.');
				return;
			}
			if (f.content.value == '') {
				alert('내용을 입력해주세요.');
				return;
			}
			
			f.submit();
		}
	</script>
	
</head>
<body>
	<div>
		<h2>게시글 작성</h2>
		<form action="insert.jsp" method="post" enctype="multipart/form-data">
			<table>
				<tbody>
					<tr>
						<th>작성자</th>
						<td><input type="text" name="writer" size="80" /></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="title" size="80" /></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="pw" size="80" /></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td><input type="file" name="filename" /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="10" cols="80" name="content" placeholder="내용을 입력해주세요." style="resize:none"></textarea></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="btn">							
								<input type="button" value="방명록 저장" onclick="insert(this.form)"/>&nbsp;&nbsp;
								<input type="reset" value="다시작성">
								<input type="button" value="목록으로 이동" onclick="location.href='index.jsp'">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>