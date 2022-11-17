
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>

<style>
.e { font-family:cursive; 
     font-size:20px;
     color: #1E90FF;     
}
.b{ font-weight: bold;
	font-size:20px;	
	border-bottom:1px solid gray;
}
.table_a {
 	
    border-top: 1px solid #444444;
    border-collapse: collapse;
}
  a{
  	text-decoration: none;
	color:black;
	font-size:15px;
}

 .c {
		border-bottom:1px solid gray;
		text-align:left;
		font-size:13px;
}
.d {
		border-bottom:1px solid gray;
		text-align:left;
		background:#eee;
		font-size:13px;
}
</style>

<%
String sql_count = ""; 

sql_count = "select count(*) from notice where gongji != '1'";
				

Connection conn_count = DriverManager.getConnection(url, user, password); //DB연결
Statement stmt_count = conn_count.createStatement();//SQL실행을 위한 stmt_count객체 생성
ResultSet rs_count = stmt_count.executeQuery(sql_count);//SQL실행




int total_count = 0; 
if(rs_count.next()){ 
	total_count = rs_count.getInt(1);
}



int page_now = 1; 		
if(request.getParameter("page_now") != null){ 
	page_now = Integer.parseInt(request.getParameter("page_now"));
}

int num_per_page = 10; 
int page_per_block = 5; 
int first = 0;
	first = num_per_page * (page_now - 1);
int total_page = 0; 
	total_page = (int)Math.ceil(total_count / (double)num_per_page);
%>



<table width=100% height=200 border=0>
	<tr width=100% height=20>
		<td align=center><p class="e">하라주쿠</p></td>
		<td align=center><p class="e">오다이바</p></td>
		<td align=center><p class="e">우에노</p></td>
		<td align=center><p class="e">도쿄타워</p></td>
		
	</tr>
	<tr width=100% height=180>
		<td align=center><img src="/upload/img01.jpg" width=100% height=200></td>
		<td align=center><img src="/upload/odaiba.jpg" width=100% height=200></td>
		<td align=center><img src="/upload/ueno.jpg" width=100% height=200></td>
		<td align=center><img src="/upload/tokyo tower.jpg" width=100% height=200></td>
		
	</tr>
</table>

<table width=100% height=250 border=0>
	<tr>
		<td align=center width=100%>
			<table width=100% height=100% border=0>
				<tr>
					<!-- 공지사항 -->
					<td width=300>
						<table width=100% height=100% border=0>
							<tr>
								<td class="b" width=300 height=30 colspan=3 bgcolor="#c0f1f9";">여행 꿀팁</td>
							</tr>
						
						
						<%
							//공지글
							if(page_now == 1){
								String sql_gongji = "select * from notice where gongji = '1' order by uid asc";
	
								Connection conn_gongji = DriverManager.getConnection(url, user, password);
								Statement stmt_gongji = conn_gongji.createStatement();
								ResultSet rs_gongji = stmt_gongji.executeQuery(sql_gongji);
		
		
								while(rs_gongji.next()){
								String subject = rs_gongji.getString("subject");
								String signdate = rs_gongji.getString("signdate"); 
								int uid = rs_gongji.getInt("uid");
								
								//제목 길이		
								int sub_len = subject.length();
								
								if(sub_len > 20){
									subject = subject.substring(0,20)+"...";
								}else{
									subject = subject;
								}
								
								signdate = signdate.substring(0,10);
								
							%>
							<tr>
								<td class="d" width=50>[공지]</td>
								<td class="d" style="text-align:left">
									<a href="/bbs/view.jsp?code=notice&uid=<%=uid%>"><%=subject %></a></td>
								<td class="d"><%=signdate%></td>
							</tr>
							
							<%
							}
								}//while
							%>	
								
												
							<!-- 공지글 제외 -->
							<%
							String sql = "";
							sql = "select * from notice where gongji != '1' order by uid asc limit "+first+","+num_per_page+"";
							
							Connection conn = DriverManager.getConnection(url, user, password);
							Statement stmt = conn.createStatement();
							ResultSet rs = stmt.executeQuery(sql);
							
	
							
							//넘버링
							int numbering = total_count - (page_now -1) * num_per_page;
							
								
							while(rs.next()){//객체 rs_notice에 값이 있으면 반복한다. 없을 때까지 반복
								String subject = rs.getString("subject");//get방식으로 "subject"를 전달 받아서 문자형 변수 subject에 담는다
								String signdate = rs.getString("signdate");//날짜
								int uid = rs.getInt("uid");//식별자?
								String name = rs.getString("name");
								
										
								//제목 길이		
								int sub_len = subject.length();
								
								if(sub_len > 20){
									subject = subject.substring(0,20)+"...";
								}else{
									subject = subject;
								}
								
								signdate = signdate.substring(0,10);
							%>
							
							<tr>
								<td class="c"><%=name %></td>
								<td class="c"><a href="/bbs/view.jsp?code=notice&uid=<%=uid%>"><%=subject %></a></td>
								<td class="c"><%=signdate %></td>	
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
					</td>
					<td width=50></td>
					
					<!-- 갤러리 -->
					<td width=300>
						<table width=100% height=100% border=0>
							<tr>
								<td  class="b" width=100% height=30 colspan=5 bgcolor="#c0f1f9"> Photo Zone</td>
							</tr>
							<tr>
								<td width=100% heigt=10 colspan=5></td>
							</tr>
							<tr>
								<%
								String sql_gallery = "select * from gallery where gongji != 1 order by uid desc limit 3";
								
								Connection conn_gallery = DriverManager.getConnection(url, user, password);
								Statement stmt_gallery = conn_gallery.createStatement();
								ResultSet rs_gallery = stmt_gallery.executeQuery(sql_gallery);
								
								int i=1;
								while(rs_gallery.next()){
									String signdate = rs_gallery.getString("signdate");
									String file1 = rs_gallery.getString("file1");
									int uid = rs_gallery.getInt("uid");
									signdate = signdate.substring(0,16);
								%>
								<td width=90>
									<a href="/bbs4/view.jsp?code=gallery&uid=<%=uid%>">"<img src="/upload/<%=file1%>" width=80% height=80%></a>
									<br>
									<%=signdate %>
								</td>
								<%
									if(i != 3){
										out.print("<td width=15></td>");
									}
									i++;
								}
								%>
							</tr>
							<tr>
								<%
								String sql_galleryl = "select * from gallery where gongji != 1 order by uid asc limit 3";
								
								Connection conn_galleryl = DriverManager.getConnection(url, user, password);
								Statement stmt_galleryl = conn_gallery.createStatement();
								ResultSet rs_galleryl = stmt_gallery.executeQuery(sql_galleryl);
								
								int z=1;
								while(rs_galleryl.next()){
									String signdate = rs_galleryl.getString("signdate");
									String file1 = rs_galleryl.getString("file1");
									int uid = rs_galleryl.getInt("uid");
									
									signdate = signdate.substring(0,16);
								%>
								<td width=90>
									<a href="/bbs4/view.jsp?code=gallery&uid=<%=uid%>">"<img src="/upload/<%=file1%>" width=80% height=80%></a>
									<br>
									<%=signdate %>
								</td>
								<%
									if(z != 3){
										out.print("<td width=15></td>");
									}
									z++;
								}
								%>
							</tr>
						</table>
					</td>
					<td width=50></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%@ include file="/include/footer.jsp" %>






