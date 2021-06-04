<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.sql.*, javax.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>

</head>
<body>
<% 
	Class.forName("com.mysql.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
	Statement stmt = conn.createStatement();
	try {
	stmt.execute("drop table exam;");
	out.println("<center><h1>테이블지우기 OK</h1></center>");
	} catch (SQLSyntaxErrorException e) {
		out.println("<h1>테이블이 존재하지 않습니다!</h1>");
	}
	
	stmt.close();
	conn.close();
%>
</body>
</html>