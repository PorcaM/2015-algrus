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
<body>
<%
	// 데이터베이스 접속을 위한 변수들
	Connection conn 		= null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	String url 				= null;
	String sql 				= null;
	String num 				= null;
	
	// 게시판 형성을 위한 변수들
	String _password 		= null;
	String password 		= null;
	
	try{
		// 데이터베이스에 연결
		Class.forName("com.mysql.jdbc.Driver");
		url = "jdbc:mysql://localhost/12141588";
		conn = DriverManager.getConnection(url, "root", "1234");
		num = request.getParameter("num");
		_password = request.getParameter("password");
		sql = "SELECT * FROM board WHERE NUM="+num;
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			password = rs.getString("PASSWORD");
		}
		if(password.equals(_password)){
			sql = "DELETE FROM board WHERE NUM="+num;
			pstmt.executeUpdate(sql);
%>		
	<script type="text/javascript">
		alert("글이 삭제되었습니다.");
		goUrl('boardList.jsp');
	</script>
<%		
		}
		else{
%>		
	<script type="text/javascript">
		alert("비밀번호가 다릅니다.");
		goUrl('boardList.jsp');
	</script>
<%	
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
</body>
</html>