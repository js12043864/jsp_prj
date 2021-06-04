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

			#menu1 {
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
				margin-left: 100px;
			}
			
			.add_name {
				width: 50px;
				border: 1px solid green;
			}
			
			.add {
				margin-left: 90px;
		</style>
		<%
		String add_name = request.getParameter("new");
		%>
	</head>
	<body>
		<%
		if(add_name.equals("")) {
			out.println("후보등록 결과 : 잘못된 후보명 형식입니다.");
		} else {
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from hubo_table order by id;");
		int num = 0;
		while(rset.next()) {
			num = rset.getInt(1);
		}
		stmt.execute("insert into hubo_table (id,name) values(" + (num+1) + ",\"" + add_name + "\");");
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
			out.println("후보등록 결과 : 후보가 추가 되었습니다.");
			rset.close();
			stmt.close();
			conn.close();
			}
			%>
			</table>
		</div>
	</body>
</html>