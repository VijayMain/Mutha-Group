package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Login_bo_Dvp;
import com.muthagroup.vo.Login_VO_Dvp;

/**
 * Servlet implementation class Login_Controller_Dvp
 */
public class Login_Controller_Dvp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	boolean flag=true;
	
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
				doPost(request, response);
		}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String uname=request.getParameter("uname");
		String pwd=request.getParameter("password");
		
		Login_VO_Dvp vo=new Login_VO_Dvp();
		
		vo.setUname(uname);
		vo.setPwd(pwd);
		
		Login_bo_Dvp bo =new Login_bo_Dvp();
		bo.checkLogin(request,response,vo);
		
		
		
	}

}
