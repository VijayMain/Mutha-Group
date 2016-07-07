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

import com.muthagroup.bo.Customer_Request_BO;
import com.muthagroup.connectionUtility.Connection_Utility;
import com.muthagroup.dao.Customer_Request_DAO;
import com.muthagroup.vo.Customer_Request_VO;
//============================================================================-->
//============================ Controller  ===================================-->
//============================================================================-->
public class Customer_Request_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		try {
			// ************************************************************************************************************************
			Customer_Request_BO bo = new Customer_Request_BO();
			Customer_Request_DAO dao = new Customer_Request_DAO();
			Customer_Request_VO bean = new Customer_Request_VO();

			// **********************************************************************************************************
			Connection con = Connection_Utility.getConnection();
			ArrayList chang_dept = new ArrayList();
			InputStream file_Input = null;
			int NewReq = 0;

			boolean flag = false;
			HttpSession session = request.getSession();
			// To get Todays Date ====== >>>
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			System.out.println("by TIMESTAMP..:" + timestamp);

			// ************************************************************************************************************************

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

							if (fieldName.equalsIgnoreCase("crcno")) {
								bean.setCrcno(Integer.parseInt(fieldValue));
								System.out.println(bean.getCrcno());
							}
							if (fieldName.equalsIgnoreCase("cust_company_name")) {

								bean.setCompany_Id(Integer.parseInt(fieldValue));
								System.out.println(bean.getCompany_Id());

							}
							if (fieldName.equalsIgnoreCase("cust_name")) {

								bean.setCust_Id(Integer.parseInt(fieldValue));
								System.out.println(bean.getCust_Id());

							}
							if (fieldName.equalsIgnoreCase("item_name")) {
								bean.setItem_Id(Integer.parseInt(fieldValue));
								System.out.println(bean.getItem_Id());
							}

							if (fieldName.equalsIgnoreCase("change")) {
								bean.setChange_For(fieldValue);
								System.out.println(bean.getChange_For());
							}

							if (fieldName.equalsIgnoreCase("extchg")) {
								bean.setExisting_Change_level(fieldValue);
								System.out.println(bean
										.getExisting_Change_level());
							}
							if (fieldName.equalsIgnoreCase("extchgdate")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"dd-MM-yyyy HH:mm:ss");
								Timestamp convertedDate = null;

								convertedDate = new java.sql.Timestamp(
										formatter.parse(fieldValue).getTime());

								bean.setExisting_Change_level_Date(convertedDate);
								System.out
										.println("Get existing change level date = "
												+ bean.getExisting_Change_level_Date());
							}

							if (fieldName.equalsIgnoreCase("newchg")) {
								bean.setNew_Change_level(fieldValue);
								System.out.println(bean.getNew_Change_level());
							}

							if (fieldName.equalsIgnoreCase("newchgdate")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"dd-MM-yyyy HH:mm:ss");
								Timestamp convertedDate = null;

								convertedDate = new java.sql.Timestamp(
										formatter.parse(fieldValue).getTime());

								bean.setNew_Change_level_Date(convertedDate);
								System.out
										.println("Get new  change level date = "
												+ bean.getNew_Change_level_Date());
							}

							if (fieldName.equalsIgnoreCase("naturechg")) {
								bean.setNature_Of_Change(fieldValue);
								System.out.println(bean.getNature_Of_Change());
							}

							if (fieldName.equalsIgnoreCase("reasonchg")) {
								bean.setReason_For_Change(fieldValue);
								System.out.println(bean.getReason_For_Change());
							}

							if (fieldName.equalsIgnoreCase("targetdate")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"dd-MM-yyyy HH:mm:ss");
								Timestamp convertedDate = null;
								String val = fieldValue.toString();
								convertedDate = new java.sql.Timestamp(
										formatter.parse(fieldValue).getTime());

								bean.setTargated_Impl_Date(convertedDate);
								System.out.println("Get targeted date = "
										+ bean.getTargated_Impl_Date());

							}

							if (fieldName.equalsIgnoreCase("level")) {
								bean.setChange_Level(fieldValue);
								System.out.println(bean.getChange_Level());
							}

							if (fieldName.equalsIgnoreCase("wip")) {
								bean.setExisting_WIP_Stock(Double
										.parseDouble(fieldValue));
								System.out
										.println(bean.getExisting_WIP_Stock());
							}

							if (fieldName.equalsIgnoreCase("ascast")) {
								bean.setExisting_As_Cast_Stock(Double
										.parseDouble(fieldValue));
								System.out.println(bean
										.getExisting_As_Cast_Stock());
							}

							if (fieldName.equalsIgnoreCase("total")) {
								bean.setTotal_Stock(Double
										.parseDouble(fieldValue));
								System.out.println(bean.getTotal_Stock());
							}

							if (fieldName.equalsIgnoreCase("oldtool")) {
								bean.setTooling_Old(Double
										.parseDouble(fieldValue));
								System.out.println(Double
										.parseDouble(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("newtool")) {
								bean.setTooling_New(Double
										.parseDouble(fieldValue));
								System.out.println(Double
										.parseDouble(fieldValue));
							}

							if (fieldName.equalsIgnoreCase("old_fixture")) {
								bean.setFixture_Old(Double
										.parseDouble(fieldValue));
								System.out.println(Double
										.parseDouble(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("new_fixture")) {
								bean.setFixture_New(Double
										.parseDouble(fieldValue));
								System.out.println(Double
										.parseDouble(fieldValue));
							}

							if (fieldName.equalsIgnoreCase("old_gauges")) {
								bean.setGauges_Old(Double
										.parseDouble(fieldValue));
								System.out.println(Double
										.parseDouble(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("new_gauges")) {
								bean.setGauges_New(Double
										.parseDouble(fieldValue));
								System.out.println(Double
										.parseDouble(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("ppap")) {
								bean.setPPAP(fieldValue);
								System.out.println("ppap === " + fieldValue);
							}

							if (fieldName.equalsIgnoreCase("Actualimpldate")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"dd-MM-yyyy HH:mm:ss");
								Timestamp convertedDate = null;
								String val = fieldValue.toString();
								if (val.equals("")) {

									convertedDate = new java.sql.Timestamp(
											formatter.parse(
													"0000-00-00 00:00:00")
													.getTime());

									bean.setActual_Impl_Date(convertedDate);
									System.out
											.println("Get Actual Implementation date = "
													+ bean.getActual_Impl_Date());
								} else {
									convertedDate = new java.sql.Timestamp(
											formatter.parse(fieldValue)
													.getTime());

									bean.setActual_Impl_Date(convertedDate);
									System.out
											.println("Get Actual Implementation date = "
													+ bean.getActual_Impl_Date());
								}

							}

							if (fieldName
									.equalsIgnoreCase("department_selected")) {

								chang_dept.add(fieldValue);
								System.out.println("Testing departments === "
										+ chang_dept);

							}

							/*
							 * if
							 * (fieldName.equalsIgnoreCase("approver_selected"))
							 * {
							 * 
							 * app_list.add(fieldValue);
							 * System.out.println("Testing Approvers === " +
							 * app_list); }
							 */

							if (fieldName.equalsIgnoreCase("srno")) {
								bean.setSrno(Integer.parseInt(fieldValue));
								System.out.println(Integer.parseInt(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("valReq")) {
								NewReq = Integer
										.parseInt(fieldValue.toString());
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

									if (k >= 1) {

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


										/*
										 * Set set = new HashSet();
										 * set.addAll(dept_Heads);
										 * app_list.add(de);
										 */
										System.out.println("Applist ==== "
												+ app_list);

										flag = bo.changeRequest(bean, app_list,
												chang_dept, session);
									}
									// Attach file ====>
									bean.setFile_blob(file_Input);
									if (bean.getFile_Name() != "") 
									{
										flag = dao.attach_File(bean, session);
									}

								}
							}
						}

					}

					if (flag == true && NewReq == 1) {
						response.sendRedirect("Cab_Home.jsp");
					} else if (flag == true && NewReq == 2) {
						response.sendRedirect("NewRequestCustomer_AddAction.jsp?hid="
								+ bean.getCrcno());
					} else if (flag == false) {
						out.println("Problem loading page");
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