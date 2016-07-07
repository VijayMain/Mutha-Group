package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class WorkOdrWSExpected_Boring_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// *************************************************************************************************************
			System.out.println("In controller");
			String company=""; 
			company = request.getParameter("company");			 
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Date datefrom = formatter.parse(request.getParameter("FromDate_Exbr"));
			Date dateto = formatter.parse(request.getParameter("ToDate_Exbr"));
			
			String from= new SimpleDateFormat("yyyyMMdd").format(datefrom); 
			String to= new SimpleDateFormat("yyyyMMdd").format(dateto);
			
			String date_from = from.replaceAll("[-+.^:,]","");			  
			String date_to = to.replaceAll("[-+.^:,]","");
			
			// *************************************************************************************************************
			   
			if(company!=""){
					response.sendRedirect("WO_ws_Expected_Boring.jsp?comp="+company+"&from="+date_from+"&to="+date_to);
			}
			//		Example : exec "FOUNDRYERP"."dbo"."Sel_RptWOWiseBoringDetail";1 '103', '0', '20150301', '20150314'
		
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}

}
