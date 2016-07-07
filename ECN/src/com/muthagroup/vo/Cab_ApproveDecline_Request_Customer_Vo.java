package com.muthagroup.vo;

import javax.servlet.http.HttpServletRequest;
//============================================================================-->
//========================= Virtual Object ===================================-->
//============================================================================-->
public class Cab_ApproveDecline_Request_Customer_Vo {

	public Cab_ApproveDecline_Request_Customer_Vo(HttpServletRequest request) {
		// TODO Auto-generated constructor stub
	}
	
	int approval_type = 0;
	String remark = null;
	int uid = 0;
	int cr_no = 0;
	int cr_status_id = 0;

	public int getApproval_type() {
		return approval_type;
	}

	public void setApproval_type(int approval_type) {
		this.approval_type = approval_type;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public int getCr_no() {
		return cr_no;
	}

	public void setCr_no(int cr_no) {
		this.cr_no = cr_no;
	}

	public int getCr_status_id() {
		return cr_status_id;
	}

	public void setCr_status_id(int cr_status_id) {
		this.cr_status_id = cr_status_id;
	}


}
