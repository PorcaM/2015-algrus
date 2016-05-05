<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	String num = request.getParameter("number");
%>
	<form method="post" action="boardDeleteConfirm.jsp?num=<%=num %>">
		<table>
			<thead>
				<tr>삭제합니다</tr>
			</thead>
			<tbody>
				<td>
					비밀번호
				</td>
				<td>
					<input type="password" name="password" required>
				</td>
			</tbody>
		</table>
		<p>
			<input type="submit" value="삭제">
			<input type="button" value="취소" onclick="goUrl('boardList.jsp')">
		</p>
	</form>
</body>
</html>