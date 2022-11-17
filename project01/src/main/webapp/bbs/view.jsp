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
		white-space:pre-line;
		border-bottom:1px solid gray;
		
	
	}
	.fontt_{
		font-size:13px;
		white-space:pre-line;
		border-bottom:1px solid gray;
		
		
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
	<tr><td height=10></td></tr>
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

String gongji = "";
String subject = "";
String comment = "";
String name = "";
String id = "";
String signdate = "";
String ref = "";
String file1 = "";
String link = "";

if(rs.next()){
	gongji = rs.getString("gongji");
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	name = rs.getString("name");
	id = rs.getString("id");
	signdate = rs.getString("signdate");
	ref = rs.getString("ref");
	file1 = rs.getString("file1");
	link = rs.getString("link");
}

//비밀글 일때
if(gongji.equals("3")){
	if(session_level != null && (session_level.equals("10") || id.equals(session_id))){
		
	}else{
%>
		<script>
			alert("관리자 or 작성자만 볼 수 있습니다.");
			location.href="/";
		</script>
<%		
	}
}
%>

<table width=700 border=0 align=center>
	<tr width=700 height=20 bgcolor="#c0f1f9">
		<td class="font_" width=200>글쓴이:<%=name %></td>
		<td class="font_" width=400>작성날짜:<%=signdate.substring(0,16) %></td>
		<td class="font_" width=100 align=center>조회수:<%=ref %></td>
	</tr>
	<tr width=700 height=20>
		<td class="font_" width=50>옵션 :</td>
		<td class="fontt_" colspan=2  width=650>
			<%
			if(gongji.equals("1")){
				out.print("공지");
			}else if(gongji.equals("2")){
				out.print("일반");
			}else{
				out.print("비밀");
			}
			%>
		</td>
	</tr>
	<tr width=700 height=30>
		<td class="font_" width=50>제목 :</td>
		<td class="fontt_" colspan=2  width=650><%=subject %></td>
	</tr>
	
	<tr width=700 height=100>
		<td class="font_" width=50>내용 :</td>
		<td class="fontt_" colspan=2  width=650><img src="/upload/<%=file1%>" onerror="this.style.display='none'"><br><%=comment %></td>
	</tr>	
	<tr width=700 height=30>
		<td class="font_" width=50>첨부 :</td>
		<td class="fontt_" colspan=2  width=650>
		<%
		if(!file1.equals("")){
		%>
		<a href="/upload/<%=file1 %>" download><%=file1 %></a>
		<%
		}
		%>
		</td>
	</tr>
	<tr width=700 height=30>
		<td class="font_" width=50>링크:</td>
		<td class="fontt_" colspan=2><a href="http://<%=link %>"target="_blank"><%=link %><a/></td>
	</tr>
</table>
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
<form action="comment_insert.jsp?code=<%=code%>&uid=<%=uid%>" method="post" onsubmit = "return comment_go()">
<input type="hidden" name="name" value="<%=session_name%>">
<table width=700 border=0 align=center>
	<tr>
		<td whith=700 height=20 colspan=5></td>
	</tr>
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
		<td width=100><%=rs_comment.getString("tb_id") %></td>
		<td width=500 style="border-bottom:1px solid gray;"><%=c_comment%></td>
		<td align=right width=100>
			<% 
			String td_id = rs_comment.getString("tb_id");
			%>
			
			<%
			if(session_level != null && (session_level.equals("10") ||  td_id.equals(session_id))){
			%>
				<button onclick="delete_com(<%=c_uid%>)">삭제</button>
			<%
			}else{
			%>
				<button onclick="alert('작성자만 삭제 됩니다.')">삭제</button>
			<% 
				}
			%>
		</td>
	</tr>
	<%
	}
	%>
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
			<%
			if(!gongji.equals("1")){
				if(session_level != null && (session_level.equals("10")|| id.equals(session_id))){
			%>
					<button onclick="location.href='reply.jsp?code=<%=code%>&uid=<%=uid%>'">답변</button>
					<button onclick="location.href='modify.jsp?code=<%=code%>&uid=<%=uid%>'">수정</button>
					<a onclick="delete_write()"><button type="button">삭제</button></a>
			<%	}else if(session_level != null){%>
					<button onclick="location.href='reply.jsp?code=<%=code%>&uid=<%=uid%>'">답변</button>
			
			<%	}else%>
			
			<%
			}else{
				if(session_level != null && (session_level.equals("10")|| id.equals(session_id))){
			%>
					<button onclick="location.href='modify.jsp?code=<%=code%>&uid=<%=uid%>'">수정</button>
					<a onclick="delete_write()"><button type="button">삭제</button></a>
			<%	}if(session_level != null){%>
			
			<%	}else%>
		
			<% 
			}
			%>
		</td>
	</tr>
</table>

<%@ include file="/include/footer.jsp" %>  





