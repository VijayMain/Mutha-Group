package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Comp_StatusWise_ReportMKT extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try { 
			 int comp=0,status=0;   
			 String fromDate="", toDate="";
			          
			 comp = Integer.parseInt(request.getParameter("comp"));   
			 status = Integer.parseInt(request.getParameter("status"));
			 fromDate = request.getParameter("fromDate");  
			 toDate = request.getParameter("toDate"); 
			 
			 response.sendRedirect("Report_excelMKT.jsp?comp="+comp+"&status="+status+"&fromDate="+fromDate+"&toDate="+toDate);
			  
		} catch (Exception e) {
			e.printStackTrace();
		}
	} 
}
