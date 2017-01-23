package com.muthagroup.vo;

import java.sql.Date;

public class Edit_PPAPTrials_vo {

	String mc_allocation=null;
	String feedback=null;
	String feedback_details=null;
	
	Date ppap_date=null;
	Date handover_toprod_date=null;
	
	int ppap_id=0;
	int basic_id=0;
	int ppapbatch_lot=0;
	
	
	
	public int getPpap_id() {
		return ppap_id;
	}
	public void setPpap_id(int ppap_id) {
		this.ppap_id = ppap_id;
	}
	public String getMc_allocation() {
		return mc_allocation;
	}
	public void setMc_allocation(String mc_allocation) {
		this.mc_allocation = mc_allocation;
	}
	public String getFeedback() {
		return feedback;
	}
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}
	public String getFeedback_details() {
		return feedback_details;
	}
	public void setFeedback_details(String feedback_details) {
		this.feedback_details = feedback_details;
	}
	public Date getPpap_date() {
		return ppap_date;
	}
	public void setPpap_date(Date ppap_date) {
		this.ppap_date = ppap_date;
	}
	public Date getHandover_toprod_date() {
		return handover_toprod_date;
	}
	public void setHandover_toprod_date(Date handover_toprod_date) {
		this.handover_toprod_date = handover_toprod_date;
	}
	public int getBasic_id() {
		return basic_id;
	}
	public void setBasic_id(int basic_id) {
		this.basic_id = basic_id;
	}
	public int getPpapbatch_lot() {
		return ppapbatch_lot;
	}
	public void setPpapbatch_lot(int ppapbatch_lot) {
		this.ppapbatch_lot = ppapbatch_lot;
	}
	
	
	
	
}
