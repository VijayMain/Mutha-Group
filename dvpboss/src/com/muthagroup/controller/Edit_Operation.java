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

import com.muthagroup.bo.Edit_Operation_bo;
import com.muthagroup.vo.Edit_Operation_vo;
 

public class Edit_Operation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	int basic_id = 0;
	String opnno = null;
	String operation = null;
	int op_rel_id=0;
	boolean flag=false,upImage=false;
	int uid=0;
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("edit controller called....");
		try {
			HttpSession session = request.getSession();
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			Edit_Operation_vo vo = new Edit_Operation_vo();
			Edit_Operation_bo bo = new Edit_Operation_bo();
			
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
							if (fieldName.equalsIgnoreCase("avail_opn_id")) {
								vo.setAvail_opn_id(Integer.parseInt(fieldValue));
								System.out.println("Avail Op == " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("avail_opn_no_id")) {
								vo.setAvail_opn_no_id(Integer.parseInt(fieldValue));
								System.out.println("Avail Op No == " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("new_opno")) {
								vo.setNewOpn_no(Integer.parseInt(fieldValue));
								System.out.println("New Op No == " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("rel_id")) { 
								vo.setRel_id(Integer.parseInt(fieldValue));
								System.out.println("rel_id == " + fieldValue);
							}
							
							if (fieldName.equalsIgnoreCase("opno")) { 
								vo.setOpno(Integer.parseInt(fieldValue));
								System.out.println("Op No == " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("operation")) { 
								vo.setOperation(fieldValue);
								System.out.println("Operation== " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("new_operation")) { 
								vo.setNew_operation(fieldValue);
								System.out.println("New Operation== " + fieldValue);
							}
							 
							if (fieldName.equalsIgnoreCase("basic_id")) {
								basic_id = Integer.parseInt(fieldValue);
								vo.setBasic_id(basic_id);
								System.out.println("Basic Id == " + fieldValue);
							}
						}
						// *****************************************************************************************************
						else {
							String file_stored = null;
							fileItem = fileItemTemp;

							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString();
 
							if (fieldName.equalsIgnoreCase("upOp_image")) {
								 
								file_stored = fileItem.getName(); 
								System.out.println(FilenameUtils.getName(file_stored)); 
								vo.setOp_ImageName(FilenameUtils.getName(file_stored)); 
								file_Input = new DataInputStream(fileItem.getInputStream()); 
								vo.setOp_Image_blob(file_Input);
								
							} 			
						} 	
					} 		
				}
				
			//---------------------------------------------------------------------------------------------------------------------------
			
			if(vo.getBasic_id()!=0 && vo.getRel_id()!=0 && vo.getAvail_opn_id()!=0 && vo.getAvail_opn_no_id()!=0){
			flag = bo.editOperation(request, vo);
			}
			if(vo.getOp_ImageName()!="" && flag==true){ 
				upImage = bo.updateImage(vo,uid); 
				if(upImage==true){
					response.sendRedirect("Activity_Sheet.jsp?hid=" + basic_id);
				}
			}
			if (vo.getOp_ImageName()=="" && flag==true){ 
				response.sendRedirect("Activity_Sheet.jsp?hid=" + basic_id);
			} else {
				System.out.println("Error occured...");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
