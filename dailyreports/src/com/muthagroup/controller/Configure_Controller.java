package com.muthagroup.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.dao.Configure_Dao;

public class Configure_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {		 
			String comp = request.getParameter("company"); 
			int reportid = Integer.parseInt(request.getParameter("report"));
			
			ArrayList accesslist=new ArrayList();
			String[] list = request.getParameterValues("sbTwo");      
		    if (list!=null) {
		       for (int index=0; index<list.length; index++) {    
		    	   accesslist.add(list[index]);
		       }
		    }
		    
		    System.out.println("List Data = " + accesslist);
		    Configure_Dao dao = new Configure_Dao(); 
		    if(reportid!=3){
		    dao.setConfiguration(comp,reportid,accesslist,response);
		    }
		    if(reportid==3){
		    	dao.setConfig_subReport(comp,reportid,accesslist,response,request);	
		    }
		    
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}