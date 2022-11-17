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
if(session_id == null){
%>
<script>
	alert("로그인 후 작성하실 수 있습니다.\n로그인 페이지로 이동합니다.");
	location.href="/member/login.jsp";
</script>
<%}%>

<%String code = request.getParameter("code");%>
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

<table width=700 border=0 align=center>
	<tr><td align=center style="font-size:30px"><b>글쓰기</b></td></tr>
	<tr><td height=10></td></tr>
</table>

<form action="write_insert.jsp" method="post" enctype="multipart/form-data" onsubmit="return write2()">
<input type="hidden" name="code" value="<%=code%>">
<table width=700 height=450 border=0 align=center>
	<tr width=700 height=30>
		<td class="td_stlye">옵션</td>
		<td>
			<select name="gongji">
			<%if(session_level != null && session_level.equals("10") && session_id != null){%>
				<option value="1">공지</option>
				<option value="2">일반</option>
				<option value="3">비밀</option>
			<%}else if(session_level != null && session_id != null){%>
				<option value="2">일반</option>
				<option value="3">비밀</option>
			<%}else{%>
				<option value="2">일반</option>
				<option value="3">비밀</option>
				<%}%>
		</select> 
		</td>
	</tr>
	<tr width=700 height=50>
		<td class="td_stlye">제목</td>
		<td><input id="subject" name="subject" value="" style="width:99.6%;height:90%;" maxlength="100"></td>
	</tr>
	<tr width=700 height=290>
		<td class="td_stlye">내용</td>
		<td><textarea id="comment" name="comment" style="width:100%; height:90%;"></textarea></td>
	</tr>
	<tr width=700 height=30>
		<td class="td_stlye">첨부</td>
		<td><input type="file" name="file1"></td>
	</tr>
	<tr width=700 height=30>
		<td class="td_stlye">링크</td>
		<td><textarea id="link" name="link" style="width:100%; height:90%;"></textarea></td>
	</tr>
	<tr width=700 height=30>
		<td></td>
		<td align=right><button>글쓰기</button></td>
	</tr>
</table>
</form>

<%@ include file="/include/footer.jsp" %>









