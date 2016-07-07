package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_CatWiseOut_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company=""; 
			company = request.getParameter("company");						 
			//*************************************************************************************************************
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Date convertedOnDate = formatter.parse(request.getParameter("onDate_ots"));  
			String onDate=formatter.format(convertedOnDate);   
			//*************************************************************************************************************
			
			String OnDateMIS = onDate.replaceAll("[-+.^:,]","");	 
			  
			if(company!="" && OnDateMIS!=""){
				if(company.equalsIgnoreCase("103")){ 
					response.sendRedirect("Categorywise_Outstanding.jsp?comp="+company+"&ondate="+OnDateMIS);
				}
				if(company.equalsIgnoreCase("105")){ 
					response.sendRedirect("Categorywise_Outstanding.jsp?comp="+company+"&ondate="+OnDateMIS);
				}
				if(company.equalsIgnoreCase("106")){
					response.sendRedirect("Categorywise_Outstanding.jsp?comp="+company+"&ondate="+OnDateMIS);
				}
				if(company.equalsIgnoreCase("101")){
					response.sendRedirect("Categorywise_Outstanding.jsp?comp="+company+"&ondate="+OnDateMIS);
				}
				if(company.equalsIgnoreCase("102")){
					response.sendRedirect("Categorywise_Outstanding.jsp?comp="+company+"&ondate="+OnDateMIS);
				}
				if(company.equalsIgnoreCase("111")){
					response.sendRedirect("Categorywise_Outstanding.jsp?comp="+company+"&ondate="+OnDateMIS);
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
