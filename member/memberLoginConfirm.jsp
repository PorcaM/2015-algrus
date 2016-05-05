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
<title>Algrus 로그인</title>
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
		
		// ID check
		sql 	= "SELECT * FROM member WHERE ID="+id;
		pstmt 	= conn.prepareStatement(sql);
		rs 		= pstmt.executeQuery();
		
		if(rs.next()){
			if(password.equals(rs.getString("PASSWORD"))){
				// get user information
				name 	= rs.getString("NAME");
				age 	= rs.getString("AGE");
				email 	= rs.getString("EMAIL");
				stuNum 	= rs.getString("STU_NUM");
				comment = rs.getString("COMMENT");
				%>
				<script>
					alert("로그인 가욧!!!!!");
					var msg = "name: "+ "<%=name %>"+ "\nage: "+ "<%=age %>"+ "\nemail: "+ "<%=email %>" +
					"\nstuNum: "+ "<%=stuNum %>"+ "\ncomment: "+ "<%=comment %>";
					alert(msg);
					goUrl('memberLogin.jsp');
				</script>
				<%
			}
			else{
				%>
				<script type="text/javascript">
					alert("비밀번호가 틀렸습니다.");
					goUrl('memberLogin.jsp');
				</script>
				<%
			}
		}
		else{
			%>
			<script type="text/javascript">
				alert("아이디가 없습니다.");
				goUrl('memberLogin.jsp');
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