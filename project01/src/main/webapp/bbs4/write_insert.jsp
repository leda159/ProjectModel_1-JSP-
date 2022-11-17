<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="/include/header.jsp" %>
<%@ include file="/include/dbconnection.jsp" %>
    
<%
request.setCharacterEncoding("utf-8");

String saveDir="C:\\jsp_project\\testa\\src\\main\\webapp\\upload";
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
String go = multi.getParameter("gongji");
String su = multi.getParameter("subject");
String co = multi.getParameter("comment");
String ln = multi.getParameter("link"); 

//날짜 구하기
java.util.Date date = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = cal.format(date);

String sql = "insert into "+code+" (id,name,gongji,subject,comment,signdate,file1,file1_o,link) values ('"+session_id+"','"+session_name+"','"+go+"','"+su+"','"+co+"','"+signdate+"','"+file1_rename+"','"+file1_name+"','"+ln+"')";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>
<script>
	location.href="list.jsp?code=<%=code%>";
</script>





