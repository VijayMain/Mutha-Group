package com.muthagroup.vo;

import java.sql.Date;

public class add_FTD_vo {

	int pat_avail=0;
	int pat_req=0;
	int cb_avail=0;
	int cb_req=0;
	Date receptDate=null;
	int basic_id=0;
	
	
	
	public int getBasic_id() {
		return basic_id;
	}
	public void setBasic_id(int basic_id) {
		this.basic_id = basic_id;
	}
	public int getPat_avail() {
		return pat_avail;
	}
	public void setPat_avail(int pat_avail) {
		this.pat_avail = pat_avail;
	}
	public int getPat_req() {
		return pat_req;
	}
	public void setPat_req(int pat_req) {
		this.pat_req = pat_req;
	}
	public int getCb_avail() {
		return cb_avail;
	}
	public void setCb_avail(int cb_avail) {
		this.cb_avail = cb_avail;
	}
	public int getCb_req() {
		return cb_req;
	}
	public void setCb_req(int cb_req) {
		this.cb_req = cb_req;
	}
	public Date getReceptDate() {
		return receptDate;
	}
	public void setReceptDate(Date receptDate) {
		this.receptDate = receptDate;
	}
	
	
	
	
}
