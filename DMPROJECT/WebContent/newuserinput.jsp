<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@page import="java.security.*" %>

<%!
public String cyclic(String str)  
{  
    String Newstr=" ";  
    //System.out.print("Enter the String you want to Encrypt: ");  
    try {  

    //Scanner in=new Scanner(System.in);  
    //str=in.nextLine();  
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
    }  
    catch(Exception ioe)  
    {  
        ioe.printStackTrace();  
    }  
    return Newstr;  
}  
  

%>



<%!
	public String anonymize(String name,String type)
	{
		switch(type)
		{
		case "encryption": return cryptWithMD5(name);
		case "random": return random(name);
		case "mask": return cyclic(name);
		}
		return "";
	}
	
%>

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
<%!
	public String random(String s)
	{
		String s2="";
		for(int i=0;i<s.length();i++)
		{
			Random random = new Random();
			int index = random.nextInt(25);

			String [] alphabets = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L","M", "N","O","P","Q", "R", "S", "T", "U", "V","W", "X","Y","Z"};

			s2 =s2+ alphabets[index];
			
		}
		return s2;
	}
%>



<%
String anon=request.getParameter("anonymization");

String first_name=request.getParameter("first_name");
String last_name=request.getParameter("last_name");
String name=first_name.concat(last_name);
name=anonymize(name,anon);
String panno=request.getParameter("panno");
panno=anonymize(panno,anon);
char gender=request.getParameter("gender").charAt(0);
String dob=request.getParameter("dob");
String address=request.getParameter("address");
String city=request.getParameter("city");
String state=request.getParameter("state");
String country=request.getParameter("country");
int pincode=Integer.parseInt(request.getParameter("pincode"));
String mobile=(request.getParameter("mobile"));
String email=request.getParameter("email");
String email1=anonymize(email,anon);
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


