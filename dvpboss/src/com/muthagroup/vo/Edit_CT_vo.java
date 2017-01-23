package com.muthagroup.vo;

import java.sql.Date;

public class Edit_CT_vo {
	
	String cutting_tool=null;
	String tool_pono=null;
	String new_cuttingtool=null;
	
	int tool_qty=0;
	
	int ctd_id=0;
	int availtoolqty=0;
	
	Date po_date=null;
	Date target_tool_date=null;
	Date tool_recpt_date=null;
	
	
	
	public int getAvailtoolqty() {
		return availtoolqty;
	}
	public void setAvailtoolqty(int availtoolqty) {
		this.availtoolqty = availtoolqty;
	}
	public int getCtd_id() {
		return ctd_id;
	}
	public void setCtd_id(int ctd_id) {
		this.ctd_id = ctd_id;
	}
	public String getNew_cuttingtool() {
		return new_cuttingtool;
	}
	public void setNew_cuttingtool(String new_cuttingtool) {
		this.new_cuttingtool = new_cuttingtool;
	}
	public String getCutting_tool() {
		return cutting_tool;
	}
	public void setCutting_tool(String cutting_tool) {
		this.cutting_tool = cutting_tool;
	}
	public String getTool_pono() {
		return tool_pono;
	}
	public void setTool_pono(String tool_pono) {
		this.tool_pono = tool_pono;
	}
	public int getTool_qty() {
		return tool_qty;
	}
	public void setTool_qty(int tool_qty) {
		this.tool_qty = tool_qty;
	}
	
	public Date getPo_date() {
		return po_date;
	}
	public void setPo_date(Date po_date) {
		this.po_date = po_date;
	}
	public Date getTarget_tool_date() {
		return target_tool_date;
	}
	public void setTarget_tool_date(Date target_tool_date) {
		this.target_tool_date = target_tool_date;
	}
	public Date getTool_recpt_date() {
		return tool_recpt_date;
	}
	public void setTool_recpt_date(Date tool_recpt_date) {
		this.tool_recpt_date = tool_recpt_date;
	}

}
