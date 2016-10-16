package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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

import com.muthagroup.bo.Complaint_Action_BO;
import com.muthagroup.dao.Complaint_Action_Dao;
import com.muthagroup.vo.Complaint_Action_VO;

public class Complaint_Action_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings({ "unused", "rawtypes" })
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		try {

			Complaint_Action_VO bean = new Complaint_Action_VO();
			InputStream file_Input = null;
			Complaint_Action_BO actionbo = new Complaint_Action_BO();
			HttpSession session = request.getSession();
			Complaint_Action_Dao dao = new Complaint_Action_Dao();
			String complaint_no = session.getAttribute("complaint_no")
					.toString();
			bean.setComplaint_no(complaint_no);
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			bean.setUid(uid);
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

							bean.setCompany_name(fieldValue);
						    //	System.out.println("Company ==" + bean.getCompany_name());

						}
						if (fieldName.equalsIgnoreCase("cust_name")) {
							bean.setCust_name(fieldValue);
							//  System.out.println("Customer === " + bean.getCust_name());
						}
						if (fieldName.equalsIgnoreCase("item_name")) {
							bean.setItem_name(fieldValue);
							//  System.out.println("Item ==== " 	+ bean.getItem_name());
						}
						if (fieldName.equalsIgnoreCase("status")) {
							bean.setStatus(Integer.parseInt(fieldValue));
							//   System.out.println("Status === " + bean.getStatus());
						}
						if (fieldName.equalsIgnoreCase("description")) {
							bean.setDescription(fieldValue);
							//  System.out.println("Description ===== " + bean.getDescription());
						}
						if (fieldName.equalsIgnoreCase("defect")) {
							bean.setDefect(fieldValue);
							//  System.out.println("Defect ==== " + bean.getDefect());
						}
						if (fieldName.equalsIgnoreCase("phase_id")) {
							bean.setPhase_id(Integer.parseInt(fieldValue));
							//  System.out.println("PhaseId ==== " + bean.getPhase_id());
						}
						
						if (fieldName.equalsIgnoreCase("a_type")) {
							bean.setAction_Type(fieldValue);
							//  System.out.println("A Type === " + bean.getAction_Type());
						}
						if (fieldName.equalsIgnoreCase("action_description")) {
							bean.setAction_description(fieldValue);
							//   System.out.println("Action Description ===== " + bean.getAction_description());
						}

						if (fieldName.equalsIgnoreCase("srno")) {
							bean.setSrNo(Integer.parseInt(fieldValue));
							//  System.out.println(bean.getSrNo());
						}
						// *******************************************************************************************************************

					} else {
						// *************************************************************************************************************
						// IF FILE inputs === >
						// *************************************************************************************************************
						String file_stored = null;
						fileItem = fileItemTemp;
						fieldName = fileItem.getFieldName();
						fieldValue = fileItem.getString();

						for (int k = 1; k <= bean.getSrNo(); k++) {
							//   System.out.println("K is = " + k);

							// *************************************************************************************************************
							// if multiple files then there names are
							// inputName1,inputName2,inputName3,.......
							// *************************************************************************************************************

							if (fieldName.equalsIgnoreCase("inputName" + k)) {
								//  System.out.println("File Name in java : " + fieldName);
								file_stored = fileItem.getName();

								bean.setFile_Name(FilenameUtils.getName(file_stored));

								//  System.out.println(FilenameUtils.getName(file_stored));

								file_Input = new DataInputStream(fileItem.getInputStream());
								//  System.out.println("Input sr no is = " + k);

								if (k == 1) {
									/*System.out.println("Test in progress");
									System.out.println("Company in controller " + bean.getCompany_name());
									System.out.println("Customer in controller "+ bean.getCust_name());
									System.out.println("Item in controller " + bean.getItem_name());
									System.out.println("Status in controller " + bean.getStatus());
									System.out.println("Defect in controller " + bean.getDefect());
									System.out.println("Test 2222 ");
									// Register Complaint Action
									System.out.println("Action Type ====== " + bean.getAction_Type());*/

									if (bean.getAction_description().equals("")
											&& bean.getAction_Type().equals("")
											&& !bean.getCompany_name().equals("")
											&& !bean.getComplaint_no().equals("")
											&& !bean.getCust_name().equals("")
											&& !bean.getDefect().equals("")
											&& !bean.getDescription().equals(""))
									{
										//  System .out.println("Status Change method..");
										flag=dao.Change_Status(bean, session);

									} else {

										flag = dao.complaint_action(bean,
												session);
									}
								}

								// Register File
								if (bean.getFile_Name() != null) {
									bean.setFile(file_Input);
									flag = dao.file_upload(bean, session);
									//   System.out.println("file name = " + bean.getFile_Name());
								}
							}
						}
					}
				}
			}

			if (flag == true) {
				response.sendRedirect("Complaint_Action.jsp?hid=" + complaint_no);
			} else {
				out.println("Entry Failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}

	}
}
