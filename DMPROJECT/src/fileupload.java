
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
@WebServlet("/fileupload")
public class fileupload extends HttpServlet {
	//static int id;
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ServletFileUpload sf=new ServletFileUpload(new DiskFileItemFactory());
		try {
			List<FileItem> file=sf.parseRequest(request);
		
		//int id=Integer.parseInt(request.getParameter("empval"));
		//System.out.println(id);
		for(FileItem item : file)
		{
			item.write(new File("C:\\Users\\himesh\\Desktop\\dmfiles\\"+item.getName()));
		}
		System.out.println("file uploaded");
		
		request.setAttribute("bookname", file.get(0).getName());
		//request.setAttribute("employeeid", id);
		request.getRequestDispatcher("practice2.jsp").forward(request, response);
	
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

}
}
