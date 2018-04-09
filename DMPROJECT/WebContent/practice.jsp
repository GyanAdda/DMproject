<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String token =request.getParameter("token");
int id=0;
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
Statement st=conn.createStatement();
String sql = "SELECT employeeDimID FROM employeeDim where email_ID  = '" + token+"'";

ResultSet rs = st.executeQuery(sql);
rs.next();
id  = rs.getInt("employeedimid");
System.out.print("ID: " + id+" ");

 rs.close();
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<form action="practice2.jsp" method="post">
		<input type="hidden" value="<%=id%>" name="empval"/>
		<%session.setAttribute("empid", id); %>
	</form>
	<form action="fileupload" method="post" enctype="multipart/form-data">
		Enter file: <input type="file" accept=".xlsx, .xls, .csv" name="input" />
		<input type="submit" value="submit"/>
	</form>
	
	<script type="text/javascript">
		downloadfile()
		{
			<%	%>
		}
	
	</script>
	

</body>
</html>