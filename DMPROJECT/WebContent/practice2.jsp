<%@page import="excelpackage.excelfile"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%String s=(String)request.getAttribute("bookname"); 

	int id=(int)session.getAttribute("empid");
	
	
%>
<html>
<head>
</head>
<body>


  <h1><%= excelfile.storedata(s,id) %></h1> 
</body>
</html>