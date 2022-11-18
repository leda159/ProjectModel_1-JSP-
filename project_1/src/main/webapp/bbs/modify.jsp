<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>
<style>
	.td_stlye{
		font-weight:bold;
		font-size:20px;
	}
	
	button {
	font-size:15px; 
	cursor:pointer;
	}
</style>
<%
String code = request.getParameter("code");
String uid = request.getParameter("uid");

String sql = "select * from "+code+" where uid="+uid+"";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String gongji = "";
String subject = "";
String comment = "";
String id = "";
String file1 = "";
String link = "";

if(rs.next()){
	gongji = rs.getString("gongji");
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	id = rs.getString("id");
	file1 = rs.getString("file1");
	link = rs.getString("link");
}

if(session_level != null && (session_level.equals("10") || id.equals(session_id))){
	
}else{
%>
	<script>
		alert("관리자 or 작성자만 수정할 수 있습니다.");
		location.href="/";
	</script>
<%
}
%>    

<script>
function write2(){
	if(subject.value == ""){
		alert("제목을 입력하세요.");
		subject.focus();
		return false;
	}
	if(comment.value == ""){
		alert("내용을 입력하세요.");
		comment.focus();
		return false;
	}
	document.submit();
}
</script>

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

<table width=700 border=0 align=center>
	<tr><td align=center style="font-size:30px"><b>수정하기</b></td></tr>
	<tr><td height=10></td></tr>
</table>

<form action="modify_update.jsp" method="post" onsubmit="return write2()" enctype="multipart/form-data">
<input type="hidden" name="code" value="<%=code%>">
<input type="hidden" name="uid" value="<%=uid%>">
<table width=700  height=450 border=0 align=center>
	<tr width=700 height=40>
		<td class="td_stlye">옵션</td>
		<td>
			<select name="gongji">
				<option value="1"<%if(gongji.equals("1")){%>selected<%}%>>공지</option>
				<option value="2"<%if(gongji.equals("2")){%>selected<%}%>>일반</option>
				<option value="3"<%if(gongji.equals("3")){%>selected<%}%>>비밀</option>
			</select> 
		</td>
	</tr width=700 height=50>
	<tr>
		<td class="td_stlye">제목</td>
		<td><input id="subject" name="subject" value="<%=subject %>" style="width:98.6%;height:90%"></td>
	</tr>
	<tr width=700 height=290>
		<td class="td_stlye" >내용</td>
		<td><textarea id="comment" name="comment" style="width:99%;height:90%;"><%=comment %></textarea></td>
	</tr>
	<tr width=700 height=30>
		<td class="td_stlye">첨부</td>
		<td><input type="file" name="file1">
			<%if(!file1.equals("")){ %><font color=red><%=file1 %></font><%}%>	
		</td>
	</tr>
	<tr width=700 height=30>
		<td class="td_stlye">링크</td>
		<td><textarea id="link" name="link" style="width:99%; height:90%;"></textarea></td>
	</tr>
	<tr width=700 height=30>
		<td></td>
		<td align=right><button>수정하기</button></td>
	</tr>
</table>
</form>

<%@ include file="/include/footer.jsp" %>



