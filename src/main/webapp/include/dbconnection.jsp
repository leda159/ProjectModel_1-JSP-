<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>



<%
//디비 접속
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/project01";
String user = "root";
String password="1111";
%>