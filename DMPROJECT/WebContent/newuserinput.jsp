<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@page import="java.security.*" %>



<%!
	
	public void sendmail(String email,String email1)
	{
	final String username = "dmprojectfin@gmail.com"; // enter your mail id
	final String password = "1234Abcd@";// enter ur password

	Properties props = new Properties();
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.starttls.enable", "true");
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.port", "587");

	Session session = Session.getInstance(props,
	  new javax.mail.Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(username, password);
		}
	  });

	try {

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress("dmprojectfin@gmail.com")); // same email id
		message.setRecipients(Message.RecipientType.TO,
			InternetAddress.parse(email));// whome u have to send mails that person id
		message.setSubject("Testing Subject");
		message.setText("Registration successful, Token is + "+email1 );

		Transport.send(message);

		System.out.println("Done");

	} catch (MessagingException e) {
		throw new RuntimeException(e);
	}
	}
%>






<%!
public String cryptWithMD5(String pass){
    MessageDigest md;
    try{
        md = MessageDigest.getInstance("MD5");
        byte[] passBytes = pass.getBytes();
        md.reset();
        byte[] digested = md.digest(passBytes);
        StringBuffer sb = new StringBuffer();
        for(int i=0;i<digested.length;i++){
            sb.append(Integer.toHexString(0xff & digested[i]));
        }
        return sb.toString();
    }
        catch(Exception e){
        	return null;
     }
        
}
%>

<%
String first_name=request.getParameter("first_name");
String last_name=request.getParameter("last_name");
String name=first_name.concat(last_name);
name=cryptWithMD5(name);
String panno=request.getParameter("panno");
panno=cryptWithMD5(panno);
char gender=request.getParameter("gender").charAt(0);
String dob=request.getParameter("dob");
String address=request.getParameter("address");
String city=request.getParameter("city");
String state=request.getParameter("state");
String country=request.getParameter("country");
int pincode=Integer.parseInt(request.getParameter("pincode"));
String mobile=(request.getParameter("mobile"));
String email=request.getParameter("email");
String email1=cryptWithMD5(email);
String marital_status=request.getParameter("marital_status");
String annual_salary=request.getParameter("annual_salary");
String designation=request.getParameter("designation");
String noe=request.getParameter("noe");
String nod=request.getParameter("nod");
String earners=request.getParameter("earners");
String annual_expenses=request.getParameter("annual_expenses");

try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
Statement st=conn.createStatement();
//,adharno,gender,age,mobno,annualsalary,natureofemployment,noofearners,noofdependents
 int i=st.executeUpdate("insert into employeedim(Name,PAN_No,Gender,DOB,Address1,City,State,Country,Pincode,MobNo,email_Id,MaritalStatus,Annual_Salary,Designation,NatureOfEmployement,NoOfDependents,NoOfEarners,MonthlyExpenses)values('"+name+"','"+panno+"','"+gender+"','"+dob+"','"+address+"','"+city+"','"+state+"','"+country+"','"+pincode+"','"+mobile+"','"+email1+"','"+marital_status+"','"+annual_salary+"','"+designation+"','"+noe+"','"+nod+"','"+earners+"','"+annual_expenses+ "')");
 		//"','"+gender+"','"+age+"','"+mobile+"','"+salary+","+noe+"','"+earners+"','"+dependents+
// 		"')");

sendmail(email,email1);
out.println("Data is successfully inserted!,token sent");
out.println("<a href='index.html'>Main Menu</a>");

}
catch(SQLIntegrityConstraintViolationException e) 
{
	  out.println("You have already registered");
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}

%>


