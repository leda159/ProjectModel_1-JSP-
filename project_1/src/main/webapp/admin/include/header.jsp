<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/basic.css">
<script src="/js/default.js"></script>
<style>
body{
	margin:0px;
	padding:0px;
	
}

</style>
</head>
<body>
<%
//문자열 형태로 se_id를 받아서 session_id에 담는다  
String session_id = (String)session.getAttribute("se_id");
String session_name = (String)session.getAttribute("se_name");
String session_level = (String)session.getAttribute("se_level");
%>
<table width=100% height=150 border=0>
	<tr>
		<td width=13% valign=middle align=center>
			<img src="/upload/82.png" height=60 width=100 ></td>
		<td width=13% valign=top align=center>
			<img src="/upload/82.png" height=60 width=100></td>
		<td width=13% align=center>
			<img src="/upload/82.png" height=60 width=100></td>
		<td colspan= height=50 width=22% align=center>
			<a href="/" style="background: #c0f1f9; font-weight: bold">
			<img src="/upload/77.png" height=150 width=250></a></td>
		<td width=13% valign=bottom align=center>
			<img src="/upload/82.png" height=60 width=100></td>
		<td width=13% align=center><img src="/upload/82.png" height=60 width=100></td>
		<td width=13% valign=top heigth=60 width =100>
		<% 
		if(session_id ==null){
		%>
		<div style="font-weight: bold; font-size:15px;text-align:center">^.^7</div>
		<%
		}else{
			if(session_id != null){
		%>
					<a style="font-weight: bold; font-size:15px;text-align:left"><p>환영합니다~!</p></a>
					<a style="font-weight: bold; font-size:15px;text-align:left" ><span style="color:#1E90FF;"><%=session_name %></span>님&nbsp;반갑습니다^^<br></a>
					<a style="font-weight: bold; font-size:15px;text-align:right"><br><p>등급 : <%=session_level %></p></a>
			
		<%
			}
		%>
		
		<%
		}
		%>
		</td>		
	</tr>
</table>


<table width=100% height=50 border=0>
	<tr>
		<td width=70%>
			<a href="/admin/member/list.jsp" style="color:#1E90FF; font-weight:bold;text-decoration: none; font-size:20px;">회원관리</a>
				<a><img src="/upload/82.png" height=25 width=25></a>
				<a><img src="/upload/82.png" height=25 width=25></a>
			<a href="" style="color:#1E90FF; font-weight:bold;text-decoration: none; font-size:20px;">게시판관리</a>
				<a><img src="/upload/82.png" height=25 width=25></a>
				<a><img src="/upload/82.png" height=25 width=25></a>
			<a href="" style="color:#1E90FF; font-weight:bold;text-decoration: none; font-size:20px;">상품관리</a>
				<a><img src="/upload/82.png" height=25 width=25></a>
				<a><img src="/upload/82.png" height=25 width=25></a>
			<a href="" style="color:#1E90FF; font-weight:bold;text-decoration: none; font-size:20px;">주문관리</a>
				<a><img src="/upload/82.png" height=25 width=25></a>
				<a><img src="/upload/82.png" height=25 width=25></a>
		</td>
		
		
		<td align=right width=30%>
			<a href="/admin/" style="color:#1E90FF;text-decoration:none;font-size:20px;font-weight: bold;">관리자 페이지</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="/" style="color:#1E90FF;text-decoration:none;font-size:20px;font-weight: bold;">일반사용자 페이지</a>	
		</td>
	</tr>
</table>
</body>









