<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.sql.*, javax.sql.*, java.util.*, java.text.*"%>

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
				padding-top: 10px;
				padding-bottom: 10px;
			}

			.update, .list {
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
			
			.addComment {
				margin-top: 10px;
				min-width: 140px;
				padding: 0 30px;
				padding-top : 10px;
				padding-bottom : 10px;
				color: #fff;
				font-size: 12px;
				font-family: "맑은 고딕", Malgun Gothic, sans-serif;
				font-weight: bold;
				line-height: 20px;
				border: 1px solid transparent;
				background-color: #125D98;
			}
			
			#cmt {
				width: 645px;
				margin-left: 600px;
				margin-top: 10px;
			}
			
			
			.option {
				text-align: center;
				font-size: 16px;
				font-family: "맑은 고딕", Malgun Gothic, sans-serif;
				font-weight: bold;
				width: 200px;
			}
			
			.content {
				padding-left: 10px;
				padding-right: 10px;
				font-size: 16px;
				font-family: "맑은 고딕", Malgun Gothic, sans-serif;
				width: 400px;
			}
			.number {
				width: 200px;
				text-align: center;
			}
			.date {
				width: 200px;
				text-align: center;
			}
			
			#navi:link {
				text-decoration: none;
				color : black;
			}
			#navi:visited {
				text-decoration: none;
				color : black;
			}
			textarea {
				resize : none;
		    }

			textarea:focus {
			   outline : none;
			}
		</style>
	</head>
	<body>
		<div id="navigation"><a href="boardtable.jsp" id="navi"><h1>게시판</h1></a></div>
		<%
		String id = request.getParameter("id");
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from board2 where id=" + id + ";");
		String title = "";
		String date = "";
		String content = "";
		while(rset.next()){
			title = rset.getString(2);
			date = rset.getString(3);
			content = rset.getString(4);
		}
		content = content.replaceAll("\n","<br>");
		%>
		<form method="post" action="comment_insert.jsp?boardNum=<%= id%>">
			<table>
				<tr>
					<td class="option">번호</td>
					<td class="content"><div name="boardNum"><%= id%></td>
				</tr>
				<tr>
					<td class="option">제목</td>
					<td class="content"><%= title%></td>
				</tr>
				<tr>
					<td class="option">일자</td>
					<td class="content"><%= date%></td>
				</tr>
				<tr>
					<td class="option">내용</td>
					<td class="content"><%= content%></td>
				</tr>
			</table>
			<div>
			<div style="width: 960px; display: inline-block;"></div>
			<input type="button" class="list" onclick="location.href='boardtable.jsp'" value="목록">
			<input type="button" class="update" onclick="location.href='board_update.jsp?id=<%= id%>'" value="수정">
			</div>
		<br><br>
		<div>
			<div style="width: 595px; display: inline-block;"></div>
			<b>댓글</b>
		<div>
		<div>
			<textarea name="comment" id="cmt" rows="4" placeholder="댓글을 입력하세요"></textarea>
			<br>
			<div style="width: 1105px; display: inline-block;"></div>
			<input type="submit" class="addComment" value="댓글달기">
		</div>
		</form>
		<br>
		<table>
				<tr>
					<td class="number" style="text-align: center;">번호</td>
					<td class="plusContent" style="text-align: center;">댓글내용</td>
					<td class="date">날짜</td>
				</tr>
				<%
				rset = stmt.executeQuery("select * from comment2 where boardNum=" + id + " order by id;");
				while(rset.next()){
					out.print("<tr>" +
									"<td class=\"number\">" + rset.getInt(1) + 
									"</td>" +
									"<td class=\"plusContent\">" + rset.getString(2) + 
									"</td>" +
									"<td class=\"date\">" + rset.getString(3) + 
									"</td>" +
								"<tr>");
				}
				rset.close();
				stmt.close();
				conn.close();
				%>
			</table>
	</body>
</html>