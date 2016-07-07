package com.muthagroup.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.muthagroup.bo.Search_bo;
import com.muthagroup.vo.Search_vo;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class Search_Controller extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int basic_id=0;
		int cust_id=0;
		int partName_id=0;
		int partNo_id=0;
		
		Date date_To=null;
		Date date_From=null;

		if(request.getParameter("sheetNo")!="")
		{
			basic_id=Integer.parseInt(request.getParameter("sheetNo"));
			System.out.println("basic_id"+basic_id);
		}
		if(request.getParameter("customer")!=null)
		{
			cust_id=Integer.parseInt(request.getParameter("customer"));
			System.out.println("customer... "+cust_id);
		}
		if(request.getParameter("part_name")!=null)
		{
			partName_id=Integer.parseInt(request.getParameter("part_name"));
			System.out.println("Part name id="+partName_id);
		}
		if(request.getParameter("part_no")!=null)
		{
			partNo_id=Integer.parseInt(request.getParameter("part_no"));
			System.out.println("Part no id="+partNo_id);
		}
	
		
		if(request.getParameter("date_To")!=null)
		{
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date convertedDate = null;

			try 
			{
				convertedDate = formatter.parse(request.getParameter("date_To"));
			} catch (ParseException e)
			{
				e.printStackTrace();
			}

			date_To = new java.sql.Date(convertedDate.getTime());

			System.out.println("from jsp selected End Date::::"+ date_To);

		}
		 
		if(request.getParameter("date_From")!=null)
		{
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date convertedDate = null;

			try 
			{
				convertedDate = formatter.parse(request.getParameter("date_From"));
			} catch (ParseException e) 
			{
				e.printStackTrace();
			}

			date_From = new java.sql.Date(convertedDate.getTime());

			System.out.println("from jsp selected date_From::::"+ date_From);
		}
		
		Search_vo vo=new Search_vo();
		
		vo.setBasic_id(basic_id);
		vo.setCust_id(cust_id);
		vo.setDate_From(date_From);
		vo.setDate_To(date_To);
		vo.setPartName_id(partName_id);
		vo.setPartNo_id(partNo_id);
		
		Search_bo bo=new Search_bo();
		
		ArrayList<Integer> Basic_ids=new ArrayList<Integer>();
		
		Basic_ids.addAll(bo.Search_Sheet(vo,request));
		System.out.println("Checkpoint "+ Basic_ids);
		if(Basic_ids.size()==0)
		{
			RequestDispatcher rd = request.getRequestDispatcher("/Search_Result.jsp");
			request.setAttribute("basic_id", Basic_ids);
			rd.forward(request, response);
		}
		else if(Basic_ids.size()>0)
		{
			RequestDispatcher rd = request.getRequestDispatcher("/Search_Result.jsp");
			request.setAttribute("basic_id", Basic_ids);
			rd.forward(request, response);
			//response.sendRedirect("Search_Result.jsp?basic_id="+Basic_ids);
		}
		else
		{
			System.out.println("No Record found...");
		}
	}

}
