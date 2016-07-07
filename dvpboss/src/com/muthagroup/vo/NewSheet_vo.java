package com.muthagroup.vo;

import java.io.InputStream;
import java.sql.*;

public class NewSheet_vo {
	int sheet_no = 0;

	
	
	int project_leader = 0;
	int related_person = 0;
	int schedule_per_month = 0;
	int plant_name = 0;
	int casting_from = 0, srNo = 0;

	String revesion_no = null;
	String cust_name = null;
	String grade_type = null;
	String CV_name=null;
	String PV_name=null;
	
	
	String marketing_apr = null;
	String po_number = null;
	String part_name = null;
	String part_no = null;
	String po_file_name = null;
	String partImage_file_name = null;
	String TwoD_drawing_file_name = null;
	String ThreeD_drawing_file_name = null;
	String file_Name_ext;
	
	Date plan_start_date = null;
	Date plan_end_date = null;
	Date act_start_date = null;
	Date act_end_date = null;
	Date revised_date = null;
	Date po_date = null;
	Date po_received_date = null;

	InputStream po_file_blob = null;
	InputStream partImage_file_blob = null;
	InputStream twoD_drawing = null;
	InputStream threeD_drawing = null;
	InputStream other_file_blob = null;

	public String getCV_name() {
		return CV_name;
	}

	public void setCV_name(String cV_name) {
		CV_name = cV_name;
	}

	public String getPV_name() {
		return PV_name;
	}

	public void setPV_name(String pV_name) {
		PV_name = pV_name;
	}

	public InputStream getOther_file_blob() {
		return other_file_blob;
	}

	public void setOther_file_blob(InputStream other_file_blob) {
		this.other_file_blob = other_file_blob;
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

	public String getTwoD_drawing_file_name() {
		return TwoD_drawing_file_name;
	}

	public void setTwoD_drawing_file_name(String twoD_drawing_file_name) {
		TwoD_drawing_file_name = twoD_drawing_file_name;
	}

	public String getThreeD_drawing_file_name() {
		return ThreeD_drawing_file_name;
	}

	public void setThreeD_drawing_file_name(String threeD_drawing_file_name) {
		ThreeD_drawing_file_name = threeD_drawing_file_name;
	}

	public InputStream getTwoD_drawing() {
		return twoD_drawing;
	}

	public void setTwoD_drawing(InputStream twoD_drawing) {
		this.twoD_drawing = twoD_drawing;
	}

	public InputStream getThreeD_drawing() {
		return threeD_drawing;
	}

	public void setThreeD_drawing(InputStream threeD_drawing) {
		this.threeD_drawing = threeD_drawing;
	}

	public int getPlant_name() {
		return plant_name;
	}

	public void setPlant_name(int plant_name) {
		this.plant_name = plant_name;
	}

	public int getCasting_from() {
		return casting_from;
	}

	public void setCasting_from(int casting_from) {
		this.casting_from = casting_from;
	}

	public String getCust_name() {
		return cust_name;
	}

	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}

	public int getSheet_no() {
		return sheet_no;
	}

	public void setSheet_no(int sheet_no) {
		this.sheet_no = sheet_no;
	}

	

	public String getRevesion_no() {
		return revesion_no;
	}

	public void setRevesion_no(String revesion_no) {
		this.revesion_no = revesion_no;
	}

	public int getProject_leader() {
		return project_leader;
	}

	public void setProject_leader(int project_leader) {
		this.project_leader = project_leader;
	}

	public int getRelated_person() {
		return related_person;
	}

	public void setRelated_person(int related_person) {
		this.related_person = related_person;
	}

	public int getSchedule_per_month() {
		return schedule_per_month;
	}

	public void setSchedule_per_month(int schedule_per_month) {
		this.schedule_per_month = schedule_per_month;
	}

	public String getMarketing_apr() {
		return marketing_apr;
	}

	public void setMarketing_apr(String marketing_apr) {
		this.marketing_apr = marketing_apr;
	}

	
	public String getGrade_type() {
		return grade_type;
	}

	public void setGrade_type(String grade_type) {
		this.grade_type = grade_type;
	}

	public String getPo_number() {
		return po_number;
	}

	public void setPo_number(String po_number) {
		this.po_number = po_number;
	}

	public String getPart_name() {
		return part_name;
	}

	public void setPart_name(String part_name) {
		this.part_name = part_name;
	}

	public String getPart_no() {
		return part_no;
	}

	public void setPart_no(String part_no) {
		this.part_no = part_no;
	}

	public String getPo_file_name() {
		return po_file_name;
	}

	public void setPo_file_name(String po_file_name) {
		this.po_file_name = po_file_name;
	}

	public String getPartImage_file_name() {
		return partImage_file_name;
	}

	public void setPartImage_file_name(String partImage_file_name) {
		this.partImage_file_name = partImage_file_name;
	}

	public Date getPlan_start_date() {
		return plan_start_date;
	}

	public void setPlan_start_date(Date plan_start_date) {
		this.plan_start_date = plan_start_date;
	}

	public Date getPlan_end_date() {
		return plan_end_date;
	}

	public void setPlan_end_date(Date plan_end_date) {
		this.plan_end_date = plan_end_date;
	}

	public Date getAct_start_date() {
		return act_start_date;
	}

	public void setAct_start_date(Date act_start_date) {
		this.act_start_date = act_start_date;
	}

	public Date getAct_end_date() {
		return act_end_date;
	}

	public void setAct_end_date(Date act_end_date) {
		this.act_end_date = act_end_date;
	}

	public Date getRevised_date() {
		return revised_date;
	}

	public void setRevised_date(Date revised_date) {
		this.revised_date = revised_date;
	}

	public Date getPo_date() {
		return po_date;
	}

	public void setPo_date(Date po_date) {
		this.po_date = po_date;
	}

	public Date getPo_received_date() {
		return po_received_date;
	}

	public void setPo_received_date(Date po_received_date) {
		this.po_received_date = po_received_date;
	}

	public InputStream getPo_file_blob() {
		return po_file_blob;
	}

	public void setPo_file_blob(InputStream po_file_blob) {
		this.po_file_blob = po_file_blob;
	}

	public InputStream getPartImage_file_blob() {
		return partImage_file_blob;
	}

	public void setPartImage_file_blob(InputStream partImage_file_blob) {
		this.partImage_file_blob = partImage_file_blob;
	}

}
