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
	stmt.execute( "create table exam(" +	//grade로 테이블 생성
					"name varchar(20), " +		//이름
					"studentid int not null primary key, " +		//학번  
					"kor int, " +	//국어
					"eng int, " +	//영어
					"mat int);");	//수학	
					out.println("<center><h1>테이블만들기 OK</h1></center>");
	}catch(SQLSyntaxErrorException e) {
		out.println("<h1>테이블이 이미 존재합니다!</h1>");
	}
	stmt.close();
	conn.close();
%>

</body>
</html>