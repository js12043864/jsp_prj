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
		String comment = request.getParameter("comment");
		int boardNum = Integer.parseInt(request.getParameter("boardNum"));
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from comment2 where boardNum = " + boardNum + " order by id;");
		int id = 0;
		while(rset.next()){
				id = rset.getInt(1);
		}
		stmt.execute("insert into comment2 (id,content,date,boardNum) values(" + (id+1) + ", \"" + comment + "\", now(), " + boardNum +");");
		rset.close();
		stmt.close();
		conn.close();
		%>
		<script>
		window.addEventListener('DOMContentLoaded', function() {
			location.href = 'board_view.jsp?id=<%= boardNum%>';
		});
		</script>
	</head>
	<body>
		
	</body>
</html>