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
		border: 1px solid black;
		text-align: center;
	}
	.input {
		width: 200px;
	}
	.opt {
		width: 100px;
	}
</style>
<%
	try{
	
	
%>	
	
</head>

<body>
	<% 

	Class.forName("com.mysql.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
	Statement stmt = conn.createStatement();
	String a = "select * from exam order by studentid desc limit 1;";
	ResultSet rset = stmt.executeQuery(a);
	String stu_name = request.getParameter("stu_name");
	int stu_kor = Integer.parseInt(request.getParameter("pt_kor"));
	int stu_eng = Integer.parseInt(request.getParameter("pt_eng"));
	int stu_mat = Integer.parseInt(request.getParameter("pt_mat"));
	if (stu_name.equals("")) {
		Integer.parseInt(stu_name);
	}
	int id = 0;
	while(rset.next()) {
		id = rset.getInt(2);
	}
	stmt.execute("insert into exam (name, studentid, kor, eng, mat) values (\'" + stu_name + "\'," + (id + 1) + "," + stu_kor + "," + stu_eng + "," + stu_mat + ");");
	stmt.close();
	conn.close();
	
%>
	<center>
	<h1>성적입력추가완료</h1>
    <input type="button" value="뒤로가기" onclick="location.href='inputform0.html'"> 
	<br>
	<table>
		<tr>
			<td class="opt">이름</td>
			<td class="input"><input type="text" value="<%=stu_name%>" maxlength="20"></td>
		</tr>
		<tr>
			<td class="opt">학번</td>
			<td class="input"><%=id + 1%></td>
		</tr>
		<tr>
			<td class="opt">국어</td>
			<td class="input"><input type="number" min="0" max="100" value="<%=stu_kor%>"></td>
		</tr>
		<tr>
			<td class="opt">영어</td>
			<td class="input"><input type="number" min="0" max="100" value="<%=stu_eng%>"></td>
		</tr>
		<tr>
			<td class="opt">수학</td>
			<td class="input"><input type="number" min="0" max="100" value="<%=stu_mat%>"></td>
		</tr>
	</table>
	</center>
	<%
	}catch (SQLSyntaxErrorException e) {
		out.println("테이블이 존재하지 않습니다.");
	}
	catch (NumberFormatException e) {
		out.println("입력 형식이 잘못되었습니다. 모든 항목을 채워주세용");
	}
	%>
</body>
</html>