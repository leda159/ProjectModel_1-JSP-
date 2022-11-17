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

String id= "";
String subject = "";
String names = "";
String phone = "";
String age = "";
String per = "";
String place = "";
String datee = "";//출국 일자
String datea = "";//입국 일자
String gender = "";


if(rs.next()){
	
	id = rs.getString("id");
	subject = rs.getString("subject");
	names = rs.getString("names");
	phone = rs.getString("phone");
	age = rs.getString("age");
	per = rs.getString("per");
	place = rs.getString("place");
	datee = rs.getString("datee");
	datea = rs.getString("datea");
	gender = rs.getString("gender");
	
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

<form action="modify_update.jsp" method="post" onsubmit="return write2()">
<input type="hidden" name="code" value="<%=code%>">
<input type="hidden" name="uid" value="<%=uid%>">
<table width=700 height=390 border=0 align=center>
	<tr width=700 height=50>
		<td class="td_stlye" width=100>제목</td>
		<td><input id="subject" name="subject" value="<%=subject %>" style="width:99%;height:89%;" maxlength="100"></td>
	</tr>

	<tr width=700 height=40>
		<td class="td_stlye" width=100>이름</td>
		<td><input id="names" name="names" value="<%=names %>" style="width:99%;height:89%;" maxlength="100"></td>
	</tr>
	</tr >
	<tr width=700 height=40>
		<td class="td_stlye" width=100>연락처</td>
		<td><input id="phone" name="phone" value="<%=phone %>" style="width:99%; height:90%;"></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>나이</td>
		<td><input id="age" name="age" value="<%=age %>" style="width:99%; height:90%;"></input></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>모지입원</td>
		<td><input id="per" name="per" value="<%=per %>" style="width:99%; height:90%;"></input></td>
	</tr>	
	<tr width=700 height=40>
		<td class="td_stlye" width=100>여행 장소</td>
		<td>
			<select name="place" value="<%=place %>" style="width:100px;height:30px; text-align:center;">
				<option value="도쿄"<%if(place.equals("도쿄")){%>selected<%}%>>도쿄</option>
				<option value="오사카"<%if(place.equals("오사카")){%>selected<%}%>>오사카</option>
				<option value="나고야"<%if(place.equals("나고야")){%>selected<%}%>>나고야</option>
				<option value="후쿠오카"<%if(place.equals("후쿠오카")){%>selected<%}%>>후쿠오카</option>
				<option value="가고시마"<%if(place.equals("가고시마")){%>selected<%}%>>가고시마</option>
				<option value="히로시마"<%if(place.equals("히로시마")){%>selected<%}%>>히로시마</option>
				<option value="돗토리"<%if(place.equals("돗토리")){%>selected<%}%>>돗토리</option>
				<option value="쿄토"<%if(place.equals("쿄토")){%>selected<%}%>>쿄토</option>
				<option value="삿포로"<%if(place.equals("삿포로")){%>selected<%}%>>삿포로</option>
				<option value="기타지역"<%if(place.equals("기타지역")){%>selected<%}%>>기타지역</option>
			</select>
		</td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>출국 일자</td>
		<td><input type="date" id="datee" name="datee" value="<%=datee %>" min="2022-08-17" max="2050-12-30"></td>	
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>입국 일자</td>
		<td><input type="date" id="datea" name="datea" value="<%=datea %>" min="2022-08-17" max="2050-12-30"></td>
	</tr>
	<tr width=700 height=40>
		<td class="td_stlye" width=100>성별</td>
		<td>
			<input type="radio" id="gender" name="gender" value="M"<%if(gender.equals("M")){ %>checked<%}%>>남자
			<input type="radio" id="gender" name="gender" value="F"<%if(gender.equals("F")){ %>checked<%}%>>여자 
		</td>
	</tr>
	<tr width=700 height=40>
		<td></td>
		<td align=right><button>수정하기</button></td>
	</tr>
</table>
</form>

<%@ include file="/include/footer.jsp" %>



