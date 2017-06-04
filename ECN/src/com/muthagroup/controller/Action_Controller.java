package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
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

import com.muthagroup.bo.Action_BO;

import com.muthagroup.dao.Action_DAO;

import com.muthagroup.vo.Action_VO;
//============================================================================-->
//============================ Controller  ===================================-->
//============================================================================-->
public class Action_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	@SuppressWarnings("rawtypes")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {

			Action_VO bean = new Action_VO();
			Action_DAO dao = new Action_DAO();
			Action_BO bo = new Action_BO();
			HttpSession session = request.getSession();

			InputStream file_Input = null;

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

					// String action=request.getParameter("Action_disc");

					// System.out.println("By using getparam...."+action);
					// *****************************************************************************************************

					// iterate list to sort data(i.e. form / file Fields)

					while (it.hasNext()) {
						FileItem fileItemTemp = (FileItem) it.next();

						// if data is form field ==== >
						if (fileItemTemp.isFormField()) {

							// INPUT FORM FIELDS are ==== >
							fieldName = fileItemTemp.getFieldName();
							fieldValue = fileItemTemp.getString();

							// TO SELECT PARTICULAR FORM FIELD ====>
							if (fieldName.equalsIgnoreCase("Action_disc")) {
								bean.setAction_disc(fieldValue);
								if (bean.getAction_disc().equalsIgnoreCase("")) {
									response.sendRedirect("Cab_Home.jsp");
								}
								// System.out.println("action disc... : " + bean.getAction_disc());

							}
							if (fieldName.equalsIgnoreCase("proposeddate")) {
								bean.setPdate(fieldValue);
								// System.out.println("Proposed Date = " + bean.getPdate());
							}
							if (fieldName.equalsIgnoreCase("actualimpldate")) {
								if (fieldValue.equals("")) {
									String nulldate = "0000-00-00 00:00:00";
									bean.setAdate(nulldate);
									// System.out.println("Actual Date = " + bean.getAdate());
								} else {
									bean.setAdate(fieldValue);
									// System.out.println("Actual Date = " + bean.getAdate());
								}

							}
							if (fieldName.equalsIgnoreCase("Prop_output")) {
								bean.setProp_output(fieldValue);
								// System.out.println("Proposed Output... :" + bean.getProp_output());
							}

							if (fieldName.equalsIgnoreCase("srno")) {
								bean.setSrNo(Integer.parseInt(fieldValue));
								// System.out.println("sr no... :" + Integer.parseInt(fieldValue));
							}

							if (fieldName.equalsIgnoreCase("req_date")) {

								// To get Todays Date ====== >>>
								DateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd HH:mm:ss");
								// get current date time with Date()
								String rdate = fieldValue;
								Timestamp CR_Date = null;
								CR_Date = new java.sql.Timestamp(formatter
										.parse(rdate).getTime());

								bean.setCrrDate(CR_Date);
								// System.out.println("request date..:" + CR_Date + "Get date " + bean.getCrrDate());

							}

							if (fieldName.equalsIgnoreCase("mytext")) {
								bean.setMytext(fieldValue);
								// System.out.println("Input Request is... :" + bean.getMytext());

							}

							if (fieldName.equalsIgnoreCase("mytextAct")) {
								bean.setMytextAct(fieldValue);
								// System.out.println("Input mytextAct .. :" + bean.getMytextAct());

							}
							if (fieldName.equalsIgnoreCase("button1")) {
								bean.setTestActualop(fieldValue);

								// System.out.println("Input Request is... :" + bean.getTestActualop());

							}
							if (fieldName.equalsIgnoreCase("Action_No")) {
								bean.setAction_No(Integer.parseInt(fieldValue));

								// System.out.println("Input Action No is... :" + bean.getAction_No());

							}
							if (fieldName.equalsIgnoreCase("actual_output")) {
								bean.setActual_Output(fieldValue); 
								// System.out.println("Input Actual output is... :" + bean.getActual_Output()); 
							}

							if (fieldName.equalsIgnoreCase("act_impl_date_op")) {
								SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
								Timestamp convertedDate = null;

								convertedDate = new java.sql.Timestamp(formatter.parse(fieldValue).getTime());

								bean.setActaul_ImplDate_Act(convertedDate);
								// System.out.println("Get input actaul output date = "+ bean.getActaul_ImplDate_Act());

							}

						} else {
							// *************************************************************************************************************
							// IF FILE inputs === >
							// *************************************************************************************************************
							String file_stored = null;
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString();

							// System.out.println("I am in else..........");

							for (int k = 1; k <= bean.getSrNo(); k++) {
							//	System.out.println("K is = " + k);

								// *************************************************************************************************************
								// if multiple files then there names are
								// inputName1,inputName2,inputName3,.......
								// *************************************************************************************************************

								if (fieldName.equalsIgnoreCase("inputName" + k)) {
									// System.out.println("File Name in java : " + fieldName);

									file_stored = fileItem.getName();

									bean.setFile_Name_ext(FilenameUtils
											.getName(file_stored));

									// System.out.println(FilenameUtils.getName(file_stored));

									file_Input = new DataInputStream(fileItem.getInputStream());
									/*System.out.println("Input sr no is = " + k);
									System.out.println("Action Disc. is = "+ bean.getAction_disc());*/

									/*************************************************************************************************************************
									 * Register complaint using data form fields
									 * and return complaint number
									 * **********************************************************************************************************************/

									int action_id = 0;
									if (!bean.getActual_Output().equals("")
											&& bean.getAction_No() != 0
											&& !bean.getActaul_ImplDate_Act()
													.equals(null)) {
										action_id = bo.addActualOP(bean,
												session);

										//System.out.println("i am in if action id is returned..."+ action_id);

										bean.setActionId(action_id);

									} else if (bean.getAction_disc() != null
											&& bean.getPdate() != null
											&& bean.getProp_output() != null
											&& k <= 1) {

										action_id = bo.addAction(bean, session);

										//System.out.println("i am in Else if action id is returned..."+ action_id);

										bean.setActionId(action_id);
									} else {
										//System.out.print("Some Error Found...");
									}
									// Attach file ====>
									bean.setFile_blob(file_Input);
									if (bean.getFile_Name_ext() != null) {

										//System.out.println("Inside file loop!!!!!!!!");
										dao.attach_File(bean, session);
									}
								}
							}
						}

					}

					int crno = Integer.parseInt(session.getAttribute("crno")
							.toString());
					String Transfer = bean.getMytext();
					if (Transfer.equals("")) {
						Transfer = bean.getMytextAct();
					}

					// System.out.println("CRNO ANd TID ==== " + crno + "\n" + Transfer);
					if (Transfer.equalsIgnoreCase("1")) {

						response.sendRedirect("Cab_Home.jsp");

					} else if (Transfer.equalsIgnoreCase("2")) {

						response.sendRedirect("NewRequest_AddAction.jsp?hid="
								+ crno);

					} else if (Transfer.equalsIgnoreCase("3")) {
						response.sendRedirect("Add_Action_Details.jsp?hid="
								+ crno);
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
