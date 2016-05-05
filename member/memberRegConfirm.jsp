<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>  
<%@ page import="java.io.*"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		function goUrl(url){
			location.href = url;
		}
	</script>
<title>Algrus 회원가입</title>
</head>
<body>
<%
	Connection conn 		= null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	String url 				= null;
	String sql 				= null;
	
	String id 				= null;
	String password 		= null;
	String name 			= null;
	String age 				= null;
	String email 			= null;
	String stuNum 			= null;
	String comment 			= null;
	
	try{
		// Connect to database
		Class.forName("com.mysql.jdbc.Driver");
		url 	= "jdbc:mysql://localhost/12141588"; 	// Database
		conn 	= DriverManager.getConnection(url, "root", "1234");
		
		// Get information about register
		id  	= request.getParameter("ID");
		password= request.getParameter("PASSWORD");
		name 	= request.getParameter("NAME");
		age 	= request.getParameter("AGE");
		email 	= request.getParameter("EMAIL");
		stuNum 	= request.getParameter("STU_NUM");
		comment = request.getParameter("COMMENT");
		
		// ID check
		sql 	= "SELECT ID FROM member WHERE ID="+id;
		pstmt 	= conn.prepareStatement(sql);
		rs 		= pstmt.executeQuery();
		
		// Already instance ID(FAIL)
		if(rs.next()){
%>
			<script type="text/javascript">
				alert("이미 존재하는 ID입니다.");
				goUrl("memberReg.jsp");
			</script>
<%
		}
		
		// Save db
		sql 	= "INSERT INTO member (ID, PASSWORD, NAME, AGE, EMAIL, STU_NUM, COMMENT) VALUES (?, ?, ?, ?, ?, ?, ?)";
		pstmt 	= conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, age);
		pstmt.setString(5, email);
		pstmt.setString(6, stuNum);
		pstmt.setString(7, comment);
		pstmt.executeUpdate();
		%>
			<script type="text/javascript">
				alert("가입되었습니다");
				goUrl("memberLogin.jsp");
			</script>
		<%
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