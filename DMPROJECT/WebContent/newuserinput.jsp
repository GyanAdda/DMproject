<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>



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
	public String encode(String str)
	{
	String Newstr="";
	for (int i=0;i<str.length();i++)  
    {  
        char ch=Character.toLowerCase(str.charAt(i));  
        switch (ch)  
        {  
            case 'a':  
                Newstr=Newstr+"{";  
                break;  
            case 'b':  
                Newstr=Newstr+"}";  
                break;  
            case 'c':  
                Newstr=Newstr+"#";  
                break;  
            case 'd':  
                Newstr=Newstr+"~";  
                break;  
            case 'e':  
                Newstr=Newstr+"+";  
                break;  
            case 'f':  
                Newstr=Newstr+"-";  
                break;  
            case 'g':  
                Newstr=Newstr+"*";  
                break;  
            case 'h':  
                Newstr=Newstr+"@";  
                break;  
            case 'i':  
                Newstr=Newstr+"/";  
                break;  
            case 'j':  
                Newstr=Newstr+"\\";  
                break;  
            case 'k':  
                Newstr=Newstr+"?";  
                break;  
            case 'l':  
                Newstr=Newstr+"$";  
                break;  
            case 'm':  
                Newstr=Newstr+"!";  
                break;  
            case 'n':  
                Newstr=Newstr+"^";  
                break;  
            case 'o':  
                Newstr=Newstr+"(";  
                break;  
            case 'p':  
                Newstr=Newstr+")";  
                break;  
            case 'q':  
                Newstr=Newstr+"<";  
                break;  
            case 'r':  
                Newstr=Newstr+">";  
                break;  
            case 's' :  
                Newstr=Newstr+"=";  
                break;  
            case 't':  
                Newstr=Newstr+";";  
                break;  
            case 'u':  
                Newstr=Newstr+",";  
                break;  
            case 'v' :  
                Newstr=Newstr+"_";  
                break;  
            case 'w':  
                Newstr=Newstr+"[";  
                break;  
            case 'x' :  
                Newstr=Newstr+"]";  
                break;  
            case 'y':  
                Newstr=Newstr+":";  
                break;  
            case 'z' :  
                Newstr=Newstr+"\"";  
                break;  
            case ' ' :  
                Newstr=Newstr+" ";  
                break;  
            case '.':  
                Newstr=Newstr+'3';  
                break;  
            case ',':  
                Newstr=Newstr+"1";  
                break;  
            case '(':  
                Newstr=Newstr+'4';  
                break;  
            case '\"':  
                Newstr=Newstr+'5';  
                break;  
            case ')' :  
                Newstr=Newstr+"7";  
                break;  
            case '?' :  
                Newstr= Newstr+"2";  
                break;  
            case '!':  
                Newstr= Newstr+"8";  
                break;  
            case '-' :  
                Newstr= Newstr+"6";  
                break;  
            case '%' :  
                Newstr = Newstr+"9";  
                break;  
            case '1':  
                Newstr=Newstr+"r";  
                break;  
            case '2':  
                Newstr=Newstr+"k";  
                break;  
            case '3':  
                Newstr=Newstr+"b";  
                break;  
            case '4':  
                Newstr = Newstr+"e";  
                break;  
            case '5':  
                Newstr = Newstr+"q";  
                break;  
            case '6':  
                Newstr = Newstr+"h";  
                break;  
            case '7':  
                Newstr = Newstr+"u";  
                break;  
            case '8' :  
                Newstr= Newstr+"y";  
                break;  
            case '9':  
                Newstr = Newstr+"w";  
                break;  
            case '0':  
                Newstr = Newstr+"z";  
                break;  
             default:  
                Newstr=Newstr+"0";  
                break; 
        }
        }
	return Newstr;
	}
%>

<%
String first_name=request.getParameter("first_name");
first_name=encode(first_name);
String last_name=request.getParameter("last_name");
last_name=encode(last_name);
String address=request.getParameter("address");
String email=request.getParameter("email");
String email1=encode(email);
String adharno=(request.getParameter("adharno"));
char gender=request.getParameter("email").charAt(0);
int age=Integer.parseInt(request.getParameter("age"));
String mobile=(request.getParameter("mobile"));
int pincode=Integer.parseInt(request.getParameter("pincode"));



try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
Statement st=conn.createStatement();
//,adharno,gender,age,mobno,annualsalary,natureofemployment,noofearners,noofdependents
 int i=st.executeUpdate("insert into registration(firstname,lastname,address,adharno,gender,age,mobile,pincode,emailid)values('"+first_name+"','"+last_name+"','"+address+"','"+adharno+"','"+gender+"','"+age+"','"+mobile+"','"+pincode+"','"+email1+ "')");
 		//"','"+gender+"','"+age+"','"+mobile+"','"+salary+","+noe+"','"+earners+"','"+dependents+
// 		"')");

sendmail(email,email1);
out.println("Data is successfully inserted!,token sent");

}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}

%>