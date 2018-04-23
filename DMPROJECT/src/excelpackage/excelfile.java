package excelpackage;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class excelfile {
	@SuppressWarnings("deprecation")
	public static long dateToInt(String date){
		 date=date.substring(1,date.length()-1);
	    String[] dateParts = date.split("/");
         int year = Integer.parseInt(dateParts[0]); 
        int month = Integer.parseInt(dateParts[1]); 
        int day = Integer.parseInt(dateParts[2]);
        long resDate = (year * 10000) + (month * 100) + day;
        return resDate;
	}
	public static ArrayList<Double> sendemployer(ArrayList<Double> employerid) throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
		ArrayList<Double> result=new ArrayList<>();
		
		for(int i=0;i<employerid.size();i++)
		{
			String query = "SELECT  employerdimid FROM employerdim where employerid="+employerid.get(i);

	      // create the java statement
	      Statement st = conn.createStatement();
	      
	      // execute the query, and get a java resultset
	      ResultSet rs = st.executeQuery(query);
	      
	      double id=0;
	      while(rs.next())
	      {
	      
	      id=rs.getInt("employerdimid");
	      result.add(id);
	      System.out.println(id);
	      }
		}
	      return result;

	}
	
	public static ArrayList<Double> sendinvestment(ArrayList<Double> investment) throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
		ArrayList<Double> result=new ArrayList<Double>();
		for(int i=0;i<investment.size();i++)
		{
		String query = "SELECT  investmentdimid FROM investmentdim where investmentrefid="+investment.get(i);

	      // create the java statement
	      Statement st = conn.createStatement();
	      
	      // execute the query, and get a java resultset
	      ResultSet rs = st.executeQuery(query);
	      
	      double id=0;
	      while(rs.next())
	      {
	      id=rs.getInt("investmentdimid");
	      result.add(id);
	      }
		 
	      System.out.println(id);
		}
	      return result;

	}
	
	public static int storedata(String bookname,int employeedimid)
	{
		FileInputStream fis;
		try {
			String s="C:\\Users\\himesh\\Desktop\\dmfiles\\"+bookname;
			fis = new FileInputStream(new File("C:\\Users\\himesh\\Desktop\\dmfiles\\"+bookname));
		String s2[]=s.split(".");
		
		
			
		
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
		Statement st=conn.createStatement();
		//,adharno,gender,age,mobno,annualsalary,natureofemployment,noofearners,noofdependents
		 
		XSSFWorkbook wb=new XSSFWorkbook(fis);
		XSSFSheet sheet=wb.getSheetAt(0);
		XSSFSheet sheet2=wb.getSheetAt(1);
		XSSFSheet sheet3=wb.getSheetAt(2);
		 
		 
		FormulaEvaluator fe=wb.getCreationHelper().createFormulaEvaluator();
		
		int i=1;
		ArrayList<Double> empid=new ArrayList<>();
		ArrayList<Double> investmentref=new ArrayList<>();
		
		String names[]=new String[4];
		names[0]="EmployerID";
		names[1]="CompanyName";
		names[2]="Address";
		names[3]="SectorOfEmployer";
		String invest[]=new String[3];
		invest[0]="InvestmentRefID";
		invest[1]="InvestmentAvenues";
		invest[2]="TypeOfInvestmentAvenues";
		
		String financial[]=new String[8];
		
		financial[0]="investmentamount";
		financial[1]="investmentduration";
		financial[2]="startdate";
		financial[3]="enddate";
		financial[4]="financialfactid";
		financial[5]="employeedimid";
		financial[6]="employerdimid";
		financial[7]="investmentdimid";
		//financial[8]="datedimid";
		
	double employerid=0;	
	double investmentrefid=0;	
		
		
		for(Row row:sheet)
		{
			
			if(i==1)
			{
				i++;
				continue;
			}
			int j=0;
			Dictionary store=new Hashtable();
			for(Cell cell:row)
			{
				
				switch(fe.evaluateInCell(cell).getCellType())
				{
				case Cell.CELL_TYPE_NUMERIC:
				{
					store.put(names[j], cell.getNumericCellValue());
					j++;
					System.out.println(cell.getNumericCellValue());
					break;
				}	
				case Cell.CELL_TYPE_STRING:
				{
					store.put(names[j], cell.getStringCellValue());
					j++;
					System.out.println(cell.getStringCellValue());
					break;
				}	
				}
			}
			
			int k=st.executeUpdate("insert into employerdim(EmployerID,ComapanyName,Address,SectorOfEmployer)values('"+store.get(names[0])+"','"+store.get(names[1])+"','"+store.get(names[2])+"','"+store.get(names[3])+"')");
			//k=st.executeUpdate("insert into investmentdim(InvestmentRefID,InvestmentAvenues,TypeOfInvestmentAvenues)values('"+store.get(names[4])+"','"+store.get(names[5])+"','"+store.get(names[6])+"')");
			if(store.get(names[0])==null)
			{
				break;
			}
			if(store.get(names[0])!=null)
			{
			employerid=(double) store.get(names[0]);
			empid.add(employerid);
			}
			
			System.out.println();
			System.out.println();
		}
		i=1;
		
		for(Row row:sheet2)
		{
			
			if(i==1)
			{
				i++;
				continue;
			}
			int j=0;
			Dictionary store=new Hashtable();
			for(Cell cell:row)
			{
				
				switch(fe.evaluateInCell(cell).getCellType())
				{
				case Cell.CELL_TYPE_NUMERIC:
				{
					store.put(invest[j], cell.getNumericCellValue());
					j++;
					System.out.println(cell.getNumericCellValue());
					break;
				}	
				case Cell.CELL_TYPE_STRING:
				{
					store.put(invest[j], cell.getStringCellValue());
					j++;
					System.out.println(cell.getStringCellValue());
					break;
				}	
				}
			}
			
			//int k=st.executeUpdate("insert into employerdim(EmployerID,ComapanyName,Address,SectorOfEmployer)values('"+store.get(names[0])+"','"+store.get(names[1])+"','"+store.get(names[2])+"','"+store.get(names[3])+"')");
			int k=st.executeUpdate("insert into investmentdim(InvestmentRefID,InvestmentAvenues,TypeOfInvestmentAvenues)values('"+store.get(invest[0])+"','"+store.get(invest[1])+"','"+store.get(invest[2])+"')");
			investmentrefid=(double) store.get(invest[0]);
			investmentref.add(investmentrefid);
			
			System.out.println();
		}
		
		ArrayList<Double> employersurrogate=sendemployer(empid);
		ArrayList<Double> investmentsurrogate=sendinvestment(investmentref);
		//System.out.println(employersurrogate+" "+investmentsurrogate);
	
i=1;
		int l=0;
		for(Row row:sheet3)
		{
			
			if(i==1)
			{
				i++;
				continue;
			}
			int j=0;
			Dictionary store=new Hashtable();
			for(Cell cell:row)
			{
				
				switch(fe.evaluateInCell(cell).getCellType())
				{
				case Cell.CELL_TYPE_NUMERIC:
				{
					store.put(financial[j], cell.getNumericCellValue());
					j++;
					System.out.println(cell.getNumericCellValue());
					break;
				}	
				case Cell.CELL_TYPE_STRING:
				{
					store.put(financial[j], cell.getStringCellValue());
					j++;
					System.out.println(cell.getStringCellValue());
					break;
				}	
				}
			}
			
			String datedim="."+LocalDateTime.now().toLocalDate().toString()+".";
			datedim=datedim.substring(0, 5)+"/"+datedim.substring(6,8)+"/"+datedim.substring(9);
			System.out.println(datedim);
			if(l<investmentsurrogate.size())
			{
			int k=st.executeUpdate("insert into financialfact(investmetamount,Investmentduration,startdateofinvestment,enddateofinvestment,employeedimid,employerdimid,investmentdimid,datedimid)values('"+store.get(financial[0])+"','"+store.get(financial[1])+"','"+dateToInt((String)store.get(financial[2]))+"','"+dateToInt((String)store.get(financial[3]))+"','"+employeedimid+"','"+employersurrogate.get(l)+"','"+investmentsurrogate.get(l)+"','"+dateToInt(datedim)+"')");
			l++;
			}
			System.out.println();
		}
		
		
	}
		
		
		
		catch (IOException | SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 1;

	}
	
	}
