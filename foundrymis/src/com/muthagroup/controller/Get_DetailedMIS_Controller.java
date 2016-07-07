package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_DetailedMIS_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company="",database =""; 
			company = request.getParameter("company");						 
			//*************************************************************************************************************
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Date convertedOnDate = formatter.parse(request.getParameter("onDate_MIS"));  
			String onDate=formatter.format(convertedOnDate);   
			//*************************************************************************************************************
			
			String OnDateMIS = onDate.replaceAll("[-+.^:,]","");	 
			  
			if(company!="" && OnDateMIS!=""){
				if(company.equalsIgnoreCase("103")){
					database = "FOUNDRYERP";
					response.sendRedirect("MIS_SummaryDetails_FND.jsp?comp="+company+"&ondate="+OnDateMIS+"&db="+database);
				}
				if(company.equalsIgnoreCase("105")){
					database = "DIERP";
					response.sendRedirect("MIS_SummaryDetails_DI.jsp?comp="+company+"&ondate="+OnDateMIS+"&db="+database);
				}
				if(company.equalsIgnoreCase("106")){
					database = "K1ERP";
					response.sendRedirect("MIS_SummaryDetails_K1.jsp?comp="+company+"&ondate="+OnDateMIS+"&db="+database);
				}
			}
			 
// 	Example	:	exec "K1FMSHOP"."dbo"."Sel_RptMISMonthlySummery";1 '106', '20140705', 'K1ERP'
//				exec "K1FMSHOP"."dbo"."Sel_RptMISMonthlyGradeSummery";1 '106', '20140705', 'K1ERP'
//				exec "K1FMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '106', '20140705', 'K1ERP'
			
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}

}
