package com.muthagroup.controller;

import java.io.IOException;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MRMOperation_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company="",year="",month="",database ="";
			int mm = 0;
			mm = Integer.parseInt(request.getParameter("month"));
			company = request.getParameter("company");			
			year = request.getParameter("year");
			
			if(mm<=9){
				month = year+"0"+request.getParameter("month");
			}else {
				month=year+request.getParameter("month");
			}
			 
			//*************************************************************************************************************
			String monthName = "";
	        DateFormatSymbols dfs = new DateFormatSymbols();
	        String[] months = dfs.getMonths(); 
	        	monthName = months[mm-1]; 
	        monthName = monthName + year ;	
	        	System.out.println("Month Name = " + monthName);
			//*************************************************************************************************************
			
			
			
			 
			if(company!="" && month !="" && year!=""){
				if(company.equalsIgnoreCase("103")){
					database = "FOUNDRYERP";
					response.sendRedirect("MRM_Operations.jsp?comp="+company+"&month="+month+"&db="+database+"&monthname="+monthName);
				}
				if(company.equalsIgnoreCase("105")){
					database = "DIERP";
					response.sendRedirect("MRM_Operations.jsp?comp="+company+"&month="+month+"&db="+database+"&monthname="+monthName);
				}
				if(company.equalsIgnoreCase("106")){
					database = "K1ERP";
					response.sendRedirect("MRM_Operations.jsp?comp="+company+"&month="+month+"&db="+database+"&monthname="+monthName);
				}
				
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}