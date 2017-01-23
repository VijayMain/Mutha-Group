package com.muthagroup.vo;

import java.sql.Date;

public class Add_CT_vo 
{
	String cutting_tool=null;
	String tool_pono=null;
	
	int tool_qty=0;
	int fd_id=0;
	int rel_id=0;
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
	public int getRel_id() {
		return rel_id;
	}
	public void setRel_id(int rel_id) {
		this.rel_id = rel_id;
	}
	public String getCutting_tool() 
	{
		return cutting_tool;
	}
	public void setCutting_tool(String cutting_tool) 
	{
		this.cutting_tool = cutting_tool;
	}
	public String getTool_pono() 
	{
		return tool_pono;
	}
	public void setTool_pono(String tool_pono) 
	{
		this.tool_pono = tool_pono;
	}
	public int getTool_qty() 
	{
		return tool_qty;
	}
	public void setTool_qty(int tool_qty) 
	{
		this.tool_qty = tool_qty;
	}
	public int getFd_id() 
	{
		return fd_id;
	}
	public void setFd_id(int fd_id) 
	{
		this.fd_id = fd_id;
	}
	public Date getPo_date() 
	{
		return po_date;
	}
	public void setPo_date(Date po_date) 
	{
		this.po_date = po_date;
	}
	public Date getTarget_tool_date() 
	{
		return target_tool_date;
	}
	public void setTarget_tool_date(Date target_tool_date) 
	{
		this.target_tool_date = target_tool_date;
	}
	public Date getTool_recpt_date() 
	{
		return tool_recpt_date;
	}
	public void setTool_recpt_date(Date tool_recpt_date) 
	{
		this.tool_recpt_date = tool_recpt_date;
	}
}
