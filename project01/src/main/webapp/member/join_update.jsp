<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="/include/header.jsp"%>    
<%@ include file ="/include/dbconnection.jsp"%>

<%

request.setCharacterEncoding("utf-8");

//join_up에서 받은 값(회원정보 수정한 값)을 변수처리함
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

String sql="";

//
if(pass.equals("")){//비밀번호 변경 안함	
		sql="update member set name='"+name+"',phone='"+phone+"',email1='"+email1+"',email2='"+email2+"',zipcode='"+zipcode+"',zipcode1='"+zipcode1+"',zipcode2='"+zipcode2+"',zipcode3='"+zipcode3+"',zipcode4='"+zipcode4+"',gender='"+gender+"',age='"+age+"'where id='"+session_id+"'";
}else{				//비밀번호 변경처리
		sql="update member set pass='"+pass+"',name='"+name+"',phone='"+phone+"',email1='"+email1+"',email2='"+email2+"',zipcode='"+zipcode+"',zipcode1='"+zipcode1+"',zipcode2='"+zipcode2+"',zipcode3='"+zipcode3+"',zipcode4='"+zipcode4+"',gender='"+gender+"',age='"+age+"'where id='"+session_id+"'";	
		//update 테이블이름 set 칼럼이름 변수값	
}		

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%> 
<script>
	alert("변경 되었습니다.");
	lacation.href="/member/join_up.jsp";
</script>

