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
<%
	// 데이터베이스 접속을 위한 변수들
	Connection conn 		= null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	String url 				= null;
	String sql 				= null;
	String num 				= null;
	
	// 게시판 형성을 위한 변수들
	String writer 	= null;
	String title 	= null;
	String contents = null;
	int hit 		= 0;
	
	try{
		// 데이터베이스에 연결
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
			contents = rs.getString("CONTENTS");
			hit 	= rs.getInt("HIT");
			sql = "UPDATE board SET HIT=? WHERE NUM="+num;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hit+1);
			pstmt.executeUpdate();
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
	<h3>게시글 보기</h3>
	<hr>
    <section class="container-fluid text-center">
        <div class="table-responsive talbe-hover">
            <table class="table">
                <thead>
                    <tr class="col-sm-12">
                        <td class="col-md-3">제목</td>
                        <td class="col-md-9"><%=title %></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>작성자</td>
                        <td><%=writer %></td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td><%=contents %></td>
                    </tr>
                </tbody>
            </table>
            <p>
                <input type="submit" value="수정하기" onclick="goUrl('boardModify.jsp?number=<%=num %>')">
                <input type="submit" value="삭제하기" onclick="goUrl('boardDelete.jsp?number=<%=num %>')">
                <input type="button" value="목록으로" onclick="goUrl('boardList.jsp')">
            </p>
        </div>
    </section>
</body>
</html>