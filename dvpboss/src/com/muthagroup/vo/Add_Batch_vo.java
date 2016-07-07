package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Date;

public class Add_Batch_vo {

	String feedback_Details=null;
	String feddback_RNo=null;
	String attch_file_name=null;
	InputStream trial_attachment=null;
	Date trial_date=null;
	
	int trial_qty=0;
	int basic_id=0;
	
	
	
	
	public String getAttch_file_name() {
		return attch_file_name;
	}
	public void setAttch_file_name(String attch_file_name) {
		this.attch_file_name = attch_file_name;
	}
	public InputStream getTrial_attachment() {
		return trial_attachment;
	}
	public void setTrial_attachment(InputStream trial_attachment) {
		this.trial_attachment = trial_attachment;
	}
	public String getFeedback_Details() {
		return feedback_Details;
	}
	public void setFeedback_Details(String feedback_Details) {
		this.feedback_Details = feedback_Details;
	}
	public Date getTrial_date() {
		return trial_date;
	}
	public void setTrial_date(Date trial_date) {
		this.trial_date = trial_date;
	}
	public int getTrial_qty() {
		return trial_qty;
	}
	public void setTrial_qty(int trial_qty) {
		this.trial_qty = trial_qty;
	}
	public String getFeddback_RNo() {
		return feddback_RNo;
	}
	public void setFeddback_RNo(String feddback_RNo) {
		this.feddback_RNo = feddback_RNo;
	}
	
	public int getBasic_id() {
		return basic_id;
	}
	public void setBasic_id(int basic_id) {
		this.basic_id = basic_id;
	}
	
	
	
	
	
	
}
