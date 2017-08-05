package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Iterator;
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
import org.apache.commons.io.FilenameUtils;

import com.muthagroup.dao.MyMOM_dao;
import com.muthagroup.vo.MyMOM_vo;

@WebServlet("/AddMy_MOM")
public class AddMy_MOM extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			MyMOM_vo bean = new MyMOM_vo();
			MyMOM_dao dao = new MyMOM_dao();
			HttpSession session = request.getSession();
			int cnt_doc = 0;
			boolean flag = false;
			InputStream file_Input = null;
			String fieldName, fieldValue = "";
			String file_stored = null;
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields
			 **********************************************************************************************************/
			if (ServletFileUpload.isMultipartContent(request)) {
				ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
				List fileItemsList;
				fileItemsList = servletFileUpload.parseRequest(request);

				// Collect data into list

				FileItem fileItem = null;
				Iterator it = fileItemsList.iterator();
				Iterator it2 = fileItemsList.iterator();

				// iterate list to sort data(i.e. form / file Fields)

				while (it.hasNext()) {
					FileItem fileItemTemp = (FileItem) it.next();

					// if data is form field ==== >
					if (fileItemTemp.isFormField()) {

						// INPUT FORM FIELDS are ==== >
						fieldName = fileItemTemp.getFieldName();
						fieldValue = fileItemTemp.getString();
						// folder subject share add_access company department
						// note
						if (fieldName.equalsIgnoreCase("remark")) {
							bean.setRemark(fieldValue);
						} 
						if (fieldName.equalsIgnoreCase("event_id")) {
							bean.setEvent_id(Integer.parseInt(fieldValue));
						} 
						// *****************************************************************************
						// Get Complaint date ===== >
						// ******************************************************************************

					}

					else {
						fileItem = fileItemTemp;
						fieldName = fileItem.getFieldName();
						fieldValue = fileItem.getString();  
								if (fieldName.equalsIgnoreCase("filename")) {
									file_stored = fileItem.getName();
									if(FilenameUtils.getName(file_stored)!=""){
									bean.setBlob_name(FilenameUtils.getName(file_stored)); 
									file_Input = new DataInputStream(fileItem.getInputStream());
									bean.setBlob_file(file_Input);
									}
								}
							}
				}
				 dao.saveMOM(response,bean,session);
				}

			// *************************************************************************************************************
			// *************************************************************************************************************
			// *************************************************************************************************************

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
