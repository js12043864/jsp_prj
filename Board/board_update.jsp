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

			.cancel, .write, .delete{
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
			#cnt {
				width: 400px;
			}
			
			#content {
				height: 300px;
				width: 400px;
			}
			
			textarea {
				resize : none;
		    }

			textarea:focus {
			   outline : none;
			}
			
			#title {
				width: 200px;
				height: 20px;
			}	
			
			#navi:link {
				text-decoration: none;
				color : black;
			}
			#navi:visited {
				text-decoration: none;
				color : black;
			}
		</style>
	</head>
	<body>
		<div id="navigation"><a href="boardtable.jsp" id="navi"><h1>게시판</h1></a></div>
		<%
		String id = request.getParameter("id");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        String date = sdf.format(cal.getTime());
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from board2 where id=" + id + ";");
		String title = "";
		String content = "";
		while(rset.next()){
			title = rset.getString(2);
			content = rset.getString(4);
		}
		%>
		<form method="get" action="board_write2.jsp">
			<table>
				<tr>
					<td class="option">번호</td>
					<td class="content"><input type="text" name="id" id="title" readonly value=<%= id%>></td>
				</tr>
				<tr>
					<td class="option">제목</td>
					<td class="content"><input type="text" name="title" id="title" maxlength="20" required value=<%= title%>></td>
				</tr>
				<tr>
					<td class="option">일자</td>
					<td class="content"><%= date%></td>
				</tr>
				<tr>
					<td class="option">내용</td>
					<td class="content" id="content"><textarea name="content" id="cnt" rows="20" required placeholder="내용을 입력하세요"><%= content %></textarea></td>
				</tr>
			</table>
			<div>
			<div style="width: 813px; display: inline-block;"></div>
			<input type="button" class="cancel" onclick="location.href='boardtable.jsp'" value="취소">
			<input type="submit" class="write" value="저장">
			<input type="button" class="delete" onclick="location.href='board_delete.jsp?id=<%= id%>'" value="삭제">
			</div>
		</form>
	</body>
</html>