package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_DetailedMIS_Summary_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company="",grade=""; 
			company = request.getParameter("company");		
			grade = request.getParameter("misGrade");		
			//*************************************************************************************************************
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Date convertedfromDate = formatter.parse(request.getParameter("DetailedFromDate_MIS"));  
			String fromDate=formatter.format(convertedfromDate); 
			
			Date convertedtoDate = formatter.parse(request.getParameter("DetailedToDate_MIS"));  
			String toDate=formatter.format(convertedtoDate); 
			//*************************************************************************************************************
			
			String fromDateMIS = fromDate.replaceAll("[-+.^:,]","");	
			String toDateMIS = toDate.replaceAll("[-+.^:,]","");
			
			if(company!="" && fromDateMIS!="" && toDateMIS!="" && !grade.equalsIgnoreCase("all")){ 
			response.sendRedirect("Prod_Vs_RejReport.jsp?comp="+company+"&fromdate="+fromDateMIS+"&todate="+toDateMIS+"&grade="+grade);
			}else {
				response.sendRedirect("Prod_Vs_RejReportAll.jsp?comp="+company+"&fromdate="+fromDateMIS+"&todate="+toDateMIS+"&grade="+grade);
			}
			   
		/*	
			if(company!="" && fromDateMIS!="" && toDateMIS!=""){
				if(company.equalsIgnoreCase("103")){
					database = "FOUNDRYERP";
					response.sendRedirect("MIS_Details_GradeWise_FND.jsp?comp="+company+"&fromdate="+fromDateMIS+"&todate="+toDateMIS+"&db="+database+"&grade="+grade);
				}
				if(company.equalsIgnoreCase("105")){
					database = "DIERP";
					response.sendRedirect("MIS_Details_GradeWise_DI.jsp?comp="+company+"&fromdate="+fromDateMIS+"&todate="+toDateMIS+"&db="+database+"&grade="+grade);
				}
				if(company.equalsIgnoreCase("106")){
					database = "K1ERP";
					response.sendRedirect("MIS_Details_GradeWise_K1.jsp?comp="+company+"&fromdate="+fromDateMIS+"&todate="+toDateMIS+"&db="+database+"&grade="+grade);
				}							
			}			
			*/
// 	Example	:	exec "K1FMSHOP"."dbo"."Sel_RptProdAndRej";1 '106', '652', '101102103', '20141001', '20141010', 'K1ERP', 'K1FMSHOP'
//				exec "DIFMSHOP"."dbo"."Sel_RptProdAndRej";1 '105', '652', '101102103104', '20141001', '20141010', 'DIERP', 'DIFMSHOP'
//				exec "FOUNDRYFMSHOP"."dbo"."Sel_RptProdAndRej";1 '103', '652', '101102103', '20141001', '20141010', 'FOUNDRYERP', 'FOUNDRYFMSHOP' 
			
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}

}
