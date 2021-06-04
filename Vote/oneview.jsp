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
		<style>
			#box {
				border: 1px solid green;
				border-collapse: collapse;
				width: 600px;
				margin-left: auto;
				margin-right: auto;
			}

			.menu {
				border: 1px solid blue;
				border-collapse: collapse;
				text-align: center;
				background-color: white;
			}

			#menu3 {
				background-color: yellow;
			}
			
			td {
				border: 1px solid black;
				border-collapse: collapse;
				padding-top: 4px;
				padding-bottom: 4px;
			}
			
			a:link {
				color : black;
			}
			
			a:visited {
				color : black;
			}
			
			.age {
				width: 100px;
				text-align:center;
			}
			.graph {
				width: 500px;
			}
		</style>
		<%
		String person_info = request.getParameter("num");
		String[] person = person_info.split("_");
		String num = person[0];
		String name = person[1];
		%>
		
	</head>
	<body>
		<%
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		%>
		<div id="box">
			<span>
				<input type="button" id="menu1" class="menu" onClick="location.href='votetable.jsp'" value="후보등록">
			</span>
			<span>
				<input type="button" id="menu2" class="menu" value="투표" onClick="location.href='voteHubo.jsp'">
			</span>
			<span>
				<input type="button" id="menu3" class="menu" value="개표결과" onClick="location.href='resultVote.jsp'">
			</span>
			<br>
			<%=num%>. <%=name%> 후보 득표성향 분석
			<table>
			<% 
			int age_num = 10;
			for(int i = 0; i < 9; i++) {
				ResultSet rset = stmt.executeQuery("select age, count(age), Round(count(age)/(select count(*) from tupyo_table where id=" + num + ") * 100,2)" +
													" from tupyo_table " +
													"where id=" + num + " and age=\"" + age_num + "\";");
				while(rset.next()) {
					if(rset.getString(1) == null){
						out.println("<tr>" +
										"<td class=age>" + age_num + "대</td><td class=graph>" +
											"<span style=\"border: 1px solid red; width:0px; background-color: red; height: 10px; display: inline-block;\">" +
											"</span>" +
											"0(0.0%)" +
										"</td>" +
									"</tr>"); 
					}else{
						double wid = rset.getInt(3) * 400 / 100.0;
						out.println("<tr>" +
										"<td class=age>" + rset.getString(1) + "대</td>" +
										"<td class=graph>" +
											"<span style=\"border: 1px solid red; width:" + wid + "px; background-color: red; height: 10px; display: inline-block;\">" +
											"</span>" + 
											rset.getString(2) + "(" + rset.getString(3) +"%)" +
										"</td>" +
									"</tr>"); 
					}
				}
				age_num = age_num + 10;
				rset.close();
			}
			stmt.close();
			conn.close();
			%>
			</table>
		</div>
	</body>
</html>