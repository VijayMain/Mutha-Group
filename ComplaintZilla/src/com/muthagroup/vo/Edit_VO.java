package com.muthagroup.vo;

import java.sql.Timestamp;

public class Edit_VO {

	int company_id;
	int cust_id;
	int item_id;
	int srno;
	int status_id;

	String received;

	int p_id;
	int category;
	int defect;

	String discription;

	int related;
	int assigned;
	int priority;
	
	Timestamp c_date;
	Timestamp date;
	
	String file_Name_ext;
	String complaint_no;

	

	
	public Timestamp getC_date() {
		return c_date;
	}

	public void setC_date(Timestamp c_date) {
		this.c_date = c_date;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getComplaint_no() {
		return complaint_no;
	}

	public void setComplaint_no(String complaint_no) {
		this.complaint_no = complaint_no;
	}

	public String getFile_Name_ext() {
		return file_Name_ext;
	}

	public void setFile_Name_ext(String file_Name_ext) {
		this.file_Name_ext = file_Name_ext;
	}

	public int getSrno() {
		return srno;
	}

	public void setSrno(int srno) {
		this.srno = srno;
	}


	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	public int getCust_id() {
		return cust_id;
	}

	public void setCust_id(int cust_id) {
		this.cust_id = cust_id;
	}

	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public int getStatus_id() {
		return status_id;
	}

	public void setStatus_id(int status_id) {
		this.status_id = status_id;
	}

	public String getReceived() {
		return received;
	}

	public void setReceived(String received) {
		this.received = received;
	}

	public int getP_id() {
		return p_id;
	}

	public void setP_id(int p_id) {
		this.p_id = p_id;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getDefect() {
		return defect;
	}

	public void setDefect(int defect) {
		this.defect = defect;
	}

	public String getDiscription() {
		return discription;
	}

	public void setDiscription(String discription) {
		this.discription = discription;
	}

	public int getRelated() {
		return related;
	}

	public void setRelated(int related) {
		this.related = related;
	}

	public int getAssigned() {
		return assigned;
	}

	public void setAssigned(int assigned) {
		this.assigned = assigned;
	}

	
}
