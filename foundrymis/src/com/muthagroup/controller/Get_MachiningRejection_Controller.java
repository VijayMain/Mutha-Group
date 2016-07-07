package com.muthagroup.controller;

import java.io.IOException;
import java.text.DateFormatSymbols;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_MachiningRejection_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company="",year="",month="",db="";
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
	        	
			//*************************************************************************************************************
					 
			if(company!="" && month !="" && year!=""){		
				if(company.equalsIgnoreCase("101")){ 
					db="ENGERP";
					response.sendRedirect("Monthly_MacRejection.jsp?comp="+company+"&month="+month+"&monthname="+monthName+"&db="+db);
				}
				if(company.equalsIgnoreCase("102")){
					db="H25ERP";
					response.sendRedirect("Monthly_MacRejection.jsp?comp="+company+"&month="+month+"&monthname="+monthName+"&db="+db);
				}
			}			
			//	Example	:	exec "ENGFMSHOP"."dbo"."Sel_RptMonthlyDailyMachiningProd";1 '201411', N'ENGERP'			
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}

}
