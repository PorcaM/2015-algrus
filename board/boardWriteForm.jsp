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
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#">LOGIN</a></li>
					<li><a href="../extra/beFat.html">BEFAT</a></li>
					<li><a href="#about">ABOUT</a></li>
					<li><a href="#services">SERVICES</a></li>
					<li><a href="#maps">MAPS</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<header class="jumbotron text-center">
		<h2>Board</h2>
	</header>
	<!--게시판 작성하기-->
	<h3>게시판 작성하기</h3>
	<hr>
	<form role="form">
		<div class="form-group">
			<div class="form-group col-xs-6">
				<label class="control-label" for="writer">이름</label>
				<input class="form-control" type="text" id="writer" name="WRITER" required>
			</div>
			<div class="form-group col-xs-6">
				<label class="control-label" for="pwd">비밀번호</label>
				<input class="form-control" type="password" id="pwd" name="PASSWORD" required>
			</div>
			<div class="form-group col-xs-12">
				<label class="control-label" for="title">제목</label>
				<input class="form-control" type="text" id="title" name="TITLE" required>
			</div>
			<div class="form-group col-xs-12">
				<label class="control-label" for="contents">내용</label>
				<textarea class="form-control" rows="10" id="contents" name="CONTENTS"></textarea>
			</div>
			<div class="form-group col-xs-12">
				<input type="submit" class="btn btn-default" value="작성하기">
				<input type="button" class="btn btn-default" value="목록으로" onclick="goUrl('boardList.jsp')">
			</div>
		</div>
	</form>
<%
	// 데이터베이스 접속을 위한 변수들
	Connection conn 		= null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	String url 				= null;
	String sql 				= null;
	
	// 게시판 형성을 위한 변수들
	String writer 	= null;
	String password = null;
	String title 	= null;
	String contents = null;
	String regDate 	= null;
	
	try{
		request.setCharacterEncoding("UTF-8");
		// 데이터베이스에 연결
		Class.forName("com.mysql.jdbc.Driver");
		url = "jdbc:mysql://localhost/12141588?useUnicode=true&characterEncoding=utf8";
		conn = DriverManager.getConnection(url, "root", "1234");
		Calendar c = Calendar.getInstance();
		String date = Integer.toString(c.get(Calendar.YEAR)) + "-";
		date = date + Integer.toString(c.get(Calendar.MONTH)+1) + "-";
		date = date + Integer.toString(c.get(Calendar.DATE));
		writer 		= request.getParameter("WRITER");
		password 	= request.getParameter("PASSWORD");
		title 		= request.getParameter("TITLE");
		contents 	= request.getParameter("CONTENTS");
		sql = "INSERT INTO board (WRITER, PASSWORD, TITLE, CONTENTS, REG_DATE, HIT) VALUES (?,?,?,?,?,0)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, writer);
		pstmt.setString(2, password);
		pstmt.setString(3, title);
		pstmt.setString(4, contents);
		pstmt.setString(5, date);
		
		pstmt.executeUpdate();
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
</body>
</html>