package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MRMOperation_Entries extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String company = request.getParameter("company");
			String year = request.getParameter("year");
			
			if(company!="" && year!=""){
				if(company.equalsIgnoreCase("103")){ 
					response.sendRedirect("Budget_Entry.jsp?comp="+company+"&year="+year);
				}
				if(company.equalsIgnoreCase("105")){ 
					response.sendRedirect("Budget_Entry.jsp?comp="+company+"&year="+year);
				}
				if(company.equalsIgnoreCase("106")){ 
					response.sendRedirect("Budget_Entry.jsp?comp="+company+"&year="+year);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
}