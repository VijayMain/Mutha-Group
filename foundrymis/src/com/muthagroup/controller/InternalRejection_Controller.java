package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class InternalRejection_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	try {
		// *************************************************************************************************************
					System.out.println("In controller");
					String company=""; 
					company = request.getParameter("company");			 
					
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
					
					Date datefrom = formatter.parse(request.getParameter("FromDate_IntR"));
					Date dateto = formatter.parse(request.getParameter("ToDate_IntR"));
					
					String from= new SimpleDateFormat("yyyyMMdd").format(datefrom); 
					String to= new SimpleDateFormat("yyyyMMdd").format(dateto);
					
					String date_from = from.replaceAll("[-+.^:,]","");			  
					String date_to = to.replaceAll("[-+.^:,]","");
					
					// *************************************************************************************************************
					   
					if(company!=""){
							response.sendRedirect("Internal_Rejection.jsp?comp="+company+"&from="+date_from+"&to="+date_to);
					}
		//		Example :
					/*exec "DIFMSHOP"."dbo"."Sel_RptInternalRejection_MARV";1 '105', '0', '20150701', '20150726', 'DIERP'
					exec "DIFMSHOP"."dbo"."Sel_RptInternalRejectionItemwise";1 '105', '0', '20150701', '20150726', 'DIERP'*/	
	} catch (Exception e) {
		e.printStackTrace();
	}
	}

}
