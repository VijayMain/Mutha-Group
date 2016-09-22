package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Timestamp;
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

import com.muthagroup.bo.Edit_BO;
import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.dao.Edit_DAO;
import com.muthagroup.vo.Edit_VO;

public class Edit_Complaint_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings({ "unused", "rawtypes" })
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			Connection con = Connection_Utility.getConnection();
			Edit_BO bo = new Edit_BO();
			Edit_VO bean = new Edit_VO();
			Edit_DAO dao = new Edit_DAO();
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			InputStream file_Input = null;
			boolean flag = false;

			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields
			 **********************************************************************************************************/

			if (ServletFileUpload.isMultipartContent(request)) {

				String fieldName, fieldValue = "";

				// ******** Temporary storage for items =====>

				ServletFileUpload servletFileUpload = new ServletFileUpload(
						new DiskFileItemFactory());
				List fileItemsList;
				// *************************************************************************************
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
						if (fieldName.equalsIgnoreCase("company_name")) {

							bean.setCompany_id(Integer.parseInt(fieldValue));
							System.out.println(bean.getCompany_id());

						}
						if (fieldName.equalsIgnoreCase("cust_name")) {
							bean.setCust_id(Integer.parseInt(fieldValue));
							System.out.println(bean.getCust_id());
						}
						if (fieldName.equalsIgnoreCase("item_name")) {
							bean.setItem_id(Integer.parseInt(fieldValue));
							System.out.println(bean.getItem_id());
						}

						int status_id = 1;
						bean.setStatus_id(status_id);
						// System.out.println(Integer.parseInt(fieldValue));

						if (fieldName.equalsIgnoreCase("received")) {
							bean.setReceived(fieldValue);
							System.out.println(bean.getReceived());
						}
						if (fieldName.equalsIgnoreCase("priority")) {
							bean.setPriority(Integer.parseInt(fieldValue));
							System.out.println(bean.getPriority());
						}
						if (fieldName.equalsIgnoreCase("category")) {
							bean.setCategory(Integer.parseInt(fieldValue));
							System.out.println(bean.getCategory());
						}
						if (fieldName.equalsIgnoreCase("defect")) {
							bean.setDefect(Integer.parseInt(fieldValue));
							System.out.println(bean.getDefect());
						}
						if (fieldName.equalsIgnoreCase("discription")) {
							bean.setDiscription(fieldValue);
							System.out.println(bean.getDiscription());
						}
						if (fieldName.equalsIgnoreCase("related")) {
							bean.setRelated(Integer.parseInt(fieldValue));
							System.out.println(bean.getRelated());
						}
						if (fieldName.equalsIgnoreCase("assigned_name")) {
							bean.setAssigned(Integer.parseInt(fieldValue));
							System.out.println(bean.getAssigned());
						}
						if (fieldName.equalsIgnoreCase("edit_date")) {

							SimpleDateFormat formatter = new SimpleDateFormat(
									"dd-MM-yyyy HH:mm:ss");
							Timestamp convertedDate = null;

							convertedDate = new java.sql.Timestamp(formatter
									.parse(fieldValue).getTime());

							bean.setC_date(convertedDate);
							System.out.println(bean.getC_date());
						}

						if (fieldName.equalsIgnoreCase("srno")) {
							bean.setSrno(Integer.parseInt(fieldValue));
							System.out.println(Integer.parseInt(fieldValue));
						}

						// *****************************************************************************************************

					} else {

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
								// System.out.println("File Name in java : " + fieldName);
								file_stored = fileItem.getName();

								bean.setFile_Name_ext(FilenameUtils.getName(file_stored));

								// System.out.println(FilenameUtils.getName(file_stored));

								file_Input = new DataInputStream(fileItem.getInputStream());
								// System.out.println("Input sr no is = " + k);

								/*************************************************************************************************************************
								 * EDIT Registered complaint using data form
								 * fields and return complaint number
								 * **********************************************************************************************************************/

								if (bean.getCompany_id() != 0
										&& bean.getCust_id() != 0
										&& bean.getItem_id() != 0
										&& bean.getReceived() != null
										&& bean.getPriority() != 0
										&& bean.getCategory() != 0
										&& bean.getDefect() != 0
										&& bean.getDiscription() != null
										&& bean.getRelated() != 0
										&& bean.getC_date() != null
										&& bean.getAssigned() != 0 && k <= 1) {
									String c_no = bo.Edit_Update(bean, session);
									// set complaint number
									bean.setComplaint_no(c_no);
								}
								if (bean.getFile_Name_ext() != null) {
									// Attach file ====>
									// System.out.println("Files Attached" + bean.getFile_Name_ext());
									flag = dao.attach_File(bean, file_Input, session);
								}
							}
						}

					}

				}

			}
			// check flag and redirect
			if (flag == true) {
				response.sendRedirect("Marketing_Home.jsp");
			} else {
				response.sendRedirect("Wrong Entry");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
