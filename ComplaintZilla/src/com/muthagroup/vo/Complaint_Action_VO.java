package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Timestamp;

public class Complaint_Action_VO {

	String Action_Type = null;
	int status = 0, srNo = 0, uid = 0,phase_id=0;
	private String company_name = null, cust_name = null, item_name = null,
			description = null, defect = null, days = null, hours = null,
			action_description = null, complaint_no = null;
	String file_Name = null;
	Timestamp date_action = null;
	Timestamp date_register = null;
	InputStream file = null;

	public int getPhase_id() {
		return phase_id;
	}

	public void setPhase_id(int phase_id) {
		this.phase_id = phase_id;
	}

	public Timestamp getDate_register() {
		return date_register;
	}

	public void setDate_register(Timestamp date_register) {
		this.date_register = date_register;
	}

	public Timestamp getDate_action() {
		return date_action;
	}

	public void setDate_action(Timestamp date_action) {
		this.date_action = date_action;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getComplaint_no() {
		return complaint_no;
	}

	public void setComplaint_no(String complaint_no) {
		this.complaint_no = complaint_no;
	}

	public String getFile_Name() {
		return file_Name;
	}

	public void setFile_Name(String file_Name) {
		this.file_Name = file_Name;
	}

	public InputStream getFile() {
		return file;
	}

	public void setFile(InputStream file) {
		this.file = file;
	}

	public int getSrNo() {
		return srNo;
	}

	public void setSrNo(int srNo) {
		this.srNo = srNo;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getAction_Type() {
		return Action_Type;
	}

	public void setAction_Type(String action_Type) {
		Action_Type = action_Type;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getCust_name() {
		return cust_name;
	}

	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}

	// public String getCust_unit() {
	// return cust_unit;
	// }
	//
	// public void setCust_unit(String cust_unit) {
	// this.cust_unit = cust_unit;
	// }

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDefect() {
		return defect;
	}

	public void setDefect(String defect) {
		this.defect = defect;
	}

	public String getDays() {
		return days;
	}

	public void setDays(String days) {
		this.days = days;
	}

	public String getHours() {
		return hours;
	}

	public void setHours(String hours) {
		this.hours = hours;
	}

	public String getAction_description() {
		return action_description;
	}

	public void setAction_description(String action_description) {
		this.action_description = action_description;
	}

}
