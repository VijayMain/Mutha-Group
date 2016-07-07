package com.muthagroup.vo;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

public class Edit_By_Search_VO {

	Timestamp date1, date2;
	int cust_id, p_id, company_id,status_id;
	
	
	
	
	public Timestamp getDate1() {
		return date1;
	}

	public void setDate1(Timestamp date1) {
		this.date1 = date1;
	}

	public Timestamp getDate2() {
		return date2;
	}

	public void setDate2(Timestamp date2) {
		this.date2 = date2;
	}

	public int getStatus_id() {
		return status_id;
	}

	public void setStatus_id(int status_id) {
		this.status_id = status_id;
	}

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	String complaint_no;

	public String getComplaint_no() {
		return complaint_no;
	}

	public void setComplaint_no(String complaint_no) {
		this.complaint_no = complaint_no;
	}

	public int getCust_id() {
		return cust_id;
	}

	public void setCust_id(int cust_id) {
		this.cust_id = cust_id;
	}

	public int getP_id() {
		return p_id;
	}

	public void setP_id(int p_id) {
		this.p_id = p_id;
	}

	public Edit_By_Search_VO(HttpServletRequest request) {

	}



}
