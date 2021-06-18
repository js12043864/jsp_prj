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
			#navigation {
				margin-left: 600px; 
			}
		
			table,td {
				border: 2px solid #3C8DAD;
				border-collapse: collapse;
				width: 650px;
				margin-left: 600px; 
			}
			
			.new {
				margin-top: 10px;
				min-width: 140px;
				padding: 0 30px;
				color: #fff;
				font-size: 16px;
				font-family: "맑은 고딕", Malgun Gothic, sans-serif;
				font-weight: bold;
				line-height: 40px;
				border: 1px solid transparent;
				background-color: #125D98;
			}
			
			.Id {
				width: 100px;
				text-align: center;
				height: 30px;
				color: #fff;
				background-color: #125D98;
			}
			
			.Ttl{
				width: 350px;
				text-align: center;
				height: 30px;
				color: #fff;
				background-color: #125D98;
			}
			.day {
				width: 150px;
				text-align: center;
				height: 30px;
				color: #fff;
				background-color: #125D98;
			}
			
			.num {
				width: 100px;
				text-align: center;
				height: 30px;
			}
			
			.title{
				width: 350px;
				padding-left: 10px;
				height: 30px;
			}
			.date {
				width: 150px;
				text-align: center;
				height: 30px;
			}
			
			#navi:link {
				text-decoration: none;
				color : black;
			}
			#navi:visited {
				text-decoration: none;
				color : black;
			}
			
			#movePage:link {
				color : black;
			}
			
			#movePage:visited {
				color : black;
			}
		</style>
	</head>
	<body>
		<div id="navigation"><a href="boardtable.jsp" id="navi"><h1>게시판</h1></a></div>
		<table>
			<tr>
				<td class="Id"><b>번호</b></td>
				<td class="Ttl"><b>제목</b></td>
				<td class="day"><b>등록일</b></td>
			</tr>
			<%
			Class.forName("com.mysql.jdbc.Driver");	
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery("select * from board2 order by id desc;");
			while(rset.next()){
				out.print("<tr>" +
								"<td class=num>" +
									rset.getString(1) +
								"</td>" +
								"<td class=title>" +
									"<a href=board_view.jsp?id=" + rset.getString(1) + " id=\"movePage\">" + rset.getString(2) + "</a>" +
								"</td>" +
								"<td class=date>" +
									rset.getString(3) +
								"</td>" +
							"</tr>");
			}
			%>
		</table>
		<div>
		<div style="width: 1103px; display: inline-block;"></div>
		<input type="button" class="new" onclick="location.href='board_insert.jsp'" value="신규">
		</div>
	</body>
</html>