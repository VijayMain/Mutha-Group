package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 
import com.muthagroup.dao.Login_Homedao; 
 
public class UserLogin_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {  
			String name = request.getParameter("name"); 
			String Password = request.getParameter("password");  
			HttpSession session = request.getSession();
			Login_Homedao dao = new Login_Homedao();
			dao.check_Login(name,Password,session,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
