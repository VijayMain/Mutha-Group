package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
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
import com.muthagroup.bo.Register_BO;
import com.muthagroup.dao.Register_Complaint_DAO;
import com.muthagroup.vo.Register_VO;

public class Register_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	boolean flag = false;

	@SuppressWarnings("rawtypes")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {

			Register_VO bean = new Register_VO();
			Register_Complaint_DAO dao = new Register_Complaint_DAO();
			Register_BO bo = new Register_BO();
			HttpSession session = request.getSession();

			InputStream file_Input = null;
			SimpleDateFormat formatter = new SimpleDateFormat(
					"dd-MM-yyyy HH:mm:ss");
			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields
			 **********************************************************************************************************/
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
							if (fieldName.equalsIgnoreCase("cust_company_name")) {

								bean.setCust_comp_id(Integer
										.parseInt(fieldValue));
								System.out.println("Cust Company == "
										+ bean.getCust_comp_id());

							}
							if (fieldName.equalsIgnoreCase("cust_name")) {
								bean.setCust_id(Integer.parseInt(fieldValue));
								System.out.println("Cust Name === "
										+ bean.getCust_id());
							}
							if (fieldName.equalsIgnoreCase("item_name")) {
								bean.setItem_id(Integer.parseInt(fieldValue));
								System.out.println("Item Name === "
										+ bean.getItem_id());
							}
							if (fieldName.equalsIgnoreCase("received")) {
								bean.setReceived(fieldValue);
								System.out.println("Received from === "
										+ bean.getReceived());
							}
							if (fieldName.equalsIgnoreCase("severity")) {
								bean.setSeverity(Integer.parseInt(fieldValue));
								System.out.println("severity == "
										+ bean.getSeverity());
							}
							if (fieldName.equalsIgnoreCase("category")) {
								bean.setCategory(Integer.parseInt(fieldValue));
								System.out.println("Category === "
										+ bean.getCategory());
							}
							if (fieldName.equalsIgnoreCase("defect_name")) {
								bean.setDefect(fieldValue);
								System.out.println("Defect Name === "
										+ bean.getDefect());
							}
							if (fieldName.equalsIgnoreCase("description")) {
								bean.setDiscription(fieldValue);
								System.out
										.println("This is description ======== "
												+ bean.getDiscription());
							}
							if (fieldName.equalsIgnoreCase("unregistered")) {
								bean.setUnregistered(Integer
										.parseInt(fieldValue));
								System.out.println("Unregistered Status ==== "
										+ bean.getUnregistered());
							}

							if (fieldName.equalsIgnoreCase("related")) {
								bean.setRelated(Integer.parseInt(fieldValue));
								System.out.println("related == "
										+ bean.getRelated());
							}

							if (fieldName.equalsIgnoreCase("assigned")) {
								bean.setAssigned(Integer.parseInt(fieldValue));
								System.out.println("Assigned === "
										+ bean.getAssigned());
							}
							if (fieldName.equalsIgnoreCase("complaint_date")) {

								System.out
										.println("Input date = " + fieldValue);
								Timestamp convertedDate = null;
								convertedDate = new java.sql.Timestamp(
										formatter.parse(fieldValue).getTime());

								bean.setDate(convertedDate);
								System.out.println("Get input date = "
										+ bean.getDate());
							}
							if (fieldName.equalsIgnoreCase("srno")) {
								bean.setSrNo(Integer.parseInt(fieldValue));
								System.out.println(Integer.parseInt(fieldValue));
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

							for (int k = 1; k <= bean.getSrNo(); k++) {
								System.out.println("K is = " + k);
								// *************************************************************************************************************
								// if multiple files then there names are
								// inputName1,inputName2,inputName3,.......
								// *************************************************************************************************************
								if (fieldName.equalsIgnoreCase("inputName" + k)) {
									System.out.println("File Name in java : " + fieldName);
									file_stored = fileItem.getName();

									bean.setFile_Name_ext(FilenameUtils.getName(file_stored));

									System.out.println(FilenameUtils.getName(file_stored));

									file_Input = new DataInputStream(fileItem.getInputStream());
									System.out.println("Input sr no is = " + k);

									/*************************************************************************************************************************
									 * Register complaint using data form fields
									 * and return complaint number
									 * **********************************************************************************************************************/

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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
