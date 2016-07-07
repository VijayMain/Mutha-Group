package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
 
import com.muthagroup.bo.Edit_Batch_bo; 
import com.muthagroup.vo.Edit_Batch_vo;


public class Edit_Batch_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean flag=false;
		
		String feedback_Details=null;
		Date trial_date=null;
		
		String feddback_RNo=null;
		
		int trial_qty=0;
		int basic_id=0;
		
		InputStream file_Input = null;
		
		Edit_Batch_vo vo=new Edit_Batch_vo();
		
		if (ServletFileUpload.isMultipartContent(request)) {
			String fieldName, fieldValue = "";

			// ******** Temporary storage for items =====>

			ServletFileUpload servletFileUpload = new ServletFileUpload(
					new DiskFileItemFactory());
			List fileItemsList;
			

			try {
				fileItemsList = servletFileUpload.parseRequest(request);

				// Collect data into list

				FileItem fileItem = null;
				Iterator  it = fileItemsList.iterator();

				// iterate list to sort data(i.e. form / file Fields)

				while (it.hasNext()) {
					FileItem fileItemTemp = (FileItem) it.next();

					// if data is form field ==== >
					if (fileItemTemp.isFormField()) {
						// INPUT FORM FIELDS are ==== >
						fieldName = fileItemTemp.getFieldName();
						fieldValue = fileItemTemp.getString();
						
						if (fieldName.equalsIgnoreCase("basic_id")) {
							basic_id=Integer.parseInt(fieldValue);
							vo.setBasic_id(basic_id);
							System.out.println("sheet_no == " + fieldValue);
						}
						if (fieldName.equalsIgnoreCase("trial_qty")) {
							vo.setTrial_qty(Integer.parseInt(fieldValue));
							System.out.println("trial qty == " + fieldValue);
						}
						if (fieldName.equalsIgnoreCase("feedback_Details")) {
							vo.setFeedback_Details(fieldValue);
							System.out.println("feedback details == " + fieldValue);
						}
						if (fieldName.equalsIgnoreCase("feddback_RNo")) 
						{
							vo.setFeddback_RNo(fieldValue);
							System.out.println("feedback report no == " + fieldValue);
						}
						if (fieldName.equalsIgnoreCase("trial_id")) 
						{
							vo.setTrial_id(Integer.parseInt(fieldValue));
							System.out.println("trial no == " + fieldValue);
						}
						
						if (fieldName.equalsIgnoreCase("trial_Date")) {

							SimpleDateFormat formatter = new SimpleDateFormat(
									"yyyy-MM-dd");
							java.util.Date convertedDate = null;

							convertedDate = formatter.parse(fieldValue);

							final java.sql.Date Date12 = new java.sql.Date(
									convertedDate.getTime());

							

							vo.setTrial_date(Date12);
							System.out.println("trial Date::::"+ vo.getTrial_date());
						}
						
					}
					else 
					{
						// *************************************************************************************************************
						// IF FILE inputs === >
						// *************************************************************************************************************
						String file_stored = null;
						fileItem = fileItemTemp;

						fieldName = fileItem.getFieldName();
						fieldValue = fileItem.getString();

						// *************************************************************************************************************
						// if multiple files then there names are
						// inputName1,inputName2,inputName3,.......
						// *************************************************************************************************************

						if (fieldName.equalsIgnoreCase("trial_attachment")) {
							System.out.println("File Name in java : "
									+ fieldName);
							file_stored = fileItem.getName();

							System.out.println(FilenameUtils.getName(file_stored));

							vo.setAttch_file_name(FilenameUtils.getName(file_stored));

							file_Input = new DataInputStream(fileItem.getInputStream());

							vo.setTrial_attachment(file_Input);

						}
					}
				}
				Edit_Batch_bo bo=new Edit_Batch_bo();
				
				flag=bo.updateBatch(vo,request);
			}catch(Exception e)
			{
				e.printStackTrace();
			}
				
			if(flag==true)
			{
				response.sendRedirect("Add_Trials.jsp?hid="+basic_id);
			}
			else
			{
				System.out.println("Error occured at batch controller.....");
			}
			
	
		
		
	}
	
	}

}
