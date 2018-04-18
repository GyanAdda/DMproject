<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.*,java.util.*"%>
<%
 String filename="Book.xlsx";
String filepath="C:\\Users\\himesh\\Desktop\\dmfiles\\";
response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");   
response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
PrintWriter out1=response.getWriter();
FileInputStream fileInputStream=new FileInputStream(filepath + filename); 
int i;
System.out.println(filepath+filename);
while ((i=fileInputStream.read()) != -1) {  
  out1.write(i);   
}   
fileInputStream.close();   
%>