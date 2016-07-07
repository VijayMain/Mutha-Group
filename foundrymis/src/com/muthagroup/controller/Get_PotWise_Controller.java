package com.muthagroup.controller;

import java.io.IOException; 
import java.text.SimpleDateFormat;
import java.util.Date; 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Get_PotWise_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company="",database ="";
			String passcode = "652"; 
			company = request.getParameter("company");						 
			//*************************************************************************************************************
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Date convertedDatefrom = formatter.parse(request.getParameter("fromDate")); 
			Date convertedDateto = formatter.parse(request.getParameter("toDate")); 
			String dateFr=formatter.format(convertedDatefrom);  
			String dateTo=formatter.format(convertedDateto);
			//*************************************************************************************************************
			
			String date_from = dateFr.replaceAll("[-+.^:,]","");			  
			String date_to = dateTo.replaceAll("[-+.^:,]","");
			 
			
			if(company!="" && date_from!="" && date_to!=""){
				if(company.equalsIgnoreCase("103")){
					database = "FOUNDRYERP";
					response.sendRedirect("PotwiseReportFND.jsp?comp="+company+"&datefrom="+date_from+"&dateto="+date_to+"&db="+database+"&code="+passcode);
				}
				if(company.equalsIgnoreCase("105")){
					database = "DIERP";
					response.sendRedirect("PotwiseReportDI.jsp?comp="+company+"&datefrom="+date_from+"&dateto="+date_to+"&db="+database+"&code="+passcode);
				}
				if(company.equalsIgnoreCase("106")){
					database = "K1ERP";
					response.sendRedirect("PotwiseReportK1.jsp?comp="+company+"&datefrom="+date_from+"&dateto="+date_to+"&db="+database+"&code="+passcode);
				}							
			}
			 
// Example	:	exec "K1FMSHOP"."dbo"."Sel_RptFurnaceWiseProd";1 '106', '652', '20141001', '20141031'
//  			exec "K1FMSHOP"."dbo"."Sel_RptDailyProducion";1 '106', '123', '20141001', '20141102', 'K1ERP'  
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}
}
