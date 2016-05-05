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
<title>Algrus 게시판</title>
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
<%
	Connection conn 		= null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	String url 				= null;
	String sql 				= null;
	String num 				= null;
	String writer 			= null;
	String title			= null;
	String password			= null;
	String contents			= null;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		url = "jdbc:mysql://localhost/12141588";
		conn = DriverManager.getConnection(url, "root", "1234");
		num = request.getParameter("number");
		sql = "SELECT * FROM board WHERE NUM="+num;
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			writer 	= rs.getString("WRITER");
			title 	= rs.getString("TITLE");
			contents = rs.getString("contents");
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
	<form role="form" method="post" action="boardModifyConfirm.jsp?num=<%=num %>">
		<div class="form-group">
			<input style="display:none"name="number" value="<%=num %>">
			<div class="form-group col-xs-6">
				<label class="control-label" for="writer">이름</label>
				<input class="form-control" type="text" id="writer" name="writer" required value="<%=writer %>">
			</div>
			<div class="form-group col-xs-6">
				<label class="control-label" for="password">비밀번호</label>
				<input class="form-control" type="password" id="pwd" name="password" required>
			</div>
			<div class="form-group col-xs-12">
				<label class="control-label" for="title">제목</label>
				<input class="form-control" type="text" id="title" name="title" required value="<%=title %>">
			</div>
			<div class="form-group col-xs-12">
				<label class="control-label" for="contents">내용</label>
				<textarea class="form-control" rows="10" id="contents" name="contents"><%=contents %></textarea>
			</div>
			<div class="form-group col-xs-12">
				<input type="submit" class="btn btn-default" value="수정">
				<input type="button" class="btn btn-default" value="취소" onclick="goUrl('boardList.jsp')">
			</div>
		</div>
	</form>
</body>
</html>