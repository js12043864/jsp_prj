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
	String a = "select * from exam order by studentid desc limit 1;";
	ResultSet rset = stmt.executeQuery(a);
	int id = 0;
	while(rset.next()) {
		id = rset.getInt(2);
	}
	
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('나연', "+ (id+1) + ", 95, 100, 95);");
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('정연', "+ (id+2) + ", 95, 95, 95);");
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('모모', "+ (id+3) + ", 100, 100, 100);");
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('사나', "+ (id+4) + ", 100, 95, 90);");
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('지효', "+ (id+5) + ", 80, 100, 70);");
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('미나', "+ (id+6) + ", 100, 100, 70);");
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('다현', "+ (id+7) + ", 70, 70, 70);");
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('채영', "+ (id+8) + ", 80, 75, 72);");
	stmt.execute( "insert into exam (name, studentid, kor, eng, mat) values ('쯔위', "+ (id+9) + ", 78, 79, 82);");
	
	out.println("<center><h1>실습데이터 입력</h1></center>");
	} catch (SQLSyntaxErrorException e) {
		out.println("<center><h1>테이블이 존재하지 않습니다!</h1></center>");
	}catch (SQLIntegrityConstraintViolationException e) {
		out.println("<center><h1>primary key 데이터가 중복입니다!!</h1></center>");
	}
	stmt.close();
	conn.close();
%>
</body>
</html>