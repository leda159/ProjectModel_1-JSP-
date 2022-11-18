<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>

<%
String code = request.getParameter("code");
String uid = request.getParameter("uid");

//글쓴이 누구?
String sql_who = "select id from "+code+" where uid="+uid+"";	
Connection conn_who = DriverManager.getConnection(url, user, password);
Statement stmt_who = conn_who.createStatement();
ResultSet rs_who = stmt_who.executeQuery(sql_who);

String id = "";
if(rs_who.next()){
	id = rs_who.getString("id"); //글쓴이 아이디
}

if(session_level != null && (session_level.equals("10") || id.equals(session_id))){
	//삭제부분
	String sql = "delete from "+code+" where uid="+uid+"";

	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	stmt.executeUpdate(sql);
%>
	<script>
		location.href="list.jsp?code=<%=code%>";
	</script>
<%	
}else{
%>
	<script>
		alert("관리자 or 작성자만 삭제할 수 있습니다.");
		location.href="/";
	</script>
<%
}
%>









