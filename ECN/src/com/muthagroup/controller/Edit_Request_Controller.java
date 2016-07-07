package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import com.muthagroup.bo.Change_Request_BO;
import com.muthagroup.connectionUtility.Connection_Utility;
import com.muthagroup.dao.Change_Request_DAO;
import com.muthagroup.dao.EDIT_Request_DAO;
import com.muthagroup.vo.change_Request_Vo;
//============================================================================-->
//============================ Controller  ===================================-->
//============================================================================-->
public class Edit_Request_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		try {
			// ************************************************************************************************************************
			EDIT_Request_DAO dao = new EDIT_Request_DAO();
			Change_Request_BO bo = new Change_Request_BO();
			change_Request_Vo bean = new change_Request_Vo();
			HttpSession session = request.getSession();

			// **********************************************************************************************************
			Connection con = Connection_Utility.getConnection();
			ArrayList trk_list = new ArrayList();
			ArrayList chang_list = new ArrayList();
			InputStream file_Input = null;
			String NewReq = "";
			boolean flag = false;
			// To get Todays Date ====== >>>
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			System.out.println("by TIMESTAMP..:" + timestamp);

			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields
			 **********************************************************************************************************/

			if (ServletFileUpload.isMultipartContent(request)) {

				String fieldName, fieldValue = "";
				SimpleDateFormat formatter = new SimpleDateFormat(
						"dd-MM-yyyy HH:mm:ss");
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

							if (fieldName.equalsIgnoreCase("crno")) {
								bean.setCrno(Integer.parseInt(fieldValue));
								System.out.println("CR No ===== "
										+ bean.getCrno());
							}
							if (fieldName.equalsIgnoreCase("req_date")) {

								Timestamp convertedDate = null;

								convertedDate = new java.sql.Timestamp(
										formatter.parse(fieldValue).getTime());

								bean.setCR_Date(convertedDate);
								System.out.println("REq Date ==== "
										+ bean.getCR_Date());

							}

							if (fieldName.equalsIgnoreCase("supplier")) {

								bean.setCompany_Id(Integer.parseInt(fieldValue));
								System.out.println("Company === "
										+ bean.getCompany_Id());

							}
							if (fieldName.equalsIgnoreCase("item_name")) {
								bean.setItem_Id(Integer.parseInt(fieldValue));
								System.out.println("Item ==== "
										+ bean.getItem_Id());
							}

							if (fieldName.equalsIgnoreCase("Quality")) {
								bean.setQuality(fieldValue);
								System.out.println(bean.getQuality());
							}
							if (fieldName.equalsIgnoreCase("Cost")) {
								bean.setCost(fieldValue);
								System.out.println(bean.getCost());
							}
							if (fieldName.equalsIgnoreCase("Dimensional")) {
								bean.setDimensional(fieldValue);
								System.out.println(bean.getDimensional());
							}
							if (fieldName.equalsIgnoreCase("Delivery")) {
								bean.setDelivery(fieldValue);
								System.out.println(bean.getDelivery());
							}
							if (fieldName.equalsIgnoreCase("Material")) {
								bean.setMaterial(fieldValue);
								System.out.println(bean.getMaterial());
							}
							if (fieldName.equalsIgnoreCase("Safety")) {
								bean.setSafety(fieldValue);
								System.out.println(bean.getSafety());
							}

							if (fieldName.equalsIgnoreCase("change_selected")) {
								// System.out.println("Change sel = " +
								// fieldValue);
								chang_list.add(fieldValue);
								System.out.println("Testing change list === "
										+ chang_list);
								// bean.setSafety(fieldValue);
								// System.out.println(bean.getSafety());
							}

							if (fieldName.equalsIgnoreCase("Present")) {
								bean.setPresent_System(fieldValue);
								System.out.println(bean.getPresent_System());
							}
							if (fieldName.equalsIgnoreCase("Proposed")) {
								bean.setProposed_System(fieldValue);
								System.out.println(bean.getProposed_System());
							}
							if (fieldName.equalsIgnoreCase("Objective")) {
								bean.setObjective(fieldValue);
								System.out.println(bean.getObjective());
							}
							if (fieldName.equalsIgnoreCase("complaintno")) {
								bean.setComplaint_No(fieldValue);
								System.out.println(bean.getComplaint_No());
							}

							if (fieldName.equalsIgnoreCase("hid")) {
								NewReq = fieldValue.toString();
								System.out.println("Edit Request ==== "
										+ NewReq);
							}

							if (fieldName.equalsIgnoreCase("tracking_selected")) {

								trk_list.add(fieldValue);
								System.out
										.println("Testing tracking selected === "
												+ trk_list);

							}

							/*
							 * if
							 * (fieldName.equalsIgnoreCase("approver_selected"))
							 * { // bean.setSafety(fieldValue); //
							 * System.out.println(bean.getSafety()); //
							 * System.out.println("apr sel = " + // fieldValue);
							 * app_list.add(fieldValue);
							 * System.out.println("Testing Approvers === " +
							 * app_list); }
							 */

							if (fieldName.equalsIgnoreCase("proposeddate")) {

								Timestamp convertedDate = null;

								convertedDate = new java.sql.Timestamp(
										formatter.parse(fieldValue).getTime());

								bean.setProposed_Impl_Date(convertedDate);
								System.out.println("Get input date = "
										+ bean.getProposed_Impl_Date());
							}

							if (fieldName.equalsIgnoreCase("actualimpldate")) {

								Timestamp convertedDate = null;
								String val = fieldValue.toString();
								if (val.equals("")) {

									convertedDate = new java.sql.Timestamp(
											formatter.parse(
													"0000-00-00 00:00:00")
													.getTime());

									bean.setActual_Impl_Date(convertedDate);
									System.out.println("Get input date = "
											+ bean.getActual_Impl_Date());
								} else {
									convertedDate = new java.sql.Timestamp(
											formatter.parse(fieldValue)
													.getTime());

									bean.setActual_Impl_Date(convertedDate);
									System.out.println("Get input date = "
											+ bean.getActual_Impl_Date());
								}

							}

							if (fieldName.equalsIgnoreCase("srno")) {
								bean.setSrno(Integer.parseInt(fieldValue));
								System.out
										.println(Integer.parseInt(fieldValue));
							}
							// *****************************************************************************
							// Get Complaint date ===== >
							// ******************************************************************************

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
									System.out.println("File Name in java : "
											+ fieldName);
									file_stored = fileItem.getName();

									bean.setFile_Name(FilenameUtils
											.getName(file_stored));

									System.out.println(FilenameUtils
											.getName(file_stored));

									file_Input = new DataInputStream(
											fileItem.getInputStream());
									System.out.println("Input sr no is = " + k);

									/*************************************************************************************************************************
									 * Register complaint using data form fields
									 * and return complaint number
									 * **********************************************************************************************************************/

									if (k == 1) {

										int comp_id = 0;
										int dept_id=0;
										int login_U_Id=0;
										login_U_Id=Integer.parseInt(session.getAttribute("uid").toString());
										ArrayList app_list = new ArrayList();
										PreparedStatement ps_ap = con.prepareStatement("select * from user_tbl where U_Id="+login_U_Id);
										ResultSet rs_ap = ps_ap.executeQuery();
										while (rs_ap.next()) {
											comp_id = rs_ap.getInt("Company_Id");
											dept_id=rs_ap.getInt("Dept_Id");
										}
										System.out.println("Company Id =  "+ comp_id);
										System.out.println("Department Id =  "+ dept_id);
										
										ArrayList deptheads = new ArrayList();
										
										
										PreparedStatement ps_dept = con.prepareStatement("select * from user_tbl_depthead where Company_Id="+comp_id+" and dept_id="+dept_id);
										ResultSet rs_dept = ps_dept.executeQuery();
										while (rs_dept.next()) 
										{
											deptheads.add(rs_dept.getInt("U_Id"));
										}

										if(deptheads.contains(login_U_Id))
											{
												app_list.clear();
											}
										else
											{
												app_list.addAll(deptheads);
											}
										System.out.println("Department head "+ app_list);
										// ******************************************************************************************************************
										
										ArrayList plantheads = new ArrayList();
										
										PreparedStatement ps_plant = con
												.prepareStatement("select * from user_tbl_planthead where Company_Id="+ comp_id);
										ResultSet rs_plant = ps_plant.executeQuery();
										while (rs_plant.next()) 
										{
											plantheads.add(rs_plant.getInt("U_Id"));
										}

										if(plantheads.contains(login_U_Id))
										{
											app_list.clear();
											PreparedStatement ps_management=con.prepareStatement("select U_Id from User_Tbl where dept_id=11");
											ResultSet rs_management=ps_management.executeQuery();
											while(rs_management.next())
											{
												app_list.add(rs_management.getInt("U_Id"));
											}
											
										}else
										{
											app_list.addAll(plantheads);
										}

										
										System.out.println("Applist ==== "
												+ app_list);

										System.out
												.println("In Loop" + trk_list);
										flag = bo.Edit_changeRequest(bean,
												app_list, chang_list, session,
												trk_list);
									}
									// Attach file ====>
									bean.setFile_blob(file_Input);
									if (bean.getFile_Name() != null) {
										flag = dao.attach_File(bean, session);
									}

								}
							}
						}

					}

					if (flag == true && NewReq.equalsIgnoreCase("1")) {
						response.sendRedirect("NewRequest_AddAction.jsp?hid="
								+ bean.getCrno());
					} else if (flag == true && NewReq.equalsIgnoreCase("2")) {
						response.sendRedirect("Cab_Home.jsp");
					} else if (flag == false) {
						out.println("Fail");
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
//============================================================================--> 
//============================================================================-->