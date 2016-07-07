package com.muthagroup.vo;

import java.sql.Timestamp;
//============================================================================-->
//========================= Virtual Object ===================================-->
//============================================================================-->
public class Search_Request_Vo {

	int company_name_sup = 0, company_name_item = 0, item_name_item = 0,
			approval_type_app = 0;
	Timestamp start_date_sup = null, end_date_sup = null, start_date_item = null,
			end_date_item = null, start_date_app = null, end_date_app = null;

	public Timestamp getStart_date_sup() {
		return start_date_sup;
	}

	public void setStart_date_sup(Timestamp start_date_sup) {
		this.start_date_sup = start_date_sup;
	}

	public Timestamp getEnd_date_sup() {
		return end_date_sup;
	}

	public void setEnd_date_sup(Timestamp end_date_sup) {
		this.end_date_sup = end_date_sup;
	}

	public Timestamp getStart_date_item() {
		return start_date_item;
	}

	public void setStart_date_item(Timestamp start_date_item) {
		this.start_date_item = start_date_item;
	}

	public Timestamp getEnd_date_item() {
		return end_date_item;
	}

	public void setEnd_date_item(Timestamp end_date_item) {
		this.end_date_item = end_date_item;
	}

	public Timestamp getStart_date_app() {
		return start_date_app;
	}

	public void setStart_date_app(Timestamp start_date_app) {
		this.start_date_app = start_date_app;
	}

	public Timestamp getEnd_date_app() {
		return end_date_app;
	}

	public void setEnd_date_app(Timestamp end_date_app) {
		this.end_date_app = end_date_app;
	}

	public int getCompany_name_sup() {
		return company_name_sup;
	}

	public void setCompany_name_sup(int company_name_sup) {
		this.company_name_sup = company_name_sup;
	}

	public int getCompany_name_item() {
		return company_name_item;
	}

	public void setCompany_name_item(int company_name_item) {
		this.company_name_item = company_name_item;
	}

	public int getItem_name_item() {
		return item_name_item;
	}

	public void setItem_name_item(int item_name_item) {
		this.item_name_item = item_name_item;
	}

	public int getApproval_type_app() {
		return approval_type_app;
	}

	public void setApproval_type_app(int approval_type_app) {
		this.approval_type_app = approval_type_app;
	}

	
}
