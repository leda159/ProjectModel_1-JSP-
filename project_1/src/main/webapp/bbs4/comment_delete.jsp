<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/dbconnection.jsp" %>

<%
String code = request.getParameter("code");
String uid = request.getParameter("uid");
String c_uid = request.getParameter("c_uid");

String sql = "delete from comment where uid = "+c_uid+"";
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>    

<script>
	location.href="view.jsp?code=<%=code%>&uid=<%=uid%>";
</script>





