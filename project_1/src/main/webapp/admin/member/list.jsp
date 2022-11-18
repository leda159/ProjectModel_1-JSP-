<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp"%>



<style>
	.td_bottom {
		border-bottom:1px solid gray;
		text-align:center;
		font-weight:bold;
		font-size:20px;
		background:#c0f1f9;
		
	}
	.td_bottom2 {
		border-bottom:1px solid gray;
		text-align:center;
		font-size:15px;
	}
	.td_bottom3 {
		border-bottom:1px solid gray;
		text-align:center;
		background:#eee;
		font-size:15px;
	}
	.td_bottom5{
		border-bottom:1px solid gray;
		text-align:left;
		font-size:15px;
	}
	a{
		text-decoration: none;
		color:black;
		font-size:15px;
	}
	button{
		cursor:pointer;
	}
	
	center{font-size:25px;}
</style>
<!--정보검색 구문을사용 > 변수 처리 > DB연동 > DB실행(rs라는 객체에 담아서) -->
<%	 
String sql = "select * from member order by signdate desc";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
%>

<!-- 회원목록 -->
<center><b>회원목록</b></center>
<br>
<table width=1000 border=0 align=center>
	<tr bgcolor="#c0f1f9">
		<td class="td_bottom">ID</td>
		<td class="td_bottom">Pass</td>
		<td class="td_bottom">Name</td>
		<td class="td_bottom">Phone</td>
		<td class="td_bottom">Email</td>
		<td class="td_bottom">Gender</td>
		<td class="td_bottom">level</td>
		<td class="td_bottom">Date</td>
		<td class="td_bottom">Age</td>
	</tr>


<!--회원목록 출력 -->
<%
	while(rs.next()){
		String email = rs.getString("email1")+"@"+rs.getString("email2");
%>
	<tr>
		<td class="td_bottom2"><!--객체rs의 값id의내용들을 view로 볼수있게함? -->
			<a href="view.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("id")%></a></td>
		<td class="td_bottom2"><%=rs.getString("pass")%></td>
		<td class="td_bottom2"><%=rs.getString("name")%></td>
		<td class="td_bottom2"><%=rs.getString("phone")%></td>
		<td class="td_bottom2"><%=email%></td>
		<td class="td_bottom2"><%if(rs.getString("gender").equals("M")){%>남자<%}else{%>여자<%}%></td>
		<td class="td_bottom2"><%=rs.getString("level")%></td>
		<td class="td_bottom2"><%=rs.getString("signdate").substring(0,16)%></td>
		<td class="td_bottom2"><%=rs.getString("age") %></td>
	</tr>
<%
}	
%>

</table>
<table width=1000  height=10 border=0 align=center>
	<tr bgcolor="#e2e2e2">
		<td colspan=2 align=right>
			<a href="list.jsp"><button type="button">새로고침</button></a>
			<a href="write.jsp"><button type="button">회원가입</button></a>
		</td>
	</tr>
</table>

<%@ include file="/admin/include/footer.jsp"%>