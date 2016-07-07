package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream; 
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
import com.muthagroup.dao.Stories_dao; 
import com.muthagroup.vo.Stories_vo;
 
public class Add_StoriesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	boolean flag = false;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FileItem fileItem = null;
		InputStream file_Input = null;
		try { 
			Stories_vo bean = new Stories_vo();
			ArrayList visible = new ArrayList();
			Stories_dao dao = new Stories_dao(); 
			HttpSession session = request.getSession();
			InputStream doc_Input = null,photo_Input = null; 
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields 
			 **********************************************************************************************************/
			if (ServletFileUpload.isMultipartContent(request)) {
				String fieldName, fieldValue = "";
 				ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
				List fileItemsList;  
					fileItemsList = servletFileUpload.parseRequest(request); 
					Iterator it = fileItemsList.iterator(); 

					while (it.hasNext()) {
						FileItem fileItemTemp = (FileItem) it.next();
 
						if (fileItemTemp.isFormField()) {
 
							fieldName = fileItemTemp.getFieldName();
							fieldValue = fileItemTemp.getString(); 
							
							if (fieldName.equalsIgnoreCase("headings")) { 
								bean.setHeading(fieldValue); 
							}
							if (fieldName.equalsIgnoreCase("details")) {
								bean.setDetails(fieldValue); 
							}
							if (fieldName.equalsIgnoreCase("group")) { 
								bean.setAcc_all(Integer.parseInt(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("mepl_h21")) { 
								bean.setAcc_h21(Integer.parseInt(fieldValue)); 
							}
							if (fieldName.equalsIgnoreCase("mepl_h25")) { 
								bean.setAcc_h25(Integer.parseInt(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("mfpl")) { 
								bean.setAcc_mfpl(Integer.parseInt(fieldValue)); 
							}
							if (fieldName.equalsIgnoreCase("unit3")) { 
								bean.setAcc_unit3(Integer.parseInt(fieldValue)); 
							}
							if (fieldName.equalsIgnoreCase("di")) { 
								bean.setAcc_di(Integer.parseInt(fieldValue)); 
							}
							if (fieldName.equalsIgnoreCase("dept")) { 
								bean.setAcc_dept(Integer.parseInt(fieldValue));
							}
							if(fieldName.equalsIgnoreCase("fromdate")){ 
								bean.setDate_from(new java.sql.Date(dateFormat.parse(fieldValue).getTime()));
							}
							if(fieldName.equalsIgnoreCase("todate")){ 
								bean.setDate_to(new java.sql.Date(dateFormat.parse(fieldValue).getTime()));
							}
							if (fieldName.equalsIgnoreCase("priority")) { 
								bean.setPriority(Integer.parseInt(fieldValue));
							}
						}
						// *****************************************************************************************************
						else {
							// *************************************************************************************************************
							// IF FILE inputs === >
							// *************************************************************************************************************
							String file_stored = null; 
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString(); 
							
								if (fieldName.equalsIgnoreCase("doc")) { 
									file_stored = fileItem.getName();
									bean.setDoc_filename(FilenameUtils.getName(file_stored));
									file_Input = new DataInputStream(fileItem.getInputStream());
									bean.setBlob_doc(file_Input);
								}
								
								if (fieldName.equalsIgnoreCase("photo")) { 
									file_stored = fileItem.getName();
									bean.setPhotofilename(FilenameUtils.getName(file_stored));
									file_Input = new DataInputStream(fileItem.getInputStream());
									bean.setBlob_photo(file_Input);
								}
							}
					}
			}
			flag = dao.attach_File(bean, session,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}