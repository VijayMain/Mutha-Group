package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class LoginToMiS_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			   
			String uname=request.getParameter("name");
			String pwd=request.getParameter("pass"); 
			
			MIS_LoginDAO dao =new MIS_LoginDAO();
			dao.checkLogin(request,response,uname,pwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	} 
}
