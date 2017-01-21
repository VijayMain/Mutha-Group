package com.muthagroup.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.bo.Login_BO;
import com.muthagroup.vo.Login_vo;
//============================================================================-->
//============================ Controller  ===================================-->
//============================================================================-->
public class Login_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			boolean flag = false;
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			Login_vo vo = new Login_vo(request);
			Login_BO bo = new Login_BO();

			flag = bo.checkLogin(vo,session,response);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
//============================================================================--> 
//============================================================================-->