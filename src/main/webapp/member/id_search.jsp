<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnection.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String phone = request.getParameter("phone");

String sql = "select * from member where name = '"+name+"' and phone = '"+phone+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id="";
if(rs.next()){
	id = rs.getString("id");
}
%>

<style>
input:focus{outline: none;}
</style>


<script>


function id_aa(){
	if(mem_name.value == ""){
		alert("아이디를 입력하세요");
		mem_name.focus();
		return false;
	}
	if(mem_phone.value == ""){
		alert("연락처를 입력하세요");
		mem_phone.focus();
		return false;
	}
	document.submit();
}

function id_ok3(){
	window.opener.login.memid.value='<%=id%>';
	self.close();
}
</script>

<table border=0>
	<tr>
		<td width=170>아이디:<%=id%></td>
		<td><a onclick="id_ok3()" style="cursor: pointer;"><img src="/upload/81.png" valign=middle height=50 width=50></a></td>
	</tr>
</table>


<form method="post" onsubmit="return id_aa()">
<table border=0>
	<tr bgcolor="#c0f1f9">
		<td colspan=2 style="font-weight:bold; font-size:25px;">아이디 찾기</td>
		
	</tr>
	<tr>
		<td style="font-size:15px;">이름:</td>
		<td><input style=border-radius:10px;border-color:#e2e2e2; id="mem_name" name="name"></td>
	</tr>
	
	<tr style="font-size:15px;">
		<td>연락처:</td>
		<td><input style=border-radius:10px;border-color:#e2e2e2; id="mem_phone" name="phone"></td>
	</tr>
	<tr>
		<td colspan=2 bgcolor="#e2e2e2" vertical-align=middle;><button >아이디 찾기</button></td>
	</tr>
	
</table>
</form>