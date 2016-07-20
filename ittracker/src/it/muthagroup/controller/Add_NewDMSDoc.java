package it.muthagroup.controller;

import it.muthagroup.dao.DMS_DAO;
import it.muthagroup.vo.DMS_VO;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
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

public class Add_NewDMSDoc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		/*try{
		DMS_VO bean = new DMS_VO();
		DMS_DAO dao = new DMS_DAO();
		HttpSession session = request.getSession();
		ArrayList DMSComp_list = new ArrayList();
		ArrayList DMSDept_list = new ArrayList();
		InputStream file_Input = null;
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		*//**********************************************************************************************************
		 * For MultipartContent Separate FILE Fields and FORM Fields
		 **********************************************************************************************************//*
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
						
						if (fieldName.equalsIgnoreCase("srno")) {
							bean.setSrno(Integer.parseInt(fieldValue)); 
						}
						// *****************************************************************************
						// Get Complaint date ===== >
						// ******************************************************************************
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

						for (int k = 1; k <= bean.getSrno(); k++) {
							System.out.println("K is = " + k);
							// *************************************************************************************************************
							// if multiple files then there names are
							// inputName1,inputName2,inputName3,.......
							// *************************************************************************************************************
							if (fieldName.equalsIgnoreCase("inputName" + k)) {
								System.out.println("File Name in java : " + fieldName);
								file_stored = fileItem.getName();

								bean.setBlob_name(FilenameUtils.getName(file_stored));

								System.out.println(FilenameUtils.getName(file_stored));

								file_Input = new DataInputStream(fileItem.getInputStream());
								System.out.println("Input sr no is = " + k);

								*//*************************************************************************************************************************
								 * Register complaint using data form fields
								 * and return complaint number
								 * **********************************************************************************************************************//*

								if (bean.getCust_comp_id() != 0
										&& bean.getCust_id() != 0
										&& bean.getItem_id() != 0
										&& bean.getReceived() != null
										&& bean.getSeverity() != 0
										&& bean.getCategory() != 0
										&& bean.getDefect() != null
										&& bean.getDiscription() != null
										&& bean.getRelated() != 0
										&& bean.getAssigned() != 0
										&& bean.getDate() != null && k <= 1) {
									String c_no = bo.regComplaint(bean,
											session);
									// set complaint number
									bean.setComplaint_No(c_no);
									System.out
											.println("register complaint = "
													+ c_no);
									
									if(bean.getUnregistered()!=0 && bean.getComplaint_No()!=null){
										dao.registered_Unassigned(bean);
									}
								}
								// Attach file ====>
								bean.setFile_blob(file_Input);
								if (bean.getFile_Name_ext() != null) {
									flag = dao.attach_File(bean, session);
								}

							}
						}
					}
				}
				// check flag and redirect

				if (flag == true) {
					response.sendRedirect("Marketing_Home.jsp");
				} else {
					response.sendRedirect("Entry Failed");
				} 
		}

	} catch (Exception e) {
		e.printStackTrace();
	}*/
	}
}
