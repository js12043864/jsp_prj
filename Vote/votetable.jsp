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
				background-color: yellow;
			}
			
			.hubo_people {
				width: 590px;
				height : 30px;
				border: 1px solid black;
				border-collapse: collapse;
				padding-top: 4px;
				padding-bottom: 4px;
				margin-left: 5px;
				margin-right: 5px;
			}
			
			.delete {
				margin-left: 240px;
				border: 1px solid black;
				align: right;
			}
			
			a {
				text-decoration:none;			
				padding: 3px 5px 3px 5px;
				margin-left: 150px;
				margin-bottom: 12px;
				background-color: cornsilk;
				border: 1px solid black;
				border-radius: 5px;
				font-size: 15px;
			}
			
			a:link {
				color : black;
			}
			
			a:visited {
				color : black;
			}
			
			.add_name {
				width: 132px;
				height: 20px;
				border: 1px solid green;
				border-radius: 5px;
				
			}
			
			.add {
				padding: 3px 5px 3px 5px;
				margin-left: 140px;
				background-color: cornsilk;
				border: 1px solid black;
				border-radius: 5px;
				font-size: 15px;
			}
			
			form {
				display: inline;
			}
		</style>
		<script>
			// 특수문자 정규식 변수(공백 미포함)
			var replaceChar = /[~!@\#$%^&*\()\-=+_'\;<>0-9\/.\`:\"\\,\[\]?|{}]/gi;
		 
			// 완성형 아닌 한글 정규식
			var replaceNotFullKorean = /[ㄱ-ㅎㅏ-ㅣ]/gi;
			$(document).ready(function(){
				$(".add_name").on("focusout", function() {
					var x = $(this).val();
					if (x.length > 0) {
						if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
							x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
						}
						$(this).val(x);
					}
					}).on("keyup", function() {
						$(this).val($(this).val().replace(replaceChar, ""));
					
					  var a = $(this).val().replace(/ /gi, '');
					$(this).val(a);
			  });
			});  
		</script>
	</head>
	<body>
		<%
		Class.forName("com.mysql.jdbc.Driver");	
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		int num = 0;
		ResultSet rset = stmt.executeQuery("select * from hubo_table order by id;");
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
			<table>
		<% 
		while(rset.next()) {
			out.println("<tr><td class=hubo_people><div style=\"width: 300px; display: inline-block;\">&nbsp;기호번호 : " + rset.getString(1) + " &nbsp;&nbsp;후보명: " + rset.getString(2)
			+ "</div><a href=/Vote/deletehubo.jsp?num=" + rset.getString(1) + " class=\"delete\">삭제</a></td></tr>"); 
			num = rset.getInt(1);
		}	
		out.println("<tr>" + 
						"<td class=hubo_people><div style=\"width: 400px; display: inline-block;\">&nbsp;기호번호 : " + (num+1) + " &nbsp;&nbsp;후보명: " + 
								"<form action=\"inserthubo.jsp\" method=\"get\">" + 
									"<input type=\"text\" name=\"new\" class=\"add_name\" maxlength=\"20\"></div>" + 
									"<input type=\"submit\" class=\"add\" value=\"추가\">" + 
								"</form>" +
						"</td>" + 
					"</tr>");
		
		rset.close();
		stmt.close();
		conn.close();
		%>
			</table>
		</div>
	</body>
</html>