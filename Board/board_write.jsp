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
		<%
		String ttl = request.getParameter("title");
		String day = request.getParameter("date");
		String cnt = request.getParameter("content");
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		stmt.execute("insert into board (title,date,content) values(\"" + ttl + "\", now(),\"" + cnt +"\");");
		ResultSet rset = stmt.executeQuery("select * from board order by id;");
		String id ="";
		while(rset.next()){
			id = rset.getString(1);
		}
		%>
		
		<script>
		window.addEventListener('DOMContentLoaded', function() {
			location.href = 'board_view.jsp?id=<%= id%>';
		});
		</script>
	</head>
	<body>
		
	</body>
</html>