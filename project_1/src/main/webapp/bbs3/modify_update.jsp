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

String code = multi.getParameter("code");
String uid = multi.getParameter("uid");
String go = multi.getParameter("gongji");
String su = multi.getParameter("subject");
String co = multi.getParameter("comment");
String ln = multi.getParameter("link");

String sql = "";

if(file1_name != null){ //첨부가 있다.
	sql = "update "+code+" set gongji='"+go+"',subject='"+su+"',comment='"+co+"',file1='"+file1_rename+"',file1_o='"+file1_name+"',link='"+ln+"' where uid="+uid+"";
}else{
	sql = "update "+code+" set gongji='"+go+"',subject='"+su+"',comment='"+co+"',link='"+ln+"' where uid="+uid+"";
}

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>    

<script>
	location.href="list.jsp?code=<%=code%>";
</script>





