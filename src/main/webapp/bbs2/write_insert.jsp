<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>
    
<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String subject = request.getParameter("subject");
String name = request.getParameter("name");//글쓴이
String names = request.getParameter("names");//이름
String phone = request.getParameter("phone");
String age = request.getParameter("age");
String per = request.getParameter("per");
String place = request.getParameter("place");
String datee = request.getParameter("datee");
String datea = request.getParameter("datea");
String gender = request.getParameter("gender");

//날짜 구하기
java.util.Date date = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = cal.format(date);



String sql = "insert into "+code+" (id,name,names,subject,phone,age,per,place,datee,datea,gender,signdate) values ('"+session_id+"','"+session_name+"','"+names+"','"+subject+"','"+phone+"','"+age+"','"+per+"','"+place+"','"+datee+"','"+datea+"','"+gender+"','"+signdate+"')";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>
<script>
	location.href="list.jsp?code=<%=code%>";
</script>





