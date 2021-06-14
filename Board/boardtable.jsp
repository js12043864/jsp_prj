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
			table,td {
				border: 1px solid black;
				width: 600px;
				margin-left: auto; 
				margin-right: auto;
			}
			
			.new {
				position: absolute;
				left: 1216px;
				margin-top: 10px;
			}
			
			.num {
				width: 100px;
				text-align: center;
			}
			
			.title{
				width: 350px;
				text-align: center;
			}
			.date {
				width: 150px;
				text-align: center;
			}
		</style>
	</head>
	<body>
		
		<table>
			<tr>
				<td class="num">번호</td>
				<td class="title">제목</td>
				<td class="date">등록일</td>
			</tr>
			<%
			Class.forName("com.mysql.jdbc.Driver");	
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("select * from board order by id desc;");
			while(rset.next()){
				out.print("<tr>" +
								"<td class=num>" +
									rset.getString(1) +
								"</td>" +
								"<td class=title>" +
									"<a href=board_view.jsp?id=" + rset.getString(1) + ">" + rset.getString(2) + "</a>" +
								"</td>" +
								"<td class=date>" +
									rset.getString(3) +
								"</td>" +
							"</tr>");
			}
			%>
		</table>
		<input type="button" class="new" onclick="location.href='board_insert.jsp'" value="신규">
	</body>
</html>