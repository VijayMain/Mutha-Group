package com.muthagroup.controller;

import java.io.IOException; 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Login_dao;

public class Login_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {    
			System.out.println("inside loop");
			String name = request.getParameter("u_name"); 
			String Password = request.getParameter("u_pwd");  
			HttpSession session = request.getSession();
			Login_dao dao = new Login_dao();
			dao.check_Login(name,Password,session,response); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
