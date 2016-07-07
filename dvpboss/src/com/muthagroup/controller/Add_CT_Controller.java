package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Add_CT_bo;
import com.muthagroup.vo.Add_CT_vo;


public class Add_CT_Controller extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String cutting_tool=null;
		String tool_pono=null;
		
		boolean flag=false;
		
		int basic_id=0;
		int tool_qty=0;
		int fd_id=0;
		int rel_id=0;
		int availtoolqty=0;
		
		Date po_date=null;
		Date target_tool_date=null;
		Date tool_recpt_date=null;
		
		cutting_tool=request.getParameter("cuttingtool");
		tool_pono=request.getParameter("toolpono");
		Add_CT_vo vo=new Add_CT_vo();
		
		if(request.getParameter("toolqty")!=null)
		{
			tool_qty=Integer.parseInt(request.getParameter("toolqty"));
		}
		
		if(request.getParameter("availtoolqty")!=null)
		{
			availtoolqty=Integer.parseInt(request.getParameter("availtoolqty"));
		}
		
		if(request.getParameter("rel_id")!=null)
		{
			rel_id=Integer.parseInt(request.getParameter("rel_id"));
		}
		
		if(request.getParameter("fd_id")!=null)
		{
			fd_id=Integer.parseInt(request.getParameter("fd_id"));
		}
		
		
		if(request.getParameter("basic_id")!=null)
		{
			basic_id=Integer.parseInt(request.getParameter("basic_id"));
		}
		
		try
		{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date convertedDate = null;
		
		convertedDate = formatter.parse(request.getParameter("targettooldate"));

		target_tool_date = new java.sql.Date(convertedDate.getTime());
		
		 
		
		if(!request.getParameter("toolrecptdate").equalsIgnoreCase("")){
			convertedDate = formatter.parse(request.getParameter("toolrecptdate")); 
			tool_recpt_date=new java.sql.Date(convertedDate.getTime());
			vo.setTool_recpt_date(tool_recpt_date);
			}else {
				vo.setTool_recpt_date(null); 
			}
		
		
		
		convertedDate=formatter.parse(request.getParameter("podate"));
		
		po_date=new java.sql.Date(convertedDate.getTime());
		
		
		
		vo.setRel_id(rel_id);
		vo.setCutting_tool(cutting_tool);
		vo.setFd_id(fd_id);
		vo.setPo_date(po_date);
		vo.setTarget_tool_date(target_tool_date);
		vo.setTool_pono(tool_pono);
		vo.setAvailtoolqty(availtoolqty);
		vo.setTool_qty(tool_qty);
		
		
		Add_CT_bo bo=new Add_CT_bo();
		
		flag=bo.addCT(vo,request);
		
		if(flag==true)
		{
			response.sendRedirect("Activity_Sheet.jsp?hid="+basic_id);
		}
		else {
			System.out.println("Error at CT controller....");
		}
		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

}
