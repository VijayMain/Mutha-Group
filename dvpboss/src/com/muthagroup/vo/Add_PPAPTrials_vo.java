package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.Date;

public class Add_PPAPTrials_vo {

	String pr_sheet, final_ppap, apqp;
	Double mc_allocation = null;
	String feedback = null;
	String feedback_details = null;

	Date ppap_date = null;
	Date handover_toprod_date = null;

	int basic_id = 0, docId = 0;
	int ppapbatch_lot = 0;
	int preppap_Id = 0, preppap_AttachId = 0;

	String attch_file_name;
	InputStream attachment = null;

	public int getDocId() {
		return docId;
	}

	public void setDocId(int docId) {
		this.docId = docId;
	}

	public String getPr_sheet() {
		return pr_sheet;
	}

	public void setPr_sheet(String pr_sheet) {
		this.pr_sheet = pr_sheet;
	}

	public String getFinal_ppap() {
		return final_ppap;
	}

	public void setFinal_ppap(String final_ppap) {
		this.final_ppap = final_ppap;
	}

	public String getApqp() {
		return apqp;
	}

	public void setApqp(String apqp) {
		this.apqp = apqp;
	}

	public int getPreppap_AttachId() {
		return preppap_AttachId;
	}

	public void setPreppap_AttachId(int preppap_AttachId) {
		this.preppap_AttachId = preppap_AttachId;
	}

	public int getPreppap_Id() {
		return preppap_Id;
	}

	public void setPreppap_Id(int preppap_Id) {
		this.preppap_Id = preppap_Id;
	}

	public String getAttch_file_name() {
		return attch_file_name;
	}

	public void setAttch_file_name(String attch_file_name) {
		this.attch_file_name = attch_file_name;
	}

	public InputStream getAttachment() {
		return attachment;
	}

	public void setAttachment(InputStream attachment) {
		this.attachment = attachment;
	}

	public Double getMc_allocation() {
		return mc_allocation;
	}

	public void setMc_allocation(Double mc_allocation) {
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
