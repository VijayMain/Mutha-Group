package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Add_Gauge_bo;
import com.muthagroup.vo.Add_Gauge_vo;

public class Add_Gauge_Controller extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	boolean flag=false;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String gauge_name=null;
		String cust_apr=null;
		
		int gauge_qty=0;
		int basic_id=0;
		int rel_id=0;
		int avail_qty=0;
		
		Date gauge_po_date=null;
		Date gauge_rec_date=null;
		Date gauge_trg_date=null;
		Add_Gauge_vo vo=new Add_Gauge_vo();
		gauge_name=request.getParameter("gauge");
		
		if(request.getParameter("gauge_qty")!=null)
		{
			gauge_qty=Integer.parseInt(request.getParameter("gauge_qty"));
		}
		
		if(request.getParameter("avail_qty")!=null)
		{
			avail_qty=Integer.parseInt(request.getParameter("avail_qty"));
		}
		
		if(request.getParameter("basic_id")!=null)
		{
			basic_id=Integer.parseInt(request.getParameter("basic_id"));
		}
		if(request.getParameter("rel_id")!=null)
		{
			rel_id=Integer.parseInt(request.getParameter("rel_id"));
		}
		
		cust_apr=request.getParameter("cust_aprroval");
		
		try
		{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date convertedDate = null;
		
		convertedDate = formatter.parse(request.getParameter("gaugepodate"));

		gauge_po_date = new java.sql.Date(convertedDate.getTime());
		
		
		
		
		if(!request.getParameter("gaugerecdate").equalsIgnoreCase("")){ 
			convertedDate = formatter.parse(request.getParameter("gaugerecdate"));
			gauge_rec_date = new java.sql.Date(convertedDate.getTime());
			vo.setGauge_rec_date(gauge_rec_date);
			}else {
				vo.setGauge_rec_date(null); 
			}
		
		
		
		
		
		convertedDate = formatter.parse(request.getParameter("gaugetrgdate"));

		gauge_trg_date = new java.sql.Date(convertedDate.getTime());

		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		
		vo.setAvail_qty(avail_qty);
		vo.setBasic_id(basic_id);
		vo.setCust_apr(cust_apr);
		vo.setGauge_name(gauge_name);
		vo.setGauge_po_date(gauge_po_date);
		vo.setGauge_qty(gauge_qty);
		
		vo.setGauge_trg_date(gauge_trg_date);
		vo.setRel_id(rel_id);
		
		Add_Gauge_bo bo=new Add_Gauge_bo();
		
		flag=bo.addGauge(vo,request);
		
		if(flag==true)
		{
			response.sendRedirect("Activity_Sheet.jsp?hid="+basic_id);
		}
		else
		{
			System.out.println("Error occured.. ..");
		}
		
	}

}
