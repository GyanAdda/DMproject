package excelpackage;

import java.sql.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Dictionary;
import java.util.Hashtable;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
public class excelfile {
	@SuppressWarnings("deprecation")
	
	public static double sendemployer(double employerid) throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
		String query = "SELECT  employerdimid FROM employerdim where employerid="+employerid;

	      // create the java statement
	      Statement st = conn.createStatement();
	      
	      // execute the query, and get a java resultset
	      ResultSet rs = st.executeQuery(query);
	      
	      double id=0;
	      while(rs.next())
	      {
	      
	      id=rs.getInt("employerdimid");
	      System.out.println(id);
	      }
	      return id;

	}
	
	public static double sendinvestment(double investment) throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
		String query = "SELECT  investmentdimid FROM investmentdim where investmentrefid="+investment;

	      // create the java statement
	      Statement st = conn.createStatement();
	      
	      // execute the query, and get a java resultset
	      ResultSet rs = st.executeQuery(query);
	      
	      double id=0;
	      while(rs.next())
	      {
	      id=rs.getInt("investmentdimid");
	      }
	      
	      System.out.println(id);
	      return id;

	}
	
	public static int storedata(String bookname,int employeedimid)
	{
		FileInputStream fis;
		try {
			fis = new FileInputStream(new File("C:\\Users\\himesh\\Desktop\\dmfiles\\"+bookname));
		
		HSSFWorkbook wb=new HSSFWorkbook(fis);
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dmproject", "root", "root");
		Statement st=conn.createStatement();
		//,adharno,gender,age,mobno,annualsalary,natureofemployment,noofearners,noofdependents
		 
		
		HSSFSheet sheet=wb.getSheetAt(0);
		HSSFSheet sheet2=wb.getSheetAt(1);
		HSSFSheet sheet3=wb.getSheetAt(2);
		
		FormulaEvaluator fe=wb.getCreationHelper().createFormulaEvaluator();
		
		int i=1;
		
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
			employerid=(double) store.get(names[0]);
			
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
			
			System.out.println();
		}
		
		double employersurrogate=sendemployer(employerid);
		double investmentsurrogate=sendinvestment(investmentrefid);
		//System.out.println(employersurrogate+" "+investmentsurrogate);
	
i=1;
		
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
			
			
			int k=st.executeUpdate("insert into financialfact(investmetamount,Investmentduration,startdateofinvestment,enddateofinvestment,employeedimid,employerdimid,investmentdimid)values('"+store.get(financial[0])+"','"+store.get(financial[1])+"','"+store.get(financial[2])+"','"+store.get(financial[3])+"','"+employeedimid+"','"+employersurrogate+"','"+investmentsurrogate+"')");
			
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
