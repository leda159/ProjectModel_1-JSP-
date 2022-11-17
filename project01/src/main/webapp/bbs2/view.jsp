<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>
<style>
	button{
		cursor:pointer;
	}
	.font_{
		font-size:18px;
		white-space:pre-line
	
	}
	.fontt_{
		font-size:13px;
		white-space:pre-line
		
	}
	.td_stlye{
		font-weight:bold;
		font-size:20px;
		white-space:pre-line
	}

</style>
<%
String code = request.getParameter("code");
String uid = request.getParameter("uid");

//검색어 부분
String field;
String search;

if(request.getParameter("search") != null){
	field = request.getParameter("field");
	search = request.getParameter("search");
}else{
	field = "";
	search = "";
}
%>
<%

String table_title = "";
//변수code의 값이notice면 타이틀명은 "공지사항"
if(code.equals("notice")){
	table_title = "여행꿀팁";
}else if(code.equals("noticea")){
	table_title = "같이 가실분 모집";
}else if(code.equals("noticeb")){
	table_title = "여행 추천지";
}else if(code.equals("gallery")){
	table_title = "Photo Zone";
}else if(code.equals("qna")){
	table_title = "Q&A";
}else{
	table_title = "존재하지 않는 게시판";
}

%>

<script>
function delete_write(){
	var result = confirm("삭제 하시겠습니까?");
	if(result == true){
		location.href="delete.jsp?code=<%=code%>&uid=<%=uid%>";
	}
}
</script>

<table width=700 border=0 align=center>
	<tr><td align=center style="font-size:30px"><b><%=table_title %></b></td></tr>
	<tr><td height=30 style="background:#c0f1f9;"></td></tr>
</table>

<%
//조회수 +1 처리
String sql_update = "update "+code+" set ref=ref+1 where uid="+uid+"";
Connection conn_update = DriverManager.getConnection(url, user, password);
Statement stmt_update = conn_update.createStatement();
stmt_update.executeUpdate(sql_update);

//상세정보
String sql = "select * from "+code+" where uid="+uid+"";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String name = "";
String id = "";
String phone = "";
String age = "";
String per = "";
String place = "";
String gender = "";
String signdate ="";
String names = "";
String datee = "";
String datea = "";





if(rs.next()){
	subject = rs.getString("subject");
	name = rs.getString("name");
	id = rs.getString("id");
	phone = rs.getString("phone");
	age = rs.getString("age");
	per = rs.getString("per");
	place = rs.getString("place");
	gender = rs.getString("gender");
	signdate = rs.getString("signdate");
	names = rs.getString("names");
	datee = rs.getString("datee");
	datea = rs.getString("datea");
	
	

}

%>

<table width=700 height=350 border=0 align=center>
	<tr width=700 height=50>
		<td class="td_stlye" width=100>제목</td>
		<td><input READONLY id="subject" name="subject" value="<%=subject %>" style="width:99%;height:89%;" maxlength="100"></td>
	</tr>

	<tr width=700 height=40>
		<td class="td_stlye" width=100>이름</td>
		<td><input READONLY id="names" name="names" value="<%=names %>" style="width:99%;height:89%;" maxlength="100"></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>성별</td>
		<td><input READONLY id="gender" name="gender" value="<%if(gender.equals("M")){%>남자<%}else{%>여자<%}%>"<%=gender %> style="width:99%;height:89%;" maxlength="100"></td>
	</tr>
	</tr >
	<tr width=700 height=40>
		<td class="td_stlye" width=100>연락처</td>
		<td><input READONLY id="phone" name="phone" value="<%=phone %>" style="width:99%; height:90%;"></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>나이</td>
		<td><input READONLY id="age" name="age" value="<%=age %>" style="width:99%; height:90%;"></input></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>모집입원</td>
		<td><input READONLY id="per" name="per" value="<%=per %>" style="width:99%; height:90%;"></input></td>
	</tr>	
	<tr width=700 height=40>
		<td class="td_stlye" width=100>여행장소</td>
		<td><input READONLY id="place" name="place" value="<%=place %>" style="width:99%; height:90%;"></input></td>
	</tr>
	<tr width=700 height=30>
		<td class="td_stlye" width=100>출국일자</td>
		<td><input READONLY id="datee" name="datee" value="<%=datee %>" style="width:99%; height:90%;"></input></td>
	</tr>
	<tr width=700 height=30>
		<td class="td_stlye" width=100>입국일자</td>
		<td><input READONLY id="datea" name="datea" value="<%=datea %>" style="width:99%; height:90%;"></input></td>
	</tr>
	
		
	


</table>
<table whidth=700 height=20 border=0><tr><td></td></tr></table>
<!-- 한줄 댓글 -->
<script>
function comment_go(){
	var comment_id = "<%=session_id%>";
	
	if(comment_id == "null"){
		alert("로그인 후 작성가능합니다.");
		location.href="/member/login.jsp";
		return false;
	}
	document.submit();
}

</script>
<form action="comment_insert.jsp?code=<%=code%>&uid=<%=uid%>" method="post" onsubmit="return comment_go()">
<input type="hidden" name="name" value="<%=session_name%>">
<table width=700 border=0 align=center>
	<tr bgcolor="#e2e2e2">
		<td width=20 style="font-size:20px;"><a style="text-aling:top;">ID:</a></td>
		<%if(session_id == null){ %>
			<td width=100><input style="width:80px; border:none; font-size:15px;"name="id" value=""readonly></td>
			<td width=400><input style="width:450px;border:none; "name="view_comment" value="" placeholder="여러분의 소중한 댓글을 입력해주세요.""></td>
		<%}else{%>
			<td width=100><input style="width:80px; border:none; font-size:15px;"name="id" value="<%=session_name%>"readonly></td>
			<td width=400><input style="width:450px;border:none; "name="view_comment" value="" placeholder="여러분의 소중한 댓글을 입력해주세요.""></td>
		<%}%>
		<td width=180 align=right><button>댓글작성</button></td>
	</tr>
</table>
<table width=700 height=10 >
	<tr>
		<td></td>
	</tr>
</table>
</form>
<!-- 한줄 댓글 목록 -->
<table width=700 border=0 align=center>
	<%
	String sql_comment = "select * from comment where tb_table='"+code+"' and tb_uid="+uid+"";

	Connection conn_comment = DriverManager.getConnection(url, user, password);
	Statement stmt_comment = conn_comment.createStatement();
	ResultSet rs_comment = stmt_comment.executeQuery(sql_comment);
	
	while(rs_comment.next()){
		int c_uid = rs_comment.getInt("uid");
		String c_comment = rs_comment.getString("tb_comment");
		
		int sub_len = c_comment.length();
		
		if(sub_len > 35){
			c_comment = c_comment.substring(0,35)+"...";
		}else{
			c_comment = c_comment;
		}
	%>
	<tr>
		<td width=100"><%=rs_comment.getString("tb_id") %></td>
		<td width=500 style="border-bottom:1px solid gray;"><%=c_comment%></td>
		<td align=right width=100>
		<%
		String td_id = rs_comment.getString("tb_id");
		%>
		
		<%
		if(session_level !=null && (session_level.equals("10") || td_id.equals(session_id))){
		%>
			<button onclick="delete_com(<%=c_uid%>)">삭제</button>
		<%
		}else{
		%>
			<button onclick="alert('작성자만 삭제 됩니다.')">삭제</button>
		<%
			}
		%>
		<%
		}
		%>
		
		</td>
	</tr>
</table>
<script>
function delete_com(num){
	var result = confirm("삭제하시겠습니까?");
	if(result == true){
		location.href="comment_delete.jsp?code=<%=code%>&uid=<%=uid%>&c_uid="+num;
	}
}
</script>
<table height=50><tr><td></td></tr></table>
<table width=700 border=0 align=center>
	<tr>
		<td>
			<button onclick="location.href='list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>'">목록</button>
		</td>
		<td align=right>
			
			
		<%if(session_level != null && (session_level.equals("10")|| id.equals(session_id))){%>
				<button onclick="location.href='modify.jsp?code=<%=code%>&uid=<%=uid%>'">수정</button>
				<a onclick="delete_write()"><button type="button">삭제</button></a>

		<%}else{%>
				

		<% }%>
		
	
		
		</td>
	</tr>
</table>

<%@ include file="/include/footer.jsp" %>  





