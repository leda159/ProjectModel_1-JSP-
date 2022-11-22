<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String saveDir="C:\\projectModel_1\\projectModel_1\\project_1\\src\\main\\webapp\\upload";
int maxSize = 5* 1024 * 1024; //업로드 될 파일의 크기제한, 단위:byte

MultipartRequest multi= new MultipartRequest(request,saveDir, maxSize,"utf-8",new DefaultFileRenamePolicy());

Enumeration files = multi.getFileNames();

String file1 = (String)files.nextElement();
String file1_name = multi.getOriginalFileName(file1); //사용자가 올린 파일명
String file1_rename = multi.getFilesystemName(file1); //시스템 중복 처리 파일명

if(file1_name == null){
	file1_name = "";
	file1_rename = "";
}

String code = multi.getParameter("code");
String uid = multi.getParameter("uid");
String fid = multi.getParameter("fid");
String thread = multi.getParameter("thread");
String go = multi.getParameter("gongji");
String su = multi.getParameter("subject");
String co = multi.getParameter("comment");
String ln = multi.getParameter("link");

//날짜 구하기
java.util.Date date = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = cal.format(date);

//자식 thread 값 구하기
String sql_th = "select thread,right(thread,1) as thread_right from "+code+" where fid = "+fid+" AND length(thread) = length('"+thread+"')+1 AND locate('"+thread+"',thread) = 1 ORDER BY thread DESC limit 1";

Connection conn_th = DriverManager.getConnection(url, user, password);
Statement stmt_th = conn_th.createStatement();
ResultSet rs_th = stmt_th.executeQuery(sql_th);

String o_thread = "";
String r_thread = "";
String thread_head = "";
String new_thread = "";
char thread_foot = 'a';

if(rs_th.next()){
	o_thread = rs_th.getString("thread"); //부모값
	
	//끝자리 +1 처리
	r_thread = rs_th.getString("thread_right");
	thread_foot = (char)(r_thread.charAt(0) + 1); //자식들 중 제일 큰값 + 1
	//out.print(thread_foot);
}

if(o_thread != null && o_thread != ""){
	thread_head = o_thread.substring(0,o_thread.length()-1);
	new_thread = thread_head + thread_foot; //+1 처리 값
}else{
	new_thread = thread+"A"; //부모값 + A 처리
}

String sql = "insert into "+code+" (id,name,gongji,subject,comment,signdate,file1,file1_o,fid,thread,link) values ('"+session_id+"','"+session_name+"','"+go+"','"+su+"','"+co+"','"+signdate+"','"+file1_rename+"','"+file1_name+"','"+fid+"','"+new_thread+"','"+ln+"')";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>   
<script>
	location.href="list.jsp?code=<%=code%>";
</script>










 