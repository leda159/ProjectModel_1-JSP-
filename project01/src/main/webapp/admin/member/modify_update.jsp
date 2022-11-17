<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

//회원정보 수정값들을 받아온 후 변수처리
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

String sql = "";

//회원정보 수정값을 받아서 업데이트 함
if(pass.equals("")){//비밀번호 변경 안함
	sql="update member set phone='"+phone+"',name='"+name+"',email1='"+email1+"',email2='"+email2+"',zipcode='"+zipcode+"',zipcode1='"+zipcode1+"',zipcode2='"+zipcode2+"',zipcode3='"+zipcode3+"',zipcode4='"+zipcode4+"',gender='"+gender+"',age='"+age+"'where id='"+id+"'";
}else{//비밀번호 변경처리
	sql="update member set pass='"+pass+"',name='"+name+"',phone='"+phone+"',email1='"+email1+"',email2='"+email2+"',zipcode='"+zipcode+"',zipcode1='"+zipcode1+"',zipcode2='"+zipcode2+"',zipcode3='"+zipcode3+"',zipcode4='"+zipcode4+"',gender='"+gender+"',age='"+age+"'where id='"+id+"'";
}

//날짜
java.util.Date date = new java.util.Date();      
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String today = cal.format(date);

String sqls = "insert into member values ('"+id+"','"+pass+"','"+name+"','"+phone+"','"+email1+"','"+email2+"','"+zipcode+"','"+zipcode1+"','"+zipcode2+"','"+zipcode3+"','"+zipcode4+"','"+gender+"','1','"+today+"')";




//업데이트 한 값들을 spl에삽입함
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>



<script>
	alert("변경 되었습니다.");
	location.href = "/admin/member/view.jsp?id=<%=id%>";
</script>








