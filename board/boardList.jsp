<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>  
<%@ page import="java.util.*"%>  
<%@ page import="java.io.*"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<link rel="stylesheet" href="../mainStyle.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function goUrl(url){
			location.href = url;
		}
	</script>
<title>Algrus 게시판 목록</title>
</head>
<body id="index" data-spy="scroll" data-target=".navbar" data-offset="60">
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="../index.html">Algrus</a>
			</div>
		</div>
	</nav>
	<header class="jumbotron text-center">
		<h2>Board</h2>
	</header>
	<section class="container-fluid text-center">
	<form name="searchForm" action="" method="get">
	<p>
		<select name="searchType">
			<option value="TITLE">제목</option>
			<option value="WRITER">작성자</option>
			<option value="CONTENTS">내용</option>
		</select>
		<input type="text" name="searchText" value="">
		<input type="submit" value="검색">
	</p>
	</form>
	<div class="table-responsive talbe-hover">
	<table border="1" class="table">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
<%
	// 데이터베이스 접속을 위한 변수들
	Connection conn 		= null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	String url 				= null;
	String sql 				= null;
	String search 			= "";
	
	// 게시판 형성을 위한 변수들
	int total 		= 0;
	int number 		= 0;
	String writer 	= null;
	String password = null;
	String title 	= null;
	String contents = null;
	String regDate 	= null;
	int hit 		= 0;
	
	try{
		// 데이터베이스에 연결
		Class.forName("com.mysql.jdbc.Driver");
		url = "jdbc:mysql://localhost/12141588";
		conn = DriverManager.getConnection(url, "root", "1234");
		// 총 게시글 수를 요청
		String searchType = request.getParameter("searchType");
		String searchText = request.getParameter("searchText");
		if(searchText != null){
			search = " WHERE " + searchType + " LIKE \"%" + searchText + "%\"";
		}
		sql = "SELECT COUNT(*) FROM board" + search;
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		// 게시글 수를 변수에 저장
		if(rs.next()){
			total = rs.getInt(1);
		}
		
		// 게시글이 없을 때
		if(total == 0){
%>
			<tr align="center">
				<td colspan="6">등록된 글이 없습니다.</td>
			</tr>
<%
		}
		// 있을 때
		else{
			// 모든 게시글 데이터를 요청
			sql = "SELECT * FROM board" + search + " ORDER BY NUM DESC";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			// 데이터가 존재할 때마다 html으로 변환
			while(rs.next()){
				number 	= rs.getInt("NUM");
				writer 	= rs.getString("WRITER");
				title 	= rs.getString("TITLE");
				regDate = rs.getString("REG_DATE");
				hit 	= rs.getInt("HIT");
%>			
			<tr align="center">
				<td><%=number %></td>
				<td>
					<a href="boardView.jsp?number=<%=number%>">
					<%=title %> </a>
				</td>
				<td><%=writer %></td>
				<td><%=regDate %></td>
				<td><%=hit %></td>
			</tr>
<%			
			}
		}
	}
	catch(Exception e){
		e.printStackTrace();
		out.println("ERROR: "+e);
	}
	finally{
		if(rs != null) 		rs.close();
		if(pstmt != null) 	pstmt.close();
		if(conn != null) 	conn.close();
	}
%>
		</tbody>
		<tfoot>
			<tr>
				<td align="center" colspan="5">1</td>
			</tr>
		</tfoot>
	</table>
	</div>
	<p>
		<input type="button" value="목록" onclick="goUrl('boardList.jsp')">
		<input type="button" value="글쓰기" onclick="goUrl('boardWriteForm.jsp')">
	</p>
	</section>
</body>
</html>