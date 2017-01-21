package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Timestamp;
//============================================================================-->
//========================= Virtual Object ===================================-->
//============================================================================-->
public class Action_Customer_VO {
	InputStream file_blob;
	int srNo;
	String file_Name_ext = "";
	int actionId = 0;
	String Prop_output = "";
	String mytext = "", Action_disc = "", pdate = "", adate = "",
			Actual_Output = "", TestActualop = "", mytextAct = "";
	int Action_No = 0;
	Timestamp proposed_date = null, actual_impl_date = null, crrDate = null,
			actaul_ImplDate_Act = null;

	public String getMytextAct() {
		return mytextAct;
	}

	public void setMytextAct(String mytextAct) {
		this.mytextAct = mytextAct;
	}

	public Timestamp getActaul_ImplDate_Act() {
		return actaul_ImplDate_Act;
	}

	public void setActaul_ImplDate_Act(Timestamp actaul_ImplDate_Act) {
		this.actaul_ImplDate_Act = actaul_ImplDate_Act;
	}

	public int getAction_No() {
		return Action_No;
	}

	public void setAction_No(int action_No) {
		Action_No = action_No;
	}

	public String getTestActualop() {
		return TestActualop;
	}

	public void setTestActualop(String testActualop) {
		TestActualop = testActualop;
	}

	public String getActual_Output() {
		return Actual_Output;
	}

	public void setActual_Output(String actual_Output) {
		Actual_Output = actual_Output;
	}

	public String getPdate() {
		return pdate;
	}

	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	public String getAdate() {
		return adate;
	}

	public void setAdate(String adate) {
		this.adate = adate;
	}

	public String getAction_disc() {
		return Action_disc;
	}

	public void setAction_disc(String action_disc) {
		Action_disc = action_disc;
	}

	public Timestamp getProposed_date() {
		return proposed_date;
	}

	public void setProposed_date(Timestamp proposed_date) {
		this.proposed_date = proposed_date;
	}

	public Timestamp getActual_impl_date() {
		return actual_impl_date;
	}

	public void setActual_impl_date(Timestamp actual_impl_date) {
		this.actual_impl_date = actual_impl_date;
	}

	public Timestamp getCrrDate() {
		return crrDate;
	}

	public void setCrrDate(Timestamp crrDate) {
		this.crrDate = crrDate;
	}

	public String getMytext() {
		return mytext;
	}

	public void setMytext(String mytext) {
		this.mytext = mytext;
	}

	public String getProp_output() {
		return Prop_output;
	}

	public void setProp_output(String prop_output) {
		Prop_output = prop_output;
	}

	public int getActionId() {
		return actionId;
	}

	public void setActionId(int actionId) {
		this.actionId = actionId;
	}

	public InputStream getFile_blob() {
		return file_blob;
	}

	public void setFile_blob(InputStream file_blob) {
		this.file_blob = file_blob;
	}

	public int getSrNo() {
		return srNo;
	}

	public void setSrNo(int srNo) {
		this.srNo = srNo;
	}

	public String getFile_Name_ext() {
		return file_Name_ext;
	}

	public void setFile_Name_ext(String file_Name_ext) {
		this.file_Name_ext = file_Name_ext;
	}
}
