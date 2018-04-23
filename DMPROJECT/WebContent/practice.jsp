<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,java.util.*,javax.swing.*"%>
    
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
//rs.next();


if(rs.next())
{
id  = rs.getInt("employeedimid");
System.out.print("ID: " + id+" ");
}
else
{
	id=0;
	//out.println("Enter correct token");
	//Thread.sleep(5000);
	//JOptionPane.showMessageDialog(null, "Java is fun!");
	
	 out.println("<script type=\"text/javascript\">");
   out.println("alert('Enter correct token');");
   out.println("location='existinguserstoken.html';");
   out.println("</script>");
		//response.sendRedirect("existinguserstoken.html");
}
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div id="container" class="container">
	
	<center>
	<form action="practice2.jsp" method="post">
		
		<input type="hidden" value="<%=id%>" name="empval"/>
		<%session.setAttribute("empid", id); %>
	</form>
	<div class="panel panel-info" style="width:300px;margin-top:70px">
	<div class="panel-heading">Upload Data</div>
	<form>
	<br>
		Download Excel File<br>
		<a href="DownloadFile.jsp" style="padding-top:12px;padding-bottom:15px"download>Download</a><br>
	
	</form>
	
	<form action="fileupload" method="post" enctype="multipart/form-data" onsubmit="downloadfile()">
		Enter file: <input type="file" accept=".xlsx, .xls, .csv" name="input" style="padding-top:12px;padding-left:45px"/>
		<button type="submit" class="btn btn-primary mb-2" style="margin-top:12px">Submit</button>
	</form>
	</div>
	</center>
	
	</div>
	
	<script type="text/javascript">
		downloadfile()
		{
			
			
		}
	
	</script>
	

</body>
</html>