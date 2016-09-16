package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Timestamp;

public class Register_VO {

	int cust_comp_id;
	int cust_id;
	int item_id;
	int severity;
	String received;
	String discription;
	int related;
	String defect;
	int assigned;
	int category;
	int srNo;
	Timestamp date = null;
	String file_Name_ext;
	String complaint_No, complaint_type;
	InputStream file_blob;
	int count;
	int unregistered;

	public String getComplaint_type() {
		return complaint_type;
	}

	public void setComplaint_type(String complaint_type) {
		this.complaint_type = complaint_type;
	}

	public int getUnregistered() {
		return unregistered;
	}

	public void setUnregistered(int unregistered) {
		this.unregistered = unregistered;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public InputStream getFile_blob() {
		return file_blob;
	}

	public void setFile_blob(InputStream file_blob) {
		this.file_blob = file_blob;
	}

	public String getComplaint_No() {
		return complaint_No;
	}

	public void setComplaint_No(String complaint_No) {
		this.complaint_No = complaint_No;
	}

	InputStream file_Array[];

	public InputStream[] getFile_Array() {
		return file_Array;
	}

	public void setFile_Array(InputStream[] file_Array) {
		this.file_Array = file_Array;
	}

	public String getFile_Name_ext() {
		return file_Name_ext;
	}

	public void setFile_Name_ext(String file_Name_ext) {
		this.file_Name_ext = file_Name_ext;
	}

	public int getSrNo() {
		return srNo;
	}

	public void setSrNo(int srNo) {
		this.srNo = srNo;
	}

	public int getCust_comp_id() {
		return cust_comp_id;
	}

	public void setCust_comp_id(int cust_comp_id) {
		this.cust_comp_id = cust_comp_id;
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

	public int getSeverity() {
		return severity;
	}

	public void setSeverity(int severity) {
		this.severity = severity;
	}

	public String getReceived() {
		return received;
	}

	public void setReceived(String received) {
		this.received = received;
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

	public String getDefect() {
		return defect;
	}

	public void setDefect(String fieldValue) {
		this.defect = fieldValue;
	}

	public int getAssigned() {
		return assigned;
	}

	public void setAssigned(int assigned) {
		this.assigned = assigned;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	// public Register_VO(HttpServletRequest request) {
	//
	// this.cust_comp_id =
	// Integer.parseInt(request.getParameter("cust_company_name"));
	// this.cust_id = Integer.parseInt(request.getParameter("cust_name"));
	// this.item_id = Integer.parseInt(request.getParameter("item_name"));
	// this.defect = Integer.parseInt(request.getParameter("defect"));
	// this.category = Integer.parseInt(request.getParameter("category"));
	// this.received = request.getParameter("received");
	// this.related = Integer.parseInt(request.getParameter("related"));
	// this.discription = request.getParameter("discription");
	// this.assigned= Integer.parseInt(request.getParameter("assigned"));
	// this.severity=Integer.parseInt(request.getParameter("severity"));
	// }

}
