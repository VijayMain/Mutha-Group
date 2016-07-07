package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
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
import org.exolab.castor.types.Date;

import com.muthagroup.bo.NewSheet_bo;

import com.muthagroup.dao.NewSheet_dao;

import com.muthagroup.vo.NewSheet_vo;

import java.text.SimpleDateFormat;

public class NewSheet_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		/**********************************************************************************************************
		 * For MultipartContent Separate FILE Fields and FORM Fields
		 **********************************************************************************************************/
		try {
			int basic_id = 0;
			NewSheet_vo bean = new NewSheet_vo();
			NewSheet_dao dao = new NewSheet_dao();
			NewSheet_bo bo = new NewSheet_bo();
			InputStream file_Input = null;

			// NewSheet_dao dao = new NewSheet_dao();
			// NewSheet_bo bo = new NewSheet_bo();

			HttpSession session = request.getSession();

			// DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			// get current date time with Date()

			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields
			 **********************************************************************************************************/

			if (ServletFileUpload.isMultipartContent(request)) {
				String fieldName, fieldValue = "";

				// ******** Temporary storage for items =====>

				ServletFileUpload servletFileUpload = new ServletFileUpload(
						new DiskFileItemFactory());
				List fileItemsList;
				boolean flag = false;

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
							if (fieldName.equalsIgnoreCase("sheet_no")) {
								bean.setSheet_no(Integer.parseInt(fieldValue));
								System.out.println("sheet_no == " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("customer")) {
								bean.setCust_name(fieldValue);
								System.out.println("Cust Name === "
										+ fieldValue);
							}
							if (fieldName.equalsIgnoreCase("part_name")) {
								bean.setPart_name(fieldValue);
								System.out.println("part Name === "
										+ fieldValue);
							}
							if (fieldName.equalsIgnoreCase("part_no")) {
								bean.setPart_no(fieldValue);

								System.out.println("part_no === " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("grade_type")) {
								bean.setGrade_type(fieldValue);
								System.out.println("Grade type == "
										+ fieldValue);
							}
							if (fieldName.equalsIgnoreCase("revision_no")) {
								bean.setRevesion_no(fieldValue);
								System.out.println("Revision no === "
										+ fieldValue);
							}
							if (fieldName.equalsIgnoreCase("revised_date")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd");
								java.util.Date convertedDate = null;

								convertedDate = formatter.parse(fieldValue);

								final java.sql.Date Date12 = new java.sql.Date(
										convertedDate.getTime());

								System.out.println("from jsp selected Date::::"
										+ Date12);

								bean.setRevised_date(Date12);
							}
							if (fieldName.equalsIgnoreCase("plant_name")) {
								System.out.println("plant name ======== "
										+ fieldValue);
								bean.setPlant_name(Integer.parseInt(fieldValue));

							}
							if (fieldName.equalsIgnoreCase("project_leader")) {
								System.out.println("project leader ==== "
										+ fieldValue);
								bean.setProject_leader(Integer
										.parseInt(fieldValue));

							}

							if (fieldName.equalsIgnoreCase("casting_from")) {
								System.out.println("casting from == "
										+ fieldValue);
								bean.setCasting_from(Integer
										.parseInt(fieldValue));
							}

							if (fieldName.equalsIgnoreCase("related_person")) {
								System.out.println("related person === "
										+ fieldValue);
								bean.setRelated_person(Integer
										.parseInt(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("plant_vendor")) {
								System.out.println("plant vendor === "
										+ fieldValue);
								bean.setPV_name(fieldValue);
							}
							if (fieldName.equalsIgnoreCase("casting_vendor")) {
								System.out.println("casting vendor === "
										+ fieldValue);
								bean.setCV_name(fieldValue);
							}
							if (fieldName.equalsIgnoreCase("plan_start_date")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd");
								java.util.Date convertedDate = null;

								convertedDate = formatter.parse(fieldValue);

								final java.sql.Date Date12 = new java.sql.Date(
										convertedDate.getTime());

								System.out.println("from jsp Start Date::::"
										+ Date12);

								bean.setPlan_start_date(Date12);
							}
							if (fieldName.equalsIgnoreCase("plan_end_date")) {
								SimpleDateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd");
								java.util.Date convertedDate = null;

								convertedDate = formatter.parse(fieldValue);

								final java.sql.Date Date12 = new java.sql.Date(
										convertedDate.getTime());

								System.out
										.println("from jsp selected End Date::::"
												+ Date12);
								bean.setPlan_end_date(Date12);
							}
							if (fieldName.equalsIgnoreCase("act_start_date")) {

								if (!fieldValue.equalsIgnoreCase("")) {
									SimpleDateFormat formatter = new SimpleDateFormat(
											"yyyy-MM-dd");
									java.util.Date convertedDate = null;

									convertedDate = formatter.parse(fieldValue);

									final java.sql.Date Date12 = new java.sql.Date(
											convertedDate.getTime());

									System.out
											.println("from jsp selected End Date::::"
													+ Date12);
									bean.setAct_start_date(Date12);
								} else {
									bean.setAct_start_date(null);
								}
							}
							if (fieldName.equalsIgnoreCase("act_end_date")) {
								if (!fieldValue.equalsIgnoreCase("")) {
									SimpleDateFormat formatter = new SimpleDateFormat(
											"yyyy-MM-dd");
									java.util.Date convertedDate = null;

									convertedDate = formatter.parse(fieldValue);

									final java.sql.Date Date12 = new java.sql.Date(
											convertedDate.getTime());

									System.out
											.println("from jsp selected End Date::::"
													+ Date12);
									bean.setAct_end_date(Date12);
								} else {
									bean.setAct_end_date(null);
								}
							}

							if (fieldName.equalsIgnoreCase("marketing_apr")) {
								System.out.println("marketing_apr =="
										+ fieldValue);
								bean.setMarketing_apr(fieldValue);
							}

							if (fieldName
									.equalsIgnoreCase("schedule_per_month")) {
								System.out.println("schedule_per_month =="
										+ fieldValue);
								bean.setSchedule_per_month(Integer
										.parseInt(fieldValue));
							}

							if (fieldName.equalsIgnoreCase("po_number")) {
								System.out
										.println("po number  ==" + fieldValue);
								bean.setPo_number(fieldValue);
							}

							if (fieldName.equalsIgnoreCase("po_date")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd");
								java.util.Date convertedDate = null;

								convertedDate = formatter.parse(fieldValue);

								final java.sql.Date Date12 = new java.sql.Date(
										convertedDate.getTime());

								System.out
										.println("from jsp selected po Date::::"
												+ Date12);
								bean.setPo_date(Date12);
							}
							if (fieldName.equalsIgnoreCase("po_receivedDate")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd");
								java.util.Date convertedDate = null;

								convertedDate = formatter.parse(fieldValue);

								final java.sql.Date Date12 = new java.sql.Date(
										convertedDate.getTime());

								System.out
										.println("from jsp selected po received Date::::"
												+ Date12);

								bean.setPo_received_date(Date12);

							}
							if (fieldName.equalsIgnoreCase("srno")) {
								bean.setSrNo(Integer.parseInt(fieldValue
										.toString()));
								System.out.println("Sr No ==== " + fieldValue);
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

							// *************************************************************************************************************
							// if multiple files then there names are
							// inputName1,inputName2,inputName3,.......
							// *************************************************************************************************************

							if (fieldName.equalsIgnoreCase("attached_po_cust")) {
								System.out.println("File Name in java : "
										+ fieldName);
								file_stored = fileItem.getName();

								System.out.println(FilenameUtils
										.getName(file_stored));

								bean.setPo_file_name(FilenameUtils
										.getName(file_stored));

								file_Input = new DataInputStream(
										fileItem.getInputStream());

								bean.setPo_file_blob(file_Input);

							}
							if (fieldName.equalsIgnoreCase("part_image")) {
								System.out.println("File Name in java : "
										+ fieldName);
								file_stored = fileItem.getName();

								System.out.println(FilenameUtils
										.getName(file_stored));

								file_Input = new DataInputStream(
										fileItem.getInputStream());

								bean.setPartImage_file_name(FilenameUtils
										.getName(file_stored));

								bean.setPartImage_file_blob(file_Input);
							}
							if (fieldName.equalsIgnoreCase("3D_drawing")) {
								System.out.println("File Name in java : "
										+ fieldName);
								file_stored = fileItem.getName();

								System.out.println(FilenameUtils
										.getName(file_stored));

								file_Input = new DataInputStream(
										fileItem.getInputStream());

								bean.setThreeD_drawing_file_name(FilenameUtils
										.getName(file_stored));

								bean.setThreeD_drawing(file_Input);
							}
							if (fieldName.equalsIgnoreCase("2D_drawing")) {
								System.out.println("File Name in java : "
										+ fieldName);
								file_stored = fileItem.getName();

								System.out.println(FilenameUtils
										.getName(file_stored));

								file_Input = new DataInputStream(
										fileItem.getInputStream());

								bean.setTwoD_drawing_file_name(FilenameUtils
										.getName(file_stored));

								bean.setTwoD_drawing(file_Input);
							}
							System.out.println("Sr no " + bean.getSrNo());

							for (int k = 1; k <= bean.getSrNo(); k++) {
								System.out.println("Sr no " + bean.getSrNo());
								if (fieldName.equalsIgnoreCase("inputName" + k)) {
									System.out.println("File Name in java : "
											+ fieldName);
									file_stored = fileItem.getName();

									bean.setFile_Name_ext(FilenameUtils
											.getName(file_stored));

									System.out.println(FilenameUtils
											.getName(file_stored));

									file_Input = new DataInputStream(
											fileItem.getInputStream());
									System.out.println("Input sr no is = " + k);

									if (k == 1
											&& bean.getProject_leader() != 0
											&& bean.getRelated_person() != 0
											&& bean.getSchedule_per_month() != 0
											// && bean.getPlant_name() != 0
											// && bean.getCasting_from() != 0
											&& bean.getRevesion_no() != null
											&& bean.getCust_name() != null
											&& bean.getGrade_type() != null
											&& bean.getCV_name() != null
											&& bean.getPV_name() != null
											&& bean.getMarketing_apr() != null
											&& bean.getPo_number() != null
											&& bean.getPart_name() != null
											&& bean.getPo_file_name() != null
											&& bean.getPartImage_file_name() != null
											&& bean.getTwoD_drawing_file_name() != null
											&& bean.getThreeD_drawing_file_name() != null
											&& bean.getPlan_start_date() != null
											&& bean.getPlan_end_date() != null
											&& bean.getRevised_date() != null
											&& bean.getPo_date() != null
											&& bean.getPo_received_date() != null
											&& bean.getPo_file_blob() != null
											&& bean.getPartImage_file_blob() != null
											&& bean.getTwoD_drawing() != null
											&& bean.getThreeD_drawing() != null) {

										basic_id = bo
												.addNewSheet(request, bean);
										System.out.println("Basic Id k==1"
												+ basic_id);
									}

									System.out.println("K is = " + k);
									bean.setOther_file_blob(file_Input);
									if (bean.getFile_Name_ext() != null) {

										System.out
												.println("Basic Id =  == == == "
														+ basic_id);
										flag = dao.attach_File(bean, session,
												basic_id);
									}

								}
							}

						}

					}

					// check flag and redirect

					if (flag == true) {
						response.sendRedirect("Home.jsp");
					} else {
						// response.sendRedirect("Entry Failed");
						System.out.println("Error occured....!!! ");

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
