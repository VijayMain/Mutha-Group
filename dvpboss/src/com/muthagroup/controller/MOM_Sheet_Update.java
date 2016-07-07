package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat; 
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
import com.muthagroup.dao.MOM_Update_dao; 
import com.muthagroup.vo.MOM_vo;

public class MOM_Sheet_Update extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		FileItem fileItem = null;
		InputStream file_Input = null;
		try {
			MOM_vo bean = new MOM_vo(); 
			MOM_Update_dao dao = new MOM_Update_dao();

			HttpSession session = request.getSession();
			InputStream doc_Input = null, photo_Input = null;
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
						if (fieldName.equalsIgnoreCase("title")) {
							bean.setTitle(fieldValue);
						}
						if (fieldName.equalsIgnoreCase("description")) {
							bean.setDescription(fieldValue);
						}
						if (fieldName.equalsIgnoreCase("hid")) {
							bean.setHid(Integer.parseInt(fieldValue));
						}
					}
						// *************************************************************************************************************
					else {
						// *************************************************************************************************************
						// IF FILE inputs === >
						// *************************************************************************************************************
						String file_stored = null;
						fileItem = fileItemTemp;
						fieldName = fileItem.getFieldName();
						fieldValue = fileItem.getString();

						if (fieldName.equalsIgnoreCase("attachment")) {
							file_stored = fileItem.getName();
							bean.setDoc_filename(FilenameUtils.getName(file_stored));
							file_Input = new DataInputStream(fileItem.getInputStream());
							bean.setBlob_doc(file_Input);
						}
					}
				}
			}
			dao.MOM_Configure(bean, session, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}