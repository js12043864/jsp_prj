<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.sql.*, javax.sql.*, java.util.*, java.text.*"%>

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
				border-collapse: collapse;
			}
			
			.cancel {
				position: absolute;
				margin-top: 10px;
				left: 1124px;
			}
			
			.write {
				position: absolute;
				margin-top: 10px;
				left: 1170px;
			}
			
			.delete {
				position: absolute;
				margin-top: 10px;
				left: 1216px;
			}
		</style>
	</head>
	<body>
		<%
		String id = request.getParameter("id");
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from board where id=" + id + ";");
		String title = "";
		String date = "";
		String content = "";
		while(rset.next()){
			title = rset.getString(2);
			date = rset.getString(3);
			content = rset.getString(4);
		}
		%>
		<form method="get" action="board_write2.jsp">
			<table>
				<tr>
					<td>번호</td>
					<td><input type="text" name="id" readonly value=<%= id%>></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" value=<%= title%>></td>
				</tr>
				<tr>
					<td>일자</td>
					<td><%= date%></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><input type="text" name="content" value=<%= content%>></td>
				</tr>
			</table>
			<input type="button" class="cancel" onclick="location.href='boardtable.jsp'" value="취소">
			<input type="submit" class="write" value="쓰기">
			<input type="button" class="delete" onclick="location.href='board_delete.jsp?id=<%= id%>'" value="삭제">
		</form>
	</body>
</html>