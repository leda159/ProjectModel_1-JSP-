<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>

<%
request.setCharacterEncoding("utf-8");

//form으로 받아온 값을 String타입 변수 처리함
String id = request.getParameter("memid");
String pass = request.getParameter("mempass");
String name = request.getParameter("memname");
String phone = request.getParameter("memphone");
String email1 = request.getParameter("mememail1");
String email2 = request.getParameter("mememail2");
String zipcode = request.getParameter("zipcode");
String zipcode1 = request.getParameter("zipcode1");
String zipcode2 = request.getParameter("zipcode2");
String zipcode3 = request.getParameter("zipcode3");
String zipcode4 = request.getParameter("zipcode4");
String gender = request.getParameter("memgender");
String age = request.getParameter("memage");
String emailList = request.getParameter("emailList");

//날짜 구하기
java.util.Date date = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = cal.format(date);

//String타입 변수 처리한 값을 insert문으로 변수 처리해서 다시 String타입 sql에 담는다  
String sql = "insert into member values ('"+id+"','"+pass+"','"+name+"','"+phone+"','"+email1+"','"+email2+"','"+zipcode+"','"+zipcode1+"','"+zipcode2+"','"+zipcode3+"','"+zipcode4+"','"+gender+"','1','"+today+"','"+age+"','"+emailList+"')";

//DB생성,DB연동 후 변수sql을 sql에 저장함
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);

%>

<script>
	location.href="/";
</script>













