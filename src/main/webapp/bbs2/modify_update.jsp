<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String uid = request.getParameter("uid");
String subject = request.getParameter("subject");
String names = request.getParameter("names");//이름
String phone = request.getParameter("phone");
String age = request.getParameter("age");
String per = request.getParameter("per");
String place = request.getParameter("place");
String datee = request.getParameter("datee");
String datea = request.getParameter("datea");
String gender = request.getParameter("gender");


String sql = "update "+code+" set names='"+names+"', subject='"+subject+"', phone='"+phone+"', age='"+age+"', per='"+per+"', place='"+place+"', datee='"+datee+"', datea='"+datea+"', gender='"+gender+"' where uid='"+uid+"' ";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>    

<script>
	location.href="list.jsp?code=<%=code%>";
</script>





