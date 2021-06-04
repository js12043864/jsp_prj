<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.sql.*, javax.sql.*, java.util.regex.*"%>

<!DOCTYPE html>
<html>
<head>
	
<meta charset="UTF-8">
<%
	try{
	String stu_name = request.getParameter("stu_name2");
	if(stu_name.equals("")){
		Integer.parseInt(stu_name);
	}
	int stu_id= Integer.parseInt(request.getParameter("stu_id2"));
	int stu_kor= Integer.parseInt(request.getParameter("pt_kor2"));
	int stu_eng = Integer.parseInt(request.getParameter("pt_eng2"));
	int stu_mat = Integer.parseInt(request.getParameter("pt_mat2"));
%>
<style>

	table,
        td {
			text-align: center;
            border: 1px solid black;        
			width: 500px;
        }
	a {
		text-decoration:none;
	}
</style>
</head>

<body>
	<center>
    <h1>레코드 수정</h1>
	<% 
	Class.forName("com.mysql.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
	Statement stmt = conn.createStatement();
	stmt.execute("update exam set name = \"" + stu_name + "\", studentid =" + stu_id + ",kor = "
					+ stu_kor + ",eng = " + stu_eng + ",mat = " + stu_mat +" where studentid =" + stu_id + ";");
	
	ResultSet rset = stmt.executeQuery("select * from exam;");
	out.println("<table><tr><td>이름</td><td>학번</td><td>국어</td><td>영어</td><td>수학</td></tr>");
	while(rset.next()) {
		if(rset.getInt(2) == stu_id) {
			out.println("<tr><td style=\"background-color: yellow\">" 
				+ "<a href=/oneviewDB.jsp?stu_name=" + rset.getString(1) + "&stu_id=" + rset.getString(2) + ">" + rset.getString(1) + "</a>"
				+ "</td>");
			out.println("<td style=\"background-color: yellow\">" + rset.getString(2) + "</td>");
			out.println("<td style=\"background-color: yellow\">" + rset.getString(3) + "</td>");
			out.println("<td style=\"background-color: yellow\">" + rset.getString(4) + "</td>");
			out.println("<td style=\"background-color: yellow\">" + rset.getString(5) + "</td>");
			out.println("</tr>");	
		}else {
			out.println("<tr><td>" 
				+ "<a href=/oneviewDB.jsp?stu_name=" + rset.getString(1) + "&stu_id=" + rset.getString(2) + ">" + rset.getString(1) + "</a>"
				+ "</td>");
			out.println("<td>" + rset.getString(2) + "</td>");
			out.println("<td>" + rset.getString(3) + "</td>");
			out.println("<td>" + rset.getString(4) + "</td>");
			out.println("<td>" + rset.getString(5) + "</td>");
			out.println("</tr>");	
		}
	}
	rset.close();
	stmt.close();
	conn.close();
%>
	</table>
	</center>
	<% 
	}catch (Exception e) {
		
		out.println("입력 형식이 잘못되었습니다. 모든 항목을 채워주세용.");
	}
	%>
</body>
</html>