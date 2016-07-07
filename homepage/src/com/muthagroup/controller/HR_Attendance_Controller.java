package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.muthagroup.dao.New_sheet_dao;
import com.muthagroup.vo.New_sheet_vo;
 
public class HR_Attendance_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date d;
			InputStream file_Input = null;
			boolean flag = false;
			// --------------------------------------------------------------------------------------------------------
			ArrayList attd=new ArrayList();
			New_sheet_vo vo = new New_sheet_vo();
			New_sheet_dao dao = new New_sheet_dao();
			
			if (ServletFileUpload.isMultipartContent(request)) {
				String fieldName, fieldValue = "";
				// ******** Temporary storage for items =====>
				ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
				List fileItemsList; 
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
							
							if(fieldName.equalsIgnoreCase("date")){ 
									d = new java.sql.Date(dateFormat.parse(fieldValue).getTime());
									vo.setAttendance_date(d);
									System.out.println("Attendance Date = " + d); 
							}						 							  
						}else {							
							// *************************************************************************************************************
							// IF FILE inputs === >
							// *************************************************************************************************************
							String file_stored = null;
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString();						 
									System.out.println("File Name in java : "+ fieldName);
									file_stored = fileItem.getName(); 
									vo.setFile_Name_ext(FilenameUtils.getName(file_stored)); 
									file_Input = new DataInputStream(fileItem.getInputStream());  
									// Attach file ====>
									vo.setFile_blob(file_Input);
									}
						}
			}
			if(vo.getFile_Name_ext()!=null && vo.getAttendance_date()!=null){
			dao.add_newSheetInfo(session,vo,response);	
			}
			// --------------------------------------------------------------------------------------------------------
				 					
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
 

}
