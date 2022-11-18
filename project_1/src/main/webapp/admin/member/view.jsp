<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/admin/include/header.jsp" %>
<style>
.td_a{
font-size:15px;
border-bottom:1px solid gray;
}
</style>

<!--id값을 받아온 후 idd변수 처리-->
<!--idd값을 sqll에 삽입하기 위한 변수(sqll)로 처리-->
<!--sqll을 객체rs로 담는다-->
<%
String idd = request.getParameter("id");
String sqll = "select * from member where id='"+idd+"'";

Connection conn = DriverManager.getConnection(url, user, password); 
Statement stmt = conn.createStatement(); 
ResultSet rs = stmt.executeQuery(sqll);







//<!--객체rs 값들을 화면상에 출력-->
if(rs.next()){
%>   

<table width=700 align=center border=0>
   <tr bgcolor="#c0f1f9" height=30>
      <td colspan = 2 align=center style="font-size:25px;"><b>회원 상세보기</b></td>
   </tr>
   <tr>
      <td class="td_a">ID&nbsp;:</td>
      <td class="td_a"><%=rs.getString("id") %></td>
   </tr>
   <tr>
      <td class="td_a">Name&nbsp;:</td>
      <td class="td_a"><%=rs.getString("name") %></td>
   </tr>
   <tr>
      <td class="td_a">Date Of Birth&nbsp;:</td>
      <td class="td_a"><%=rs.getString("age") %></td>
   </tr>
    <tr>
      <td class="td_a">Phone&nbsp;:</td>
      <td class="td_a"><%=rs.getString("phone") %></td>
   </tr>
   <tr>
      <td class="td_a">E-mail&nbsp;:</td>
      <td class="td_a">
         <%=rs.getString("email1") %>@<%=rs.getString("email2") %>
      </td>
   </tr>
   <tr>
      <td class="td_a">Address&nbsp;:</td>
      <td class="td_a">
         <table>
            <tr>
               <td class="td_a">
                  <%=rs.getString("zipcode") %>
               </td>
            </tr>
            <tr>
               <td class="td_a">
                  <%=rs.getString("zipcode1") %> (<%=rs.getString("zipcode2") %>)
               </td>
            </tr>
            <tr>
               <td class="td_a">
                  <%=rs.getString("zipcode3") %> <%=rs.getString("zipcode4") %>
               </td>
            </tr>
         </table>
      </td>
   </tr>
   <tr>
      <td style="font-size:15px">Gender&nbsp;:</td>
      <td style="font-size:15px">
         <%
         if(rs.getString("gender").equals("F")){
            out.print("여자");
         }else{
            out.print("남자");
         }
         %>
      </td>
   </tr>
</table>
<%
}
%>
<table heigh=10><tr><td></td></tr></table>
<table width=700 align=center border=0 >
   <tr>
      <td bgcolor="#e2e2e2">
         <a href='modify.jsp?id=<%=rs.getString("id")%>'><button type="button">수정</button></a>
         <a href='delete.jsp?id=<%=rs.getString("id")%>'><button type="button">삭제</button></a>
      </td>
   </tr>
</table>


<%@include file="/admin/include/footer.jsp" %>