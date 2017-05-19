package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_PartyWorkOrder_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//*************************************************************************************************************
			// company   sup   date_frompurorder   date_topurorder  			
			String company="", sup="",supName="";
			company = request.getParameter("company");					 
			sup = request.getParameter("sup");
			
			String operationwise = request.getParameter("op");
			
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			Date convertedDatefrom = formatter.parse(request.getParameter("date_fromWorkOrder"));
			Date convertedDateto = formatter.parse(request.getParameter("date_toWorkOrder"));
			
			String fromDate= new SimpleDateFormat("yyyyMMdd").format(convertedDatefrom);
			String toDate= new SimpleDateFormat("yyyyMMdd").format(convertedDateto);
			//*************************************************************************************************************
			//System.out.println(" Company  = " + company +" Sup = "+ sup + "conv from = " + convertedDatefrom + " conv to = " + convertedDateto);
			
			if(company!="" && sup!="" && operationwise==null){
					response.sendRedirect("PartywiseWorkOrder.jsp?comp="+company+"&sup="+sup+"&fromdate="+fromDate+"&todate="+toDate);
			}else{
				System.out.println("Operation wise");
				response.sendRedirect("PartywiseWorkOrder.jsp?comp="+company+"&sup="+sup+"&fromdate="+fromDate+"&todate="+toDate);
			}
//		Example :  exec "ENGERP"."dbo"."Sel_RptPartyWsPurchOrderRegister";1 '101', '0', '4031,4032', '20140401', '20150313', 0, '101120238'
//  	select * from MSTACCTGLSUB where SUB_GLCODE=12
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}
}