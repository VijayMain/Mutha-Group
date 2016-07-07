package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_VendorBoringReceipt_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//*************************************************************************************************************
			// company   sup   date_from   date_to   
			
			String company="", sup="",supName=""; 
			company = request.getParameter("company");					 
			sup = request.getParameter("sup");   
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Date convertedDatefrom = formatter.parse(request.getParameter("date_from"));
			Date convertedDateto = formatter.parse(request.getParameter("date_to"));
			
			String fromDate= new SimpleDateFormat("yyyyMMdd").format(convertedDatefrom);
			String toDate= new SimpleDateFormat("yyyyMMdd").format(convertedDateto);
			
			//*************************************************************************************************************
			  
			 //System.out.println(" Cust = " + cust+" Date = "+todaysDate);
			if(company!="" && sup!=""){ 
					response.sendRedirect("VendorBoring_Receipt.jsp?comp="+company+"&sup="+sup+"&fromdate="+fromDate+"&todate="+toDate);
			}
//	Example : --- Vendor Boring Receipt 
// exec "ENGERP"."dbo"."Sel_BoringRegister";1 '101', '0', '20140401', '20150223', '103,131'
// select * from MSTACCTGLSUB where SUB_GLCODE=12
		
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}

}
