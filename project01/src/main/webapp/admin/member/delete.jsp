<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp"%>
<%

//<!--"id"값을 받아온 후 변수처리 해서  sql에넣음-->
String id = request.getParameter("id");
String sql = "delete from member where id='"+id+"'";

//<!--DB연동-->
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	location.href="list.jsp";
</script>