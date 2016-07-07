package com.muthagroup.controller;

import java.io.IOException; 
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar; 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

public class SoftwareUsage_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try { 
			int month = Integer.parseInt(request.getParameter("month"));
			int year = Integer.parseInt(request.getParameter("year"));
			
			String[] softNames= request.getParameterValues("selected_users");
			ArrayList<String> soft=new ArrayList<String>();	
			for(int i=0;i<softNames.length; i++)
			{
				soft.add(softNames[i]); 
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");
			month = month-1;
			GregorianCalendar gc = new GregorianCalendar(year, month, 1);
			java.util.Date monthstartDate = new java.util.Date(gc.getTime().getTime());

			Calendar c = Calendar.getInstance();      
			c.set(year,month,1);  
			c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));  
			  
			String fst = sdf.format(monthstartDate.getTime());
			String lst = sdf.format(c.getTime());
			
			String fst_disp = sdf2.format(monthstartDate.getTime());
			String lst_disp = sdf2.format(c.getTime());
 
			RequestDispatcher rd = request.getRequestDispatcher("/SoftwareUsage.jsp");
			request.setAttribute("users", soft);
			request.setAttribute("fst_date", fst);
			request.setAttribute("lst_date", lst);
			request.setAttribute("fst_disp", fst_disp);
			request.setAttribute("lst_disp", lst_disp);
			rd.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
