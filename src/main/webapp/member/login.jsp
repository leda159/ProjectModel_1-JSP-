<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>


<!--ID PASS가 빈값일때 알림창-->
<script type="text/javascript">
function loginok(){
	if(memid.value == ""){
		alert("아이디를 입력하세요.");
		memid.focus();
		return false;
	}
	if(!mempass.value){
		alert("비밀번호를 입력하세요.");
		mempass.focus();
		return false;
	}
	document.submit();
}
</script>

<!-- CSS -->
<style>
#memid{border-radius:20px; border-color:#e2e2e2;}
#mempass{border-radius:20px; border-color:#e2e2e2;}

input:focus{outline: none;}
</style>



<!-- 입력한 값들을 from을 이용해서 login_ok로 보냄 -->
<form name="login" action="/member/login_ok.jsp" method="post" onsubmit="return loginok()">
<table  width=700 height=100 border=0 align=center font-size: 150%;>	
	<tr bgcolor="#c0f1f9" height=40>
		<td colspan=2 align=center style="font-weight:bold; font-size:25px;"><b>로그인</b></td>
	</tr>
	<tr >
		<td>&nbsp;&nbsp;&nbsp;아이디</td>
		<td><input id="memid" name="memid" value="" placeholder="아이디를 입력해주세요."></td>
	</tr>
	<tr>
		<td >&nbsp;&nbsp;&nbsp;비밀번호</td>
		<td><input id="mempass" name="mempass" value="" placeholder="비밀번호를 입력해주세요."></td>
	</tr>
	<tr>
		<td bgcolor="#e2e2e2"><button>로그인</button></td>
		<td bgcolor="#e2e2e2" align=right >
			<a onclick="id_search()" style="font-size:15px; vertical-align: middle;"><button type="button">아이디 찾기</button></a>
			<a onclick="pass_search()" style="font-size:15px; vertical-align: middle;"><button type="button">비밀번호 찾기</button></a>
		</td>
	</tr>
</table>
</form>



<!--ID PASS찾기-->
<script>
function id_search(){
	window.open("id_search.jsp","aa","width=450,height=300,left=0");
}

function pass_search(){
	window.open("pass_search.jsp","bb","width=450,height=300,left=400");
}
</script>

<table width=700 height=385 border=0>
	<tr>
		<td></td>
	</tr>
</table>
<%@ include file="/include/footer.jsp" %>










