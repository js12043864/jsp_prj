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
	.web {
		border: 1px solid black;
		border-collapse: collapse;
		background-color: silver;	
		font-size: 12px;
		padding: 2px 4px 2px 4px;
		color: black;
	}
	a {
		text-decoration:none;
	}
</style>
<%
	String stu_id = request.getParameter("stu_id");
	String stu_name = "";
	String stu_kor = "";
	String stu_eng = "";
	String stu_mat = "";
	
	%>
	
</head>

<body>
	<% 
	try{
	Class.forName("com.mysql.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.16:3306/kopoctc", "root", "kopoctc");
	Statement stmt = conn.createStatement();
	String a = "select * from exam where studentid = \"" + stu_id + "\";";
	
	ResultSet rset = stmt.executeQuery(a);
	while(rset.next()) {
		stu_name = rset.getString(1);
		stu_kor = rset.getString(3);
		stu_eng = rset.getString(4);
		stu_mat = rset.getString(5);
	}
	if(stu_name.equals("")) {
		stu_name="해당학번없음";
		stu_id="";
		stu_kor="";
		stu_eng="";
		stu_mat="";
	
	
%>
	<center>
    <h1>성적조회후 정정/삭제</h1>
    <form action="" method="get">
		<div>
		<span>조회할 학번&nbsp;</span>
		<input type="number" name="stu_id">
        <input type="submit" value="조회">
		</div>
		<br>
        <table>
            <tr>
                <td class="opt">이름</td>
				
                <td class="input"><input type="text" name="stu_name2" id="inputname" readonly maxlength="20" onkeyup="javascript:return onlyKorean('inputname');" value="<%=stu_name%>"></td>
            </tr>
            <tr>
                <td class="opt">학번</td>
                <td class="input"><input type="search" name="stu_id2" readonly value="<%=stu_id%>"></td>
            </tr>
            <tr>
                <td class="opt">국어</td>
                <td class="input"><input type="number" min="0" max="100" name="pt_kor2" readonly value="<%=stu_kor%>"></td>
            </tr>
            <tr>
                <td class="opt">영어</td>
                <td class="input"><input type="number" min="0" max="100" name="pt_eng2" readonly value="<%=stu_eng%>"></td>
            </tr>
            <tr>
                <td class="opt">수학</td>
                <td class="input"><input type="number" min="0" max="100" name="pt_mat2" readonly value="<%=stu_mat%>"></td>
            </tr>
        </table>
		
    </form>
	</center>
	<%
	}else { %>
	<center>
    <h1>성적조회후 정정/삭제</h1>
    <form action="" method="get">
		<div>
		<span>조회할 학번&nbsp;</span>
		<input type="number" name="stu_id">
        <input type="submit" value="조회">
		</div>
		<br>
        <table>
            <tr>
                <td class="opt">이름</td>
				
                <td class="input"><input type="text" name="stu_name2" id="inputname" maxlength="20" onkeyup="javascript:return onlyKorean('inputname');" value="<%=stu_name%>"></td>
            </tr>
            <tr>
                <td class="opt">학번</td>
                <td class="input"><input type="search" name="stu_id2" readonly value="<%=stu_id%>"></td>
            </tr>
            <tr>
                <td class="opt">국어</td>
                <td class="input"><input type="number" min="0" max="100" name="pt_kor2" value="<%=stu_kor%>"></td>
            </tr>
            <tr>
                <td class="opt">영어</td>
                <td class="input"><input type="number" min="0" max="100" name="pt_eng2" value="<%=stu_eng%>"></td>
            </tr>
            <tr>
                <td class="opt">수학</td>
                <td class="input"><input type="number" min="0" max="100" name="pt_mat2" value="<%=stu_mat%>"></td>
            </tr>
        </table>
		<div>
			<input type="submit" value="수정" onclick="javascript: form.action='updateDB.jsp';"/>
			<input type="submit" value="삭제" onclick="javascript: form.action='deleteDB.jsp';"/>
		</div>
    </form>
	</center>	
		
	<%
	}
	stmt.close();
	conn.close();
	
	}catch (SQLSyntaxErrorException e) {
		out.println("테이블이 존재하지 않습니다.");
	}catch(Exception e) {
		stu_name="해당학번없음";	
	}
	%>
</body>
<script>
	function onlyKorean(inputId) {
					var str=document.getElementById(inputId).value;
					for (i = 0; i < str.length; i++) {
						if (!((str.charCodeAt(i) > 0x3130 && str.charCodeAt(i) < 0x318F) || (str.charCodeAt(i) >= 0xAC00 && str.charCodeAt(i) <= 0xD7A3))) {
							alert("한글만 입력해 주세요");
							document.getElementById(inputId).value=''; 
						}
					}
				}
</script>
</html>