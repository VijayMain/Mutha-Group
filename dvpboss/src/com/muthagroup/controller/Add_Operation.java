package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import com.muthagroup.bo.Add_Operation_bo;
import com.muthagroup.vo.Add_Operation_vo;

public class Add_Operation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	int basic_id = 0;
	String opnno = null;
	String operation = null;
	int op_rel_id=0;
	boolean flag=false;
	int uid=0;
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			Add_Operation_vo vo=new Add_Operation_vo(); 
			Add_Operation_bo bo=new Add_Operation_bo();
			InputStream file_Input = null;
			
//-----------------------------------------------------------------------------------------------------------------------------------

			if (ServletFileUpload.isMultipartContent(request)) {
				String fieldName, fieldValue = "";

				// ******** Temporary storage for items =====>

				ServletFileUpload servletFileUpload = new ServletFileUpload(
						new DiskFileItemFactory());
				List fileItemsList;
				boolean flag = false;
 
					fileItemsList = servletFileUpload.parseRequest(request);

					// Collect data into list

					FileItem fileItem = null;
					Iterator it = fileItemsList.iterator();

					// iterate list to sort data(i.e. form / file Fields)

					while (it.hasNext()) {
						FileItem fileItemTemp = (FileItem) it.next();

						// if data is form field ==== >
						if (fileItemTemp.isFormField()) {
							// INPUT FORM FIELDS are ==== >
							fieldName = fileItemTemp.getFieldName();
							fieldValue = fileItemTemp.getString();

							// TO SELECT PARTICULAR FORM FIELD ====>
							if (fieldName.equalsIgnoreCase("opno")) {
								vo.setOpnno(fieldValue);
								System.out.println("Op No == " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("hid_sheet_no")) {
								basic_id = Integer.parseInt(fieldValue);
								vo.setBasic_id(basic_id);
								System.out.println("Basic Id == " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("operation")) { 
								vo.setOperation(fieldValue);
								System.out.println("operation == " + fieldValue);
							}
							 
						}
						// *****************************************************************************************************
						else {
							String file_stored = null;
							fileItem = fileItemTemp;

							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString();
 
							if (fieldName.equalsIgnoreCase("op_image")) {
								
								System.out.println("File Name in java : " + fieldName);
								file_stored = fileItem.getName(); 
								System.out.println(FilenameUtils.getName(file_stored)); 
								vo.setOp_ImageName(FilenameUtils.getName(file_stored)); 
								file_Input = new DataInputStream(fileItem.getInputStream()); 
								vo.setOp_Image_blob(file_Input);
								
							}
							  
							if ( vo.getOperation() != null && vo.getOpnno() != null && vo.getBasic_id() != 0) {
							
								op_rel_id=bo.addOperation(request,vo);
								}
							
							
										
						} 	
					} 		
				} 
				
				//---------------------------------------------------------------------------------------------------------------------------
			
			if(op_rel_id!=0 && vo.getOp_ImageName()!=""){
				flag = bo.addOperation_Image(uid,vo,op_rel_id);
				if(flag==true){
				response.sendRedirect("Activity_Sheet.jsp?hid=" + basic_id);
				}
			}else if (op_rel_id != 0 && vo.getOp_ImageName()==""){
				response.sendRedirect("Activity_Sheet.jsp?hid=" + basic_id);
			} else {
				System.out.println("Error occured...");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
