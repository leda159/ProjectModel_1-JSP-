<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnection.jsp"%>

<%

//sql에서 memid mempass을 받은 후 변수 처리
String id = request.getParameter("memid");
String pass = request.getParameter("mempass");


//id와 pass과 동일한 녀석의 컬럼값을 모두 가져와 sql변수에 담는다
String sql = "select * from member where id ='"+id+"' and pass='"+pass+"'";

//DB연결,DB연동 후 실행
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);


//전역 변수초기화
String mem_id="";
String mem_name="";
String mem_level="";



//sql에서 컬럼id의 값을 불러와서 mem_id에 담는다
//sql에서 컬럼name의 값을 불러와서 mem_name에 담는다
//(rs. 이면 sql에서 받아온다고 생각)
//id,name,level은 값이 아닌 컬럼명
//컬럼명을 mem_이란 변수에 담는다
while(rs.next()){
	mem_id = rs.getString("id"); 
	mem_name = rs.getString("name");
	mem_level = rs.getString("level");
	}

//로그인 화면에서 입력한 값이 sql에있는 값이라면
//se_이란 변수에 mem_값을 담는다   
	if(!mem_id.equals("")){
		session.setAttribute("se_id", mem_id); //세션이 최초로 만들어짐 !
		session.setAttribute("se_name", mem_name);//setsetAttribute값을 설정한다
		session.setAttribute("se_level", mem_level);
%>
<script>
	location.href="/";
</script>
<%
	}else{
%>
	<script>
		alert("아이디가 틀리거나 비밀번호가 틀렸습니다.");
		history.back();
	</script>

<%
	}
%>


