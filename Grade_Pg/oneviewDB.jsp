<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.sql.*, javax.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	table,
        td {
			text-align: center;
            border: 1px solid black;
            
			width: 500px;
        }
</style>
<% 	
	String stu_name = request.getParameter("stu_name");
	String stu_id = request.getParameter("stu_id");
	%>
</head>
<body>
<center>
<% 
	Class.forName("com.mysql.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
	Statement stmt = conn.createStatement();
	String a = "select * from exam where studentid = \"" + stu_id + "\";";
	ResultSet rset = stmt.executeQuery(a);
	
	out.println("<table><tr><td>이름</td><td>학번</td><td>국어</td><td>영어</td><td>수학</td></tr>");
	while(rset.next()) {
		out.println("<tr>");
		out.println("<td>" + rset.getString(1) + "</td>");
		out.println("<td>" + rset.getString(2) + "</td>");
		out.println("<td>" + rset.getString(3) + "</td>");
		out.println("<td>" + rset.getString(4) + "</td>");
		out.println("<td>" + rset.getString(5) + "</td>");
		out.println("</tr>");
	}
	stmt.close();
	conn.close();
%>
	
	<h1><%=stu_name%>[조회]</h1>
	</center>
</body>
</html>