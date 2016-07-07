package com.muthagroup.controller;

import java.io.IOException;
import java.text.DateFormatSymbols;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_MonthlyReceipt_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company="",year="",month="";
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
					response.sendRedirect("Monthly_Receipt.jsp?comp="+company+"&month="+month+"&monthname="+monthName);
				}
				if(company.equalsIgnoreCase("102")){ 
					response.sendRedirect("Monthly_Receipt.jsp?comp="+company+"&month="+month+"&monthname="+monthName);
				}
			}			
			//	Example	:	exec "H25FMSHOP"."dbo"."Sel_RptMonthlyProd";1 '102', '201411', 'H25ERP'			
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}

}
