<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 읽기</title>
<style>
	table,
        td {
            border: 1px solid black;
			text-align: center;
        }
	a {
		text-decoration:none;
	} 
	a:hover {
		color : red;
	}
</style>

<% 	
	int from;
	int cnt;
	try {
	String from_s = request.getParameter("from");
	String cnt_s = request.getParameter("cnt");
	from = Integer.parseInt(request.getParameter("from"));
	cnt = Integer.parseInt(request.getParameter("cnt"));
	} catch (Exception e) {
		from = 1;
		cnt = 20;
	}
	%>
</head>
<body>
	
	<table>
		<tr id="tt">
			<td>순번</td>
			<td>주소</td>
			<td>위도</td>
			<td>경도</td>
			<td>거리</td>
		</tr>
	<%
		ArrayList<String> content = new ArrayList<String>();
		BufferedReader reader = null;
		Double lat = 37.38592;
		Double lng = 127.12125;
		int line = 0;
		content.add("no data");
		int fin_page = 0;
		int tot_cnt = 0;
		int cur_page = 0;
		int start_num = 0;
		try {
			String filePath = application.getRealPath("wifi.txt");
			reader = new BufferedReader(new FileReader(filePath));
			while (true) {
				String str = reader.readLine();
				if (str == null)
					break;
				if(line == 0){
					line++;
					continue;
				}
				content.add(str);
			}
			tot_cnt = content.size() - 1;
			if( from < 1) {
				from = 1;
			}else if (from > tot_cnt) {
				from = tot_cnt - cnt + 1;
			}
			if( tot_cnt % cnt == 0) {
				fin_page = tot_cnt / cnt;
			}else {
				fin_page = tot_cnt / cnt + 1;
			}
			if( from % cnt == 0) {
				cur_page = from / cnt;
			}else {
				cur_page = from / cnt + 1;
			}
			start_num = (cur_page - 1) * 20 + 1;
			for(int i = from; i < from + cnt; i++){
				if( i > tot_cnt) {
				break;}
				String[] field = content.get(i).split("\t");
				if(field[12].isBlank()) {	
					field[12] = "0.0";	
				}
				if(field[13].isBlank()) {	
					field[13] = "0.0";	
				}
				Double dist = Math.sqrt(Math.pow(Double.parseDouble(field[12]) - lat,2) 
					+ Math.pow(Double.parseDouble(field[13]) - lng,2));
				out.println("<tr>"
					+ "<td>" + (i) + "</td>"
					+ "<td>" + field[9] + "</td>"
					+ "<td>" + field[12] + "</td>"
					+ "<td>" + field[13] + "</td>"
					+ "<td>" + dist + "</td>"
					+ "</tr>");
			}
		}
		 catch (FileNotFoundException fnfe) {
			out.println("파일이 존재하지 않습니다.");
		} catch (IOException ioe) {
			out.println("파일을 읽을수 없습니다.");
		} finally {
			try {
				reader.close();
			} catch (Exception e) {

			}
		}
	%>
	</table>
	
	<div>
	<span><a href="/wifi1.jsp?from=1&cnt=<%=cnt%>">처음</a></span>
	<% 
		int pr_pg = (cur_page / 10) * 10 + 1;
		if(cur_page % 10 == 0 ) {
			pr_pg = ((cur_page / 10) - 1) * 10 + 1;
		}
		
		out.print("<span><a href=/wifi1.jsp?from=" + ((cur_page - 2) * cnt + 1)  + "&cnt=" + cnt +"><</a></span> ");
		for( int i = pr_pg; i < pr_pg + 10; i++) {
			if( i > fin_page) {
				break;
			} else {
			
			out.print("<span><a href=/wifi1.jsp?from=" + ((i-1) * cnt + 1)  + "&cnt=" + cnt +">" + i + "</a></span> ");
			}
		}
		out.print("<span><a href=/wifi1.jsp?from=" + ((cur_page) * cnt + 1)  + "&cnt=" + cnt +">></a></span> ");
	%>
	<span><a href="/wifi1.jsp?from=<%= (fin_page - 1) * cnt + 1 %>&cnt=<%=cnt%>">끝</a></span>
	<span>현재페이지: <%=cur_page%></span>
	</div>
</body>
</html>