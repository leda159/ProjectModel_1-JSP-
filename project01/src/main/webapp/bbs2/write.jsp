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
	
	}if(names.value == ""){
		alert("이름을 입력하세요.");
		names.focus();
		return false;	
	}if(phone.value == ""){
		alert("연락처를 입력하세요.");
		phone.focus();
		return false;
				
	}if(age.value == ""){
		alert("나이를 입력하세요.");
		age.focus();
		return false;
		
	}if(per.value == ""){
		alert("모집인원을 입력하세요.");
		per.focus();
		return false;
	}
	
	document.submit();
}
</script>

<table width=700 border=0 align=center>
	<tr><td align=center style="font-size:30px"><b>모집글</b></td></tr>
	<tr><td height=10></td></tr>
</table>

<form action="write_insert.jsp" method="post" onsubmit="return write2()">
<input type="hidden" name="code" value="<%=code%>">
<table width=700 height=400 border=0 align=center>
	<tr width=700 height=50>
		<td class="td_stlye" width=100>제목</td>
		<td><textarea id="subject" name="subject" value="" style="width:99%;height:89%;" maxlength="100"></textarea></td>
	</tr>
	<tr width=700 height=150>
		<td class="td_stlye" width=100>내용</td>
		<td><textarea id="comment" name="comment" style="width:99%;height:89%;" maxlength="100"></textarea></td>
	</tr>

	<tr width=700 height=40>
		<td class="td_stlye" width=100>이름</td>
		<td><input id="names" name="names" value="" style="width:99%;height:89%;" maxlength="100"></td>
	</tr>
	</tr >
	<tr width=700 height=40>
		<td class="td_stlye" width=100>연락처</td>
		<td><input id="phone" name="phone" value="" style="width:99%; height:90%;"></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>나이</td>
		<td><input id="age" name="age" value="" style="width:99%; height:90%;"></input></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>모지입원</td>
		<td><input id="per" name="per" value="" style="width:99%; height:90%;"></input></td>
	</tr>	
	<tr width=700 height=40>
		<td class="td_stlye" width=100>여행 장소</td>
		<td>
			<select name="place" style="width:100px;height:30px; text-align:center;">
				<option value="도쿄">도쿄</option>
				<option value="오사카">오사카</option>
				<option value="나고야">나고야</option>
				<option value="후쿠오카">후쿠오카</option>
				<option value="가고시마">가고시마</option>
				<option value="히로시마">히로시마</option>
				<option value="돗토리">돗토리</option>
				<option value="쿄토">쿄토</option>
				<option value="삿포로">삿포로</option>
				<option value="기타지역">기타지역</option>
			</select>
		</td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>출국 일자</td>
		<td><input type="date" id="datee" name="datee" value="" min="2022-08-17" max="2050-12-30"></td>	
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>입국 일자</td>
		<td><input type="date" id="datea" name="datea" value="" min="2022-08-17" max="2050-12-30"></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>성별</td>
		<td>
			<input type="radio" id="gender" name="gender" value="M" checked>남자 
			<input type="radio" id="gender" name="gender" value="F">여자 
		</td>
	</tr>
	<tr width=700 height=40>
		<td></td>
		<td align=right><button>글쓰기</button></td>
	</tr>
</table>
</form>

<%@ include file="/include/footer.jsp" %>









