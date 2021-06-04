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

</head>
<body>
<center>
<% 
	Class.forName("com.mysql.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
	Statement stmt = conn.createStatement();
	
	
	try {
		ResultSet rset = stmt.executeQuery("select * from exam;");
		out.println("<table><tr><td>이름</td><td>학번</td><td>국어</td><td>영어</td><td>수학</td></tr>");
		while(rset.next()) {
			String stu_name = rset.getString(1);
			String stu_id = rset.getString(2);
			out.println("<tr>");
			out.println("<td>" 
				+ "<a href=/oneviewDB.jsp?stu_name=" + rset.getString(1) + "&stu_id=" + rset.getString(2) + ">" + rset.getString(1) + "</a>"
				+ "</td>");
			out.println("<td>" + rset.getString(2) + "</td>");
			out.println("<td>" + rset.getString(3) + "</td>");
			out.println("<td>" + rset.getString(4) + "</td>");
			out.println("<td>" + rset.getString(5) + "</td>");
			out.println("</tr>");
		}
	out.println("<center><h1>조회</h1></center>");
	}catch(SQLSyntaxErrorException e) {
		out.println("<h1>테이블이 존재하지 않습니다!</h1>");
	}
	stmt.close();
	conn.close();
%>
</body>
</html>