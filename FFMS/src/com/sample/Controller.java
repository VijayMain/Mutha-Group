package com.sample;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 try {
		 String[] softNames= request.getParameterValues("software_selected");
			ArrayList<String> soft=new ArrayList<String>();	
			for(int i=0;i<softNames.length; i++)
			{
				soft.add(softNames[i]);
				System.out.println("selected softwares.. "+softNames[i]);
			}
			System.out.println("selected softwares.. "+soft);
	} catch (Exception e) {
		e.printStackTrace();
	}
	}

}
