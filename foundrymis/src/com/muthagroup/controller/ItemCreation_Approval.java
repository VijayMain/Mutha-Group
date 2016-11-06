package com.muthagroup.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.ItemCreation_Approval_dao;
import com.muthagroup.vo.ItemCreation_Approval_vo;

public class ItemCreation_Approval extends HttpServlet {
private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			ItemCreation_Approval_vo vo = new ItemCreation_Approval_vo();
			
			vo.setSupplier(request.getParameter("supplier").toUpperCase());
			vo.setShort_supplier(request.getParameter("short_supplier").toUpperCase());
			vo.setSupp_address(request.getParameter("supp_address").toUpperCase());
			vo.setSupp_city(request.getParameter("supp_city"));
			vo.setPin_supplier(request.getParameter("pin_supplier"));
			vo.setVendor_code(request.getParameter("vendor_code"));
			vo.setFax_supplier(request.getParameter("fax_supplier"));
			vo.setEmail_supplier(request.getParameter("email_supplier"));
			vo.setWebsite_supplier(request.getParameter("website_supplier"));
			vo.setWork_address(request.getParameter("work_address").toUpperCase());
			vo.setCredit_days(request.getParameter("credit_days"));
			vo.setTin_sst(request.getParameter("tin_sst"));
			vo.setTin_sst_date(request.getParameter("tin_sst_date"));
			vo.setCst_number(request.getParameter("cst_number"));
			vo.setCst_number_date(request.getParameter("cst_number_date"));
			vo.setService_tax(request.getParameter("service_tax"));
			vo.setService_tax_date(request.getParameter("service_tax_date"));
			vo.setEcc_no(request.getParameter("ecc_no"));
			vo.setExcise_range(request.getParameter("excise_range"));
			vo.setDivision(request.getParameter("division"));
			vo.setCollectorate(request.getParameter("collectorate"));
			vo.setSupp_category(request.getParameter("supp_category"));
			vo.setCategory(request.getParameter("category"));
			vo.setPan_no(request.getParameter("pan_no"));
			vo.setTan_no(request.getParameter("tan_no"));
			vo.setLbt_no(request.getParameter("lbt_no"));
			vo.setTds_code(request.getParameter("tds_code"));
			vo.setIndus_type(request.getParameter("indus_type"));
			vo.setTds_method(request.getParameter("tds_method"));
			vo.setExcise_round(request.getParameter("excise_round"));
			vo.setExcise_cessround(request.getParameter("excise_cessround"));
			vo.setService_taxround(request.getParameter("service_taxround"));
			vo.setService_cessround(request.getParameter("service_cessround"));
			vo.setVat_round(request.getParameter("vat_round"));
			vo.setNet_amountRound(request.getParameter("net_amountRound"));
			vo.setIs_overseas(request.getParameter("is_overseas"));
			vo.setAccount_name(request.getParameter("account_name").toUpperCase());
			vo.setAccount_number(request.getParameter("account_number"));
			vo.setBank_name(request.getParameter("bank_name").toUpperCase());
			vo.setBranch(request.getParameter("branch"));
			vo.setIfsc_rtgs(request.getParameter("ifsc_rtgs"));
			vo.setIfsc_neft(request.getParameter("ifsc_neft"));
			vo.setMicr_code(request.getParameter("micr_code"));
			vo.setPhone_number1(request.getParameter("phone_number1"));
			vo.setPhone_number2(request.getParameter("phone_number2"));
			vo.setBank_address1(request.getParameter("bank_address1").toUpperCase());
			vo.setBank_address2(request.getParameter("bank_address2").toUpperCase());
			vo.setBank_address3(request.getParameter("bank_address3").toUpperCase());
			
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
