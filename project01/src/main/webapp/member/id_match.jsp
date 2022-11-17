<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnection.jsp"%>   
 
<%
//회원가입 화면에서 입력한 문자열 id 을 받음
String id = request.getParameter("id");


//입력받은 문자열(id)이 sql에 몇개 있는지 검색함
String sql = "select count(*) as count from member where id='"+id+"'";

//DB생성 DB연동 후 실행 
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);



//반복문 while 대신 if 구문을 사용할 수 있다. : 값이 0 or 1 일 경우
int number = 0;
if(rs.next()){ 
	number = rs.getInt("count"); //몇개인지 sql에서 받아서 number에 담는다
}

%>


<!--이미지 클릭하면 창 닫힘-->
<script>
function clo(){
	self.close();
}

</script>

<table border=0 width=290 height=85>
	<tr>
		<td align=left width=130 height=50 style="font-size:25px; color:#1E90FF;">중복확인</td>
		<td width=150><a onclick="clo()" style="cursor: pointer;"><img src="/upload/81.png" height=50 width=30% align=right></a></td>
		
	</tr>
	<tr>
		<td  width=140 heigth=15>아이디:<br></td>
		<td width=150 heigth=15><input style=border-radius:10px;border-color:#e2e2e2; value="<%=id %>"></td>
	</tr>
	<tr>
		<td width=140 heigth=15>회원수:<br></td>
		<td width=150 heigth=15><input style=border-radius:10px;border-color:#e2e2e2; value="<%=number %>"></td>
		
	</tr>
	<tr>
		<td></td>
		<td> </td>
	</tr>
</table>









