package com.muthagroup.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Get_DaywiseBoring_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String company ="" , month="" , year="";
			
			company = request.getParameter("company");
			month = request.getParameter("month");
			year = request.getParameter("year");			
			
			Calendar cal = new GregorianCalendar(Integer.parseInt(year),Integer.parseInt(month),0);
			Date date = cal.getTime();
			DateFormat sdf = new SimpleDateFormat("yyyyMMdd");			
			String lastdate = sdf.format(date);
			String firstdate = sdf.format(date).substring(0, 6) + "01";			 
			
			String db="";
			if(company.equalsIgnoreCase("101")){
				db="ENGERP";
			}
			if(company.equalsIgnoreCase("102")){
				db="H25ERP";
			}
			response.sendRedirect("Daywise_Boring.jsp?fd="+firstdate+"&ld="+lastdate+"&cp="+company+"&db="+db+"&m="+month+"&y="+year);			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
