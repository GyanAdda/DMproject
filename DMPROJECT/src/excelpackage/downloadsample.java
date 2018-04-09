package excelpackage;

import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.*;

public class downloadsample {
		public static int sampledownload()
		{
			String sFile = "C:\\Users\\himesh\\Desktop\\dmfiles\\sample.xls";
			System.out.println("sfilepath in jsp file is........."+sFile);
			 String mimeType = "application/vnd.ms-excel";
			 System.out.println(mimeType);
			 //response.setContentType(mimeType);
			 //response.setHeader("Content-Disposition", "inline;filename=\"" + sFile + "\"");
			 response.setContentType(mimeType);
			 response.setHeader("Content-disposition","attachment;filename=\""+sFile+"\"");
			  
			 
			 FileInputStream in = null;
			 OutputStream output=null;
			            try {
			                output = response.getOutputStream();
			                in = new FileInputStream(sFile);
			                byte[] buffer = new byte[5 * 1024];
			                int size = 0;
			                while ((size = in.read(buffer, 0, buffer.length)) > 0) {
			                    output.write(buffer, 0, size);
			                }
			                 
			                         
			            } catch (Exception e) {
			            } 
			             
			             
			            finally {
			                in.close();     
			                output.flush(); 
			                output.close();
			            }
			            if (true)
			                return 1;
		}
}
