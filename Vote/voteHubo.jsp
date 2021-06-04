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
	</head>
	<body>
		<%
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		int num = 0;
		ResultSet rset = stmt.executeQuery("select * from hubo_table order by id;");
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
			out.println("<tr>" +
							"<td>" +
								"<form action=\"completeVote.jsp\" method=\"get\">" + 
									"<select name=num_name id=\"hubo\">");
			while(rset.next()) {
				out.println("<option>" +
								rset.getString(1) + "번 " + rset.getString(2) +
							"</option>");
			}
			out.println("</select>");
			out.println("<select name=age><option value=\"10\">10대</option>" + 
							"<option value=\"20\">20대</option>" +
							"<option value=\"30\">30대</option>" +
							"<option value=\"40\">40대</option>" +
							"<option value=\"50\">50대</option>" +
							"<option value=\"60\">60대</option>" +
							"<option value=\"70\">70대</option>" +
							"<option value=\"80\">80대</option>" +
							"<option value=\"90\">90대</option>" +
							"</select>");
			out.println("<input type=\"submit\" class=\"vote\" value=\"투표하기\"></form></td></tr>");
			rset.close();
			stmt.close();
			conn.close();
			%>
			</table>
		</div>
	</body>
</html>