package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Timestamp;
//============================================================================-->
//========================= Virtual Object ===================================-->
//============================================================================-->
public class Customer_Request_VO {

	Timestamp CRC_Date = null, Existing_Change_level_Date = null,
			New_Change_level_Date = null, Targated_Impl_Date = null,
			Actual_Impl_Date = null;
	int Company_Id = 0, Cust_Id = 0, Item_Id = 0, U_Id = 0, Mail_Status = 0,
			srno = 0, crcno = 0;
	String Change_For = "", Existing_Change_level = "", New_Change_level = "",
			Nature_Of_Change = "", Reason_For_Change = "", file_Name = "",
			Change_Level = "", PPAP = "", remark = "";
	Double Existing_WIP_Stock = 0.0, Existing_As_Cast_Stock = 0.0,
			Tooling_Old = 0.0, Tooling_New = 0.0, Fixture_Old = 0.0,
			Fixture_New = 0.0, Gauges_Old = 0.0, Gauges_New = 0.0,
			Total_Stock = 0.0;
	InputStream file_blob;

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Double getExisting_WIP_Stock() {
		return Existing_WIP_Stock;
	}

	public void setExisting_WIP_Stock(Double existing_WIP_Stock) {
		Existing_WIP_Stock = existing_WIP_Stock;
	}

	public Double getExisting_As_Cast_Stock() {
		return Existing_As_Cast_Stock;
	}

	public void setExisting_As_Cast_Stock(Double existing_As_Cast_Stock) {
		Existing_As_Cast_Stock = existing_As_Cast_Stock;
	}

	public Double getTotal_Stock() {
		return Total_Stock;
	}

	public void setTotal_Stock(Double total_Stock) {
		Total_Stock = total_Stock;
	}

	public String getChange_Level() {
		return Change_Level;
	}

	public void setChange_Level(String change_Level) {
		Change_Level = change_Level;
	}

	public String getFile_Name() {
		return file_Name;
	}

	public void setFile_Name(String file_Name) {
		this.file_Name = file_Name;
	}

	public InputStream getFile_blob() {
		return file_blob;
	}

	public void setFile_blob(InputStream file_blob) {
		this.file_blob = file_blob;
	}

	public int getSrno() {
		return srno;
	}

	public void setSrno(int srno) {
		this.srno = srno;
	}

	public int getCrcno() {
		return crcno;
	}

	public void setCrcno(int crcno) {
		this.crcno = crcno;
	}

	public Timestamp getCRC_Date() {
		return CRC_Date;
	}

	public void setCRC_Date(Timestamp cRC_Date) {
		CRC_Date = cRC_Date;
	}

	public Timestamp getExisting_Change_level_Date() {
		return Existing_Change_level_Date;
	}

	public void setExisting_Change_level_Date(
			Timestamp existing_Change_level_Date) {
		Existing_Change_level_Date = existing_Change_level_Date;
	}

	public Timestamp getNew_Change_level_Date() {
		return New_Change_level_Date;
	}

	public void setNew_Change_level_Date(Timestamp new_Change_level_Date) {
		New_Change_level_Date = new_Change_level_Date;
	}

	public Timestamp getTargated_Impl_Date() {
		return Targated_Impl_Date;
	}

	public void setTargated_Impl_Date(Timestamp targated_Impl_Date) {
		Targated_Impl_Date = targated_Impl_Date;
	}

	public Timestamp getActual_Impl_Date() {
		return Actual_Impl_Date;
	}

	public void setActual_Impl_Date(Timestamp actual_Impl_Date) {
		Actual_Impl_Date = actual_Impl_Date;
	}

	public int getCompany_Id() {
		return Company_Id;
	}

	public void setCompany_Id(int company_Id) {
		Company_Id = company_Id;
	}

	public int getCust_Id() {
		return Cust_Id;
	}

	public void setCust_Id(int cust_Id) {
		Cust_Id = cust_Id;
	}

	public int getItem_Id() {
		return Item_Id;
	}

	public void setItem_Id(int item_Id) {
		Item_Id = item_Id;
	}

	public Double getTooling_Old() {
		return Tooling_Old;
	}

	public void setTooling_Old(Double tooling_Old) {
		Tooling_Old = tooling_Old;
	}

	public Double getTooling_New() {
		return Tooling_New;
	}

	public void setTooling_New(Double tooling_New) {
		Tooling_New = tooling_New;
	}

	public Double getFixture_Old() {
		return Fixture_Old;
	}

	public void setFixture_Old(Double fixture_Old) {
		Fixture_Old = fixture_Old;
	}

	public Double getFixture_New() {
		return Fixture_New;
	}

	public void setFixture_New(Double fixture_New) {
		Fixture_New = fixture_New;
	}

	public Double getGauges_Old() {
		return Gauges_Old;
	}

	public void setGauges_Old(Double gauges_Old) {
		Gauges_Old = gauges_Old;
	}

	public Double getGauges_New() {
		return Gauges_New;
	}

	public void setGauges_New(Double gauges_New) {
		Gauges_New = gauges_New;
	}

	public String getPPAP() {
		return PPAP;
	}

	public void setPPAP(String pPAP) {
		PPAP = pPAP;
	}

	public int getU_Id() {
		return U_Id;
	}

	public void setU_Id(int u_Id) {
		U_Id = u_Id;
	}

	public int getMail_Status() {
		return Mail_Status;
	}

	public void setMail_Status(int mail_Status) {
		Mail_Status = mail_Status;
	}

	public String getChange_For() {
		return Change_For;
	}

	public void setChange_For(String change_For) {
		Change_For = change_For;
	}

	public String getExisting_Change_level() {
		return Existing_Change_level;
	}

	public void setExisting_Change_level(String existing_Change_level) {
		Existing_Change_level = existing_Change_level;
	}

	public String getNew_Change_level() {
		return New_Change_level;
	}

	public void setNew_Change_level(String new_Change_level) {
		New_Change_level = new_Change_level;
	}

	public String getNature_Of_Change() {
		return Nature_Of_Change;
	}

	public void setNature_Of_Change(String nature_Of_Change) {
		Nature_Of_Change = nature_Of_Change;
	}

	public String getReason_For_Change() {
		return Reason_For_Change;
	}

	public void setReason_For_Change(String reason_For_Change) {
		Reason_For_Change = reason_For_Change;
	}

}
