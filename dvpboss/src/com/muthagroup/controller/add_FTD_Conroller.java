package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.add_FTD_bo;
import com.muthagroup.vo.add_FTD_vo;


public class add_FTD_Conroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		int pat_avail=0;
		int pat_req=0;
		int cb_avail=0;
		int cb_req=0;
		int basic_id=0;
		//Date receptDate=null;
		
		add_FTD_vo vo=new add_FTD_vo();
		
		if(request.getParameter("basic_id")!=null)
		{
			basic_id=Integer.parseInt(request.getParameter("basic_id"));
		}
		
		if(request.getParameter("pat_avail")!=null)
		{
			pat_avail=Integer.parseInt(request.getParameter("pat_avail"));
			
			
		}
		if(request.getParameter("pat_req")!=null)
		{
			pat_req=Integer.parseInt(request.getParameter("pat_req"));
		}
		if(request.getParameter("cb_avail")!=null)
		{
			cb_avail=Integer.parseInt(request.getParameter("cb_avail"));
		}
		if(request.getParameter("cb_req")!=null)
		{
			cb_req=Integer.parseInt(request.getParameter("cb_req"));
		}
		if (request.getParameter("receptDate")!=null) {
			
			SimpleDateFormat formatter = new SimpleDateFormat(
					"yyyy-MM-dd");
			java.util.Date convertedDate = null;

			try 
			{
				convertedDate = formatter.parse(request.getParameter("receptDate"));
			
			} catch (ParseException e) 
			{
				e.printStackTrace();
			}

			final java.sql.Date receptDate = new java.sql.Date(convertedDate.getTime());
			
			vo.setReceptDate(receptDate);
		}
		
		vo.setBasic_id(basic_id);
		vo.setPat_avail(pat_avail);
		vo.setPat_req(pat_req);
		vo.setCb_avail(cb_avail);
		vo.setCb_req(cb_req);
		
		add_FTD_bo bo=new add_FTD_bo();
		
		bo.addFTD(request,response,vo);
		
	}

}
