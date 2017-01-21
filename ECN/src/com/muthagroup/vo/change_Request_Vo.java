package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
//============================================================================-->
//========================= Virtual Object ===================================-->
//============================================================================-->
public class change_Request_Vo {

	int Company_Id = 0, Item_Id = 0, crno = 0, srno = 0;
	String Present_System = null, Proposed_System = null, Objective = null,
			Complaint_No = null, quality = null, cost = null, delivery = null,
			material = null, safety = null, approved = null,
			Dimensional = null, approvers = null, file_Name = null;

	Timestamp Proposed_Impl_Date = null, Actual_Impl_Date = null,
			CR_Date = null;

	InputStream file_blob;

//	public change_Request_Vo(HttpServletRequest request) {
//		this.crno = Integer.parseInt(request.getParameter("crno"));
//		this.Company_Id = Integer.parseInt(request.getParameter("supplier"));
//		this.Item_Id = Integer.parseInt(request.getParameter("item_name"));
//		this.cost = request.getParameter("cost");
//		this.delivery = request.getParameter("delivery");
//		this.material = request.getParameter("material");
//		this.quality = request.getParameter("quality");
//		this.safety = request.getParameter("safety");
//		this.Present_System = request.getParameter("Present");
//		this.Proposed_System = request.getParameter("Proposed");
//		this.Objective = request.getParameter("Objective");
//
//		this.Complaint_No = request.getParameter("complaintno");
//
//		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
//
//		try {
//
//			this.Proposed_Impl_Date = new java.sql.Timestamp(formatter.parse(
//					request.getParameter("proposeddate")).getTime());
//			if (request.getParameter("actualimpldate") == "") {
//				System.out.println("Actual Impl Date = "
//						+ request.getParameter("actualimpldate"));
//				this.Actual_Impl_Date = new java.sql.Timestamp(formatter.parse(
//						"0000-00-00 00:00:00").getTime());
//			} else {
//				System.out.println("Actual Impl Date = "
//						+ request.getParameter("actualimpldate"));
//				this.Actual_Impl_Date = new java.sql.Timestamp(formatter.parse(
//						request.getParameter("actualimpldate")).getTime());
//			}
//
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//	}

	public InputStream getFile_blob() {
		return file_blob;
	}

	public void setFile_blob(InputStream file_blob) {
		this.file_blob = file_blob;
	}

	public String getFile_Name() {
		return file_Name;
	}

	public void setFile_Name(String file_Name) {
		this.file_Name = file_Name;
	}

	public String getApprovers() {
		return approvers;
	}

	public void setApprovers(String approvers) {
		this.approvers = approvers;
	}

	public Timestamp getProposed_Impl_Date() {
		return Proposed_Impl_Date;
	}

	public void setProposed_Impl_Date(Timestamp proposed_Impl_Date) {
		Proposed_Impl_Date = proposed_Impl_Date;
	}

	public Timestamp getActual_Impl_Date() {
		return Actual_Impl_Date;
	}

	public int getSrno() {
		return srno;
	}

	public void setSrno(int srno) {
		this.srno = srno;
	}

	public void setActual_Impl_Date(Timestamp actual_Impl_Date) {
		Actual_Impl_Date = actual_Impl_Date;
	}

	public Timestamp getCR_Date() {
		return CR_Date;
	}

	public String getDimensional() {
		return Dimensional;
	}

	public void setDimensional(String dimensional) {
		Dimensional = dimensional;
	}

	public void setCR_Date(Timestamp cR_Date) {
		CR_Date = cR_Date;
	}

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	public change_Request_Vo() {
		// TODO Auto-generated constructor stub
	}

	public int getCrno() {
		return crno;
	}

	public void setCrno(int crno) {
		this.crno = crno;
	}

	public String getQuality() {
		return quality;
	}

	public void setQuality(String quality) {
		this.quality = quality;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getDelivery() {
		return delivery;
	}

	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}

	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	public String getSafety() {
		return safety;
	}

	public void setSafety(String safety) {
		this.safety = safety;
	}

	public int getCompany_Id() {
		return Company_Id;
	}

	public void setCompany_Id(int company_Id) {
		Company_Id = company_Id;
	}

	public int getItem_Id() {
		return Item_Id;
	}

	public void setItem_Id(int item_Id) {
		Item_Id = item_Id;
	}

	public String getPresent_System() {
		return Present_System;
	}

	public void setPresent_System(String present_System) {
		Present_System = present_System;
	}

	public String getProposed_System() {
		return Proposed_System;
	}

	public void setProposed_System(String proposed_System) {
		Proposed_System = proposed_System;
	}

	public String getObjective() {
		return Objective;
	}

	public void setObjective(String objective) {
		Objective = objective;
	}

	public String getComplaint_No() {
		return Complaint_No;
	}

	public void setComplaint_No(String complaint_No) {
		Complaint_No = complaint_No;
	}

}
