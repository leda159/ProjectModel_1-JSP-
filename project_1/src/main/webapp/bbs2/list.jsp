<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>

<style>
	.td_bottom {
		border-bottom:1px solid gray;
		text-align:center;
		font-weight:bold;
		font-size:20px;
		background:#c0f1f9;
	}
	.td_bottom2 {
		border-bottom:1px solid gray;
		text-align:center;
		font-size:15px;
	}
	.td_bottom3 {
		border-bottom:1px solid gray;
		text-align:center;
		background:#eee;
		font-size:15px;
	}
	.td_bottom5{
		border-bottom:1px solid gray;
		text-align:left;
		font-size:15px;
	}
	a{
		text-decoration: none;
		color:black;
		font-size:15px;
	}
	button{
		cursor:pointer;
	}
</style>
<%
request.setCharacterEncoding("utf-8");
String code = request.getParameter("code");
//검색어 부분
String field;
String search;
if(request.getParameter("search") != null && !request.getParameter("search").equals("")){
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

<%
String sql_count = "";
if(request.getParameter("search") != null && !request.getParameter("search").equals("")){ //검색어 있다면
	sql_count = "select count(*) from "+code+" where "+field+" like '%"+search+"%'";
}else{
	sql_count = "select count(*) from "+code+"";
}
Connection conn_count = DriverManager.getConnection(url, user, password);
Statement stmt_count = conn_count.createStatement();
ResultSet rs_count = stmt_count.executeQuery(sql_count);
int total_count = 0;
if(rs_count.next()){
	total_count = rs_count.getInt(1); //총 게시물 수
}
//페이징 관련 변수들
//현재 페이지 수
int page_now = 1;
if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now"));
}
int num_per_page = 10; //한 페이지당 출력 게시물 수
int page_per_block = 5; //한 블럭당 출력할 링크 수
int first = 0; //limit 시작 값
	first = num_per_page * (page_now - 1);
int total_page = 0; //총 페이지 수
	total_page = (int)Math.ceil(total_count / (double)num_per_page);
%>
<table width=700 border=0 align=center>
	<tr><td colspan=6 align=center style="font-size:30px"><b>같이 가실분 모집</b></td></tr>
	<tr><td colspan=6 height=10></td></tr>
	<tr><td colspan=6>Total : <%=total_count %></td></tr>
	<tr><td colspan=6 height=1 ></td></tr>
	<tr>
		<td class="td_bottom">No</td>
		<td class="td_bottom">제목</td>
		<td class="td_bottom">글쓴이</td>
		<td class="td_bottom">여행장소</td>
		<td class="td_bottom">출국일자</td>
		<td class="td_bottom">입국일자</td>
	</tr>
	<%
	//일반글
	String sql = "";
	if(request.getParameter("search") != null && !request.getParameter("search").equals("")){ //검색어 있는 경우
		sql = "select * from "+code+" where "+field+" like '%"+search+"%' order by fid desc, thread asc limit "+first+","+num_per_page+"";
	}else{ //검색어 없는 경우
		sql = "select * from "+code+" order by fid desc,thread asc limit "+first+","+num_per_page+"";
	}
	//out.print(sql);
	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	
	//넘버링
	int numbering = total_count - (page_now -1) * num_per_page;
	
	while(rs.next()){
		int uid = rs.getInt("uid");		
		String subject = rs.getString("subject"); //제목
		String id = rs.getString("id"); //글쓴이 아이디
		String place = rs.getString("place"); //여행장소
		String datee = rs.getString("datee"); //출국일자
		String datea = rs.getString("datea"); //입국일자
		String signdate = rs.getString("signdate"); //날짜
		String name = rs.getString("name");
		
		//제목 길이
		int sub_len = subject.length();
		if(sub_len > 20){
			subject = subject.substring(0, 20)+"...";
		}else{
			subject = subject;
		}
		
			
	%>
	<tr>
		<td class="td_bottom2"><%=numbering %></td>
		<td class="td_bottom5"style="text-align:left" >
			<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>"><%=subject %></a>
			<%
			//2일전까지 최신글 처리
			java.util.Date today_list, day_22;
			//2일전 날짜
			java.util.Date today = new java.util.Date(); //오늘날짜
			java.util.Date day2 = new java.util.Date(today.getTime() - (long)(1000*60*60*24*2));
			SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd");
			String day_2 = bbb.format(day2);
			day_22 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2);
			//리스트 입력날짜
			today_list = new SimpleDateFormat("yyyy-MM-dd").parse(signdate);			 
			%>
			<%if(today_list.getTime() >= day_22.getTime()){%><img src="img/main_new.gif"><%}%>
		</td>
		<td class="td_bottom2"><%=name %></td>
		<td class="td_bottom2"><%=place %></td>
		<td class="td_bottom2"><%=datee %></td>
		<td class="td_bottom2"><%=datea %></td>
		
		
		
		
	</tr>
	<%
		numbering--;
	}
	if(total_count == 0){ //총 게시물 수가 0
	%>
	<tr>
		<td height=100 colspan=5 class="td_bottom2" align=center>작성된 게시물이 없습니다.</td>
	</tr>
	<%
	}
	%>
</table>
<table width=700 border=0 align=center>
	<tr>
		<td><button onclick="location.href='list.jsp?code=<%=code%>'">새로고침</button></td>
		<td align=right><button onclick="location.href='write.jsp?code=<%=code%>'">글쓰기</button></td>
	</tr>
	<tr>
		<td colspan=2 align=center>	
<%
/////////////////////
//페이징 처리
int total_block = 0; //전체 블럭수
int block = 0; //현재 블럭
int first_page = 0;
int last_page = 0;
int direct_page = 0; //현재 페이지
int my_page = 0;
total_block = (int)Math.ceil(total_page / (double)page_per_block); //총 블럭 수
block = (int)Math.ceil(page_now / (double)page_per_block);
first_page = (block - 1) * page_per_block;
last_page = block * page_per_block;
if(total_block <= block) {
	last_page = total_page;
}
%>

<%
//out.print(last_page);
			// 이전 블럭 처리
			if(block == 1){
%>
				&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/btn_left.gif">&nbsp;&nbsp;
<%			
			}else{
				my_page = first_page;
%>
				<a href="list.jsp?code=<%=code%>&page_now=<%=my_page%>&field=<%=field%>&search=<%=search%>"><img src="img/btn_left.gif"></a>&nbsp;&nbsp;
<%
			}
			for(direct_page = first_page + 1; direct_page <= last_page; direct_page++){
				if(page_now == direct_page){
%>
					<font size=3px color=#1E90FF><b><%=direct_page%></b></font>&nbsp;
<%
				}else{
%>
					<b><a href="list.jsp?code=<%=code%>&page_now=<%=direct_page%>&field=<%=field%>&search=<%=search%>"><%=direct_page%></a></b>&nbsp;
<%
				}
			}			
			// 다음 블럭 처리
			if(block < total_block) {
				my_page = last_page + 1;
%>
				&nbsp;<a href="list.jsp?code=<%=code%>&page_now=<%=my_page%>&field=<%=field%>&search=<%=search%>"><img src="img/btn_right.gif"></a>
<%
			}else{
%>
				&nbsp;<img src="img/btn_right.gif">
<%
			}
%>
		</td>
	</tr>
</table>
<form action="list.jsp?code=<%=code%>" method="post">
<table width=700 border=0 align=center>
	<tr>
		<td align=right width=300>
			<select name="field">
				<option value="place" <%if(field.equals("place")){%>selected<%}%>>여행장소</option>
				<option value="name" <%if(field.equals("name")){%>selected<%}%>>글쓴이</option>
			</select>
		</td>
		<td width=200>
			<input name="search" style="width:200px" value="<%=search%>">
		</td>
		<td width=300>
			<button>검색</button>
		</td>
	</tr>
</table>
</form>

<%@ include file="/include/footer.jsp" %>








