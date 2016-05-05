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
<title>Algrus 로그인</title>
</head>
<body id="memberLogin" data-spy="scroll" data-target=".navbar" data-offset="60">
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
		<h2>로그인</h2>
	</header>
	
	<form role="form" action="memberLoginConfirm.jsp">
		<div class="form-group">
			<div class="form-group col-xs-12">
				<h3>로그인 폼</h3>
			</div>
			<div class="form-group col-xs-12">
				<label class="control-label" for="i1">ID</label>
				<input class="form-control" type="text" id="i1" name="ID" required>
			</div>
			<div class="form-group col-xs-12">
				<label class="control-label" for="i2">비밀번호</label>
				<input class="form-control" type="password" id="i2" name="PASSWORD" required>
			</div>
			<div class="form-group col-xs-12">
				<input type="submit" class="btn btn-default" value="가입하기" onclick="goUrl('memberReg.jsp')">
				<input type="submit" class="btn btn-default" value="로그인">
			</div>
		</div>
	</form>
</body>
</html>