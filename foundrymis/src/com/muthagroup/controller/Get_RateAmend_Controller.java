package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_RateAmend_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company = "";
			company = request.getParameter("company");
			// *************************************************************************************************************
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			Date convertedfromDate = formatter.parse(request.getParameter("fromdate"));
			String fromDate = formatter.format(convertedfromDate);
			Date convertedtoDate = formatter.parse(request.getParameter("todate"));
			String toDate = formatter.format(convertedtoDate);
			// *************************************************************************************************************

			String from = fromDate.replaceAll("[-+.^:,]", "");
			String to = toDate.replaceAll("[-+.^:,]", "");
			
			// *************************************************************************************************************
			// *************************************************************************************************************
			  
			if (company != "" && from != "" && to != "") { 
					response.sendRedirect("Rate_amend_Summary.jsp?comp="+ company + "&from=" + from + "&to=" + to); 
			}
			// Example : exec "ENGERP"."dbo"."Sel_SaleRegisterForAudit";1 '101', '0', '20140401', '20150329', '11525,11510,11515', '0'
			
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}
}
