package com.muthagroup.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.dao.ConfigureVendor_Dao;
import com.muthagroup.dao.Configure_Dao;
 
public class Configure_Vendor_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String comp = request.getParameter("company");  
			String report = request.getParameter("report");  
			
			ArrayList accesslist=new ArrayList();
			String[] list = request.getParameterValues("sbTwo");      
		    if (list!=null) {
		       for (int index=0; index<list.length; index++) {    
		    	   accesslist.add(list[index]);
		       }
		    }
		    
		    System.out.println("List Data = " + accesslist);
		    ConfigureVendor_Dao dao = new ConfigureVendor_Dao(); 
		    dao.setConfiguration(comp,report,accesslist,response);
		    
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
