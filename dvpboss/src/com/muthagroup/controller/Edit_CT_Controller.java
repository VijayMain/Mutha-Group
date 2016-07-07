package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Edit_CT_bo;
import com.muthagroup.vo.Add_CT_vo;
import com.muthagroup.vo.Edit_CT_vo;


public class Edit_CT_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String cutting_tool=null;
		String tool_pono=null;
		String new_cuttingtool=null;
		Edit_CT_vo vo=new Edit_CT_vo();
		boolean flag=false;
		
		int tool_qty=0;
		int basic_id=0;
		int ctd_id=0;
		int availtoolqty=0;
		
		Date po_date=null;
		Date target_tool_date=null;
		Date tool_recpt_date=null;
		
		new_cuttingtool=request.getParameter("new_cuttingtool");
		cutting_tool=request.getParameter("cuttingtool");
		tool_pono=request.getParameter("toolpono");
		
		if(request.getParameter("toolqty")!=null)
		{
			tool_qty=Integer.parseInt(request.getParameter("toolqty"));
		}
		if(request.getParameter("availtoolqty")!=null)
		{
			availtoolqty=Integer.parseInt(request.getParameter("availtoolqty"));
		}
		if(request.getParameter("ctd_id")!=null)
		{
			ctd_id=Integer.parseInt(request.getParameter("ctd_id"));
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
		
		
		
		vo.setAvailtoolqty(availtoolqty);
		vo.setCutting_tool(cutting_tool);
		vo.setCtd_id(ctd_id);
		vo.setPo_date(po_date);
		vo.setTarget_tool_date(target_tool_date);
		vo.setTool_pono(tool_pono);
		vo.setTool_qty(tool_qty);
		
		vo.setNew_cuttingtool(new_cuttingtool);
		
		Edit_CT_bo bo=new Edit_CT_bo();
		
		flag=bo.editCT(vo,request);
		
		if(flag==true)
		{
			response.sendRedirect("Activity_Sheet.jsp?hid="+basic_id);
		}
		else
		{
			System.out.println("Error occured....");
		}
		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
