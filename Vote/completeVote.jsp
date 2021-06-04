<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.sql.*, javax.sql.*"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Document</title>
		<style>
			#box {
				border: 1px solid green;
				border-collapse: collapse;
				width: 600px;
				margin-left: auto;
				margin-right: auto;
			}

			.menu {
				border: 1px solid blue;
				border-collapse: collapse;
				text-align: center;
				background-color: white;
			}

			#menu2 {
				background-color: yellow;
			}
			
			td {
				width: 40%;
				border: 1px solid black;
				border-collapse: collapse;
				padding-top: 4px;
				padding-bottom: 4px;
			}
			
			.delete {
				margin-left: 220px;
				border: 1px solid black;
			}
			
			a {
				text-decoration:none;
				background-color: cornsilk;
			}
			
			a:link {
				color : black;
			}
			
			a:visited {
				color : black;
			}
			
			.add_name {
				width: 100px;
				border: 1px solid green;
			}
			
			.add {
				margin-left: 150px;
			}
			
			form {
				display: inline;
			}
		</style>
		<%
		try{
		String vote_num = request.getParameter("num_name");
		String vote_age = request.getParameter("age");
		String[] vote_num2 = vote_num.split("번");
		vote_num = vote_num2[0];
		%>
	</head>
	<body>
		<%
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		stmt.execute("insert into tupyo_table (id, age) values(" + vote_num + "," + vote_age + ");");
		int num = 0;	
		%>
		<div id="box">
			<span>
				<input type="button" id="menu1" class="menu" onClick="location.href='votetable.jsp'" value="후보등록">
			</span>
			<span>
				<input type="button" id="menu2" class="menu" value="투표" onClick="location.href='voteHubo.jsp'">
			</span>
			<span>
				<input type="button" id="menu3" class="menu" value="개표결과" onClick="location.href='resultVote.jsp'">
			</span>
			<br>
			<table>
			<% 
			out.println("투표 결과 : 투표하였습니다.");
			stmt.close();
			conn.close();
			}catch(NullPointerException e) {
				out.println("후보자가 없습니다.");
			}
			%>
			</table>
		</div>
	</body>
</html>