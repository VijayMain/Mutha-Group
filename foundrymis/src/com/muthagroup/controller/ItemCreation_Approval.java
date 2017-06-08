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

import com.muthagroup.dao.ItemCreation_Approval_dao;
import com.muthagroup.vo.ItemCreation_Approval_vo;

public class ItemCreation_Approval extends HttpServlet {
private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			FileItem fileItem = null;
			InputStream file_Input = null;
			ItemCreation_Approval_vo vo = new ItemCreation_Approval_vo(); 
			InputStream doc_Input = null,photo_Input = null; 
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
							
				if (fieldName.equalsIgnoreCase("supplier")) { 
					vo.setSupplier(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("short_supplier")) {
					vo.setShort_supplier(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("supp_address")) {
					vo.setSupp_address(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("supp_city")) {
					vo.setSupp_city(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("pin_supplier")) {
					vo.setPin_supplier(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("vendor_code")) {
					vo.setVendor_code(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("fax_supplier")) {
					vo.setFax_supplier(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("email_supplier")) {
					vo.setEmail_supplier(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("website_supplier")) {
					vo.setWebsite_supplier(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("work_address")) {
					vo.setWork_address(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("credit_days")) {
					vo.setCredit_days(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("tin_sst")) {
					vo.setTin_sst(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("tin_sst_date")) {
					vo.setTin_sst_date(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("cst_number")) {
					vo.setCst_number(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("cst_number_date")) {
					vo.setCst_number_date(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("service_tax")) {
					vo.setService_tax(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("service_tax_date")) {
					vo.setService_tax_date(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("ecc_no")) {
					vo.setEcc_no(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("excise_range")) {
					vo.setExcise_range(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("division")) {
					vo.setDivision(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("collectorate")) {
					vo.setCollectorate(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("supp_category")) {
					vo.setSupp_category(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("purpose")) {
					vo.setPurpose(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("category")) {
					vo.setCategory(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("pan_no")) {
					vo.setPan_no(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("tan_no")) {
					vo.setTan_no(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("lbt_no")) {
					vo.setLbt_no(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("tds_code")) {
					vo.setTds_code(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("indus_type")) {
					vo.setIndus_type(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("tds_method")) {
					vo.setTds_method(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("excise_round")) {
					vo.setExcise_round(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("excise_cessround")) {
					vo.setExcise_cessround(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("service_taxround")) {
					vo.setService_taxround(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("service_cessround")) {
					vo.setService_cessround(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("vat_round")) {
					vo.setVat_round(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("net_amountRound")) {
					vo.setNet_amountRound(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("is_overseas")) {
					vo.setIs_overseas(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("account_name")) {
					vo.setAccount_name(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("account_number")) {
					vo.setAccount_number(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("bank_name")) {
					vo.setBank_name(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("branch")) {
					vo.setBranch(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("ifsc_rtgs")) {
					vo.setIfsc_rtgs(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("ifsc_neft")) {
					vo.setIfsc_neft(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("micr_code")) {
					vo.setMicr_code(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("phone_number1")) {
					vo.setPhone_number1(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("phone_number2")) {
					vo.setPhone_number2(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("phone_number3")) {
					vo.setPhone_number3(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("bank_address1")) {
					vo.setBank_address1(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("bank_address2")) {
					vo.setBank_address2(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("bank_address3")) {
					vo.setBank_address3(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("supplier_phone1")) {
					vo.setSupplier_phone1(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("supplier_phone2")) {
					vo.setSupplier_phone2(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("supplier_phone3")) {
					vo.setSupplier_phone3(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("relativeinMutha")) {
					vo.setRelativeinMutha(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("relative_name")) {
					vo.setRelative_name(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("turnYear1")) {
					vo.setTurnYear1(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("turnover1")) {
					vo.setTurnover1(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("turnYear2")) {
					vo.setTurnYear2(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("turnover2")) {
					vo.setTurnover2(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("turnYear3")) {
					vo.setTurnYear3(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("turnover3")) {
					vo.setTurnover3(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("owners_name")) {
					vo.setOwners_name(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("meplH21")) {
					vo.setMeplH21(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("meplH25")) {
					vo.setMeplH25(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("mfpl")) {
					vo.setMfpl(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("di")) {
					vo.setDi(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("meplunitIII")) {
					vo.setMeplunitIII(fieldValue);
				}
				
				
				if (fieldName.equalsIgnoreCase("gstin_reg")) {
					vo.setGstin_reg(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("GSTIN_number")) {
					vo.setGSTIN_number(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("line_itemgstround")) {
					vo.setLine_itemgstround(fieldValue);
				}
				if (fieldName.equalsIgnoreCase("state_gst")) {
					vo.setState_gst(fieldValue);
				} 
				// gstin_reg, GSTIN_number, line_itemgstround,state_gst;
				
				}else {
							// *************************************************************************************************************
							// IF FILE inputs === >
							// *************************************************************************************************************
							String file_stored = null; 
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString(); 		
								if (fieldName.equalsIgnoreCase("attachment")) { 
									file_stored = fileItem.getName();
									vo.setAttachment_name(FilenameUtils.getName(file_stored));
									file_Input = new DataInputStream(fileItem.getInputStream());
									vo.setAttachment(file_Input);
								}
							}
					}
			}
			HttpSession session = request.getSession();
			String sr = session.getAttribute("uid").toString();
			int uid = Integer.parseInt(sr);
			
			ItemCreation_Approval_dao dao = new ItemCreation_Approval_dao();
			dao.add_newERPitems(uid,response,vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}