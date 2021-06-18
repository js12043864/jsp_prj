<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.sql.*, javax.sql.*, java.util.ArrayList"%>

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
				border: 3px solid green;
				border-collapse: collapse;
				width: 600px;
				margin-left: auto; 
				margin-right: auto;
				padding-bottom: 2px;
			}

			.menu {
				border: 2px solid blue;
				border-collapse: collapse;
				text-align: center;
				background-color: white;
				padding: 5px;
				margin-top : 5px;
				margin-bottom : 5px;
				font-size: 15px;
			}
			
			#menu1 {
				margin-left: 5px;
			}

			#menu3 {
				background-color: yellow;
			}

			#hubo {
				width: 100px;
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
			
			.person {
				padding: 2px 4px 2px 4px;
				width: 100px;
			}
			
			.graph {
				width: 500px;	
			}
		</style>
	</head>
	<body>
		<%
		try{
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		ArrayList<String> per_kiho = new ArrayList<String>();
		ArrayList<String> per_name = new ArrayList<String>();
		ResultSet rset = stmt.executeQuery("select id, name from hubo_table order by id;");
		while(rset.next()) {
			per_kiho.add(rset.getString(1));
			per_name.add(rset.getString(2));
		}
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
			<div>&nbsp;*후보 별 득표율</div>
			<table>
			<% 
			
			int count = 0;
			rset = stmt.executeQuery("select count(id) from hubo_table;");
			while(rset.next()) {
				count = rset.getInt(1);
			}
			for(int i = 0; i < count; i++){
				rset = stmt.executeQuery("select a.id, a.name, count(b.id), Round(count(b.id)/(select count(*) from tupyo_table) * 100,2) from hubo_table as a, tupyo_table as b where a.id=b.id and a.id=\"" + per_kiho.get(i) + "\"group by b.id;");
				String str = "";
				while(rset.next()) {
						str = rset.getString(1);
						double wid = rset.getInt(4) * 400 / 100.0;
						out.println("<tr><td class=person>" + "<a href=/Vote/oneview.jsp?num=" + rset.getString(1) + "_" + rset.getString(2) + ">" 
							+ rset.getString(1) + " &nbsp;" + rset.getString(2) + "</a></td><td class=graph><span style=\"border: 1px solid red; width:" + wid + "px; background-color: red; height: 10px; display: inline-block;\"></span>" + rset.getString(3) + "(" + rset.getString(4) + "%)</td></tr>"); 
				}
				if(str.equals("")) {
					out.println("<tr><td class=person>" + "<a href=/Vote/oneview.jsp?num=" + per_kiho.get(i) + "_" + per_name.get(i) + ">" 
						+ per_kiho.get(i) + " &nbsp;" + per_name.get(i) + "</a></td><td class=graph><span style=\"border: 1px solid red; width:0px; background-color: red; height: 10px; display: inline-block;\"></span>0(0.0%)</td></tr>"); 	
				}
			}
			rset.close();
			stmt.close();
			conn.close();
			}catch(Exception e) {
				out.println(e.getMessage());
				out.println("후보가 없습니다.");
			}
			%>
			</table>
		</div>
	</body>
</html>