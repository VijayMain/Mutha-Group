package com.muthagroup.controller;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import com.muthagroup.bo.Add_PPAPTrials_bo;
import com.muthagroup.bo.Add_PrePPAPBatch_bo;
import com.muthagroup.vo.Add_PPAPTrials_vo;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
public class Add_PPAPTrials_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	boolean flag=false;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {

			Add_PPAPTrials_vo vo = new Add_PPAPTrials_vo();
			Boolean flag = false;
			InputStream file_Input = null;
			int basic_id=0;

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

							if (fieldName.equalsIgnoreCase("basic_id")) {
								vo.setBasic_id(Integer.parseInt(fieldValue));
								System.out.println("sheet_no == " + fieldValue);
								basic_id = vo.getBasic_id();
							}
							if (fieldName.equalsIgnoreCase("ppapbatch_lot")) {
								vo.setPpapbatch_lot(Integer
										.parseInt(fieldValue));
								System.out.println("Preppap batch lot == "
										+ fieldValue);
							}
							if (fieldName.equalsIgnoreCase("feedback")) {
								vo.setFeedback(fieldValue);
								System.out.println("feedback == " + fieldValue);
							}
							if (fieldName.equalsIgnoreCase("feedback_details")) {
								vo.setFeedback_details(fieldValue);
								System.out.println("feedback details == "
										+ fieldValue);
							}
							if (fieldName.equalsIgnoreCase("mcallocation")) {
								vo.setMc_allocation(Double
										.parseDouble(fieldValue));
								System.out.println("MC Allocation == "
										+ fieldValue);
							}
							if (fieldName.equalsIgnoreCase("ppap_date")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd");
								java.util.Date convertedDate = null;

								convertedDate = formatter.parse(fieldValue);

								final java.sql.Date Date12 = new java.sql.Date(
										convertedDate.getTime());
								vo.setPpap_date(Date12);
							}
							if (fieldName.equalsIgnoreCase("handover_toprod_date")) {

								SimpleDateFormat formatter = new SimpleDateFormat(
										"yyyy-MM-dd");
								java.util.Date convertedDate = null;

								convertedDate = formatter.parse(fieldValue);

								final java.sql.Date DatehandOvr = new java.sql.Date(
										convertedDate.getTime());
								vo.setHandover_toprod_date(DatehandOvr);
							}

						} else {
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

							if (fieldName.equalsIgnoreCase("Attachment")) {
								file_stored = fileItem.getName();
								// System.out.println(FilenameUtils.getName(file_stored));
								vo.setAttch_file_name(FilenameUtils
										.getName(file_stored));
								file_Input = new DataInputStream(
										fileItem.getInputStream());
								vo.setAttachment(file_Input);

							}
						}
					}
					Add_PPAPTrials_bo bo = new Add_PPAPTrials_bo();
					flag = bo.addPPAPBatch(vo, request);
				} catch (Exception e) {
					e.printStackTrace();
				}

				if (flag == true) {
					response.sendRedirect("Add_Trials.jsp?hid=" + basic_id);
				} else {
					System.out.println("Error occured at batch controller.....");
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
