package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Generate_NewItemERP")
public class Generate_NewItemERP extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String typeName = request.getParameter("matType");
			if(typeName.equalsIgnoreCase("101")){
				response.sendRedirect("Master_NewCasting.jsp");
			}
			if(typeName.equalsIgnoreCase("114")){
				response.sendRedirect("Master_SANDPRODUCT.jsp");
			}
			if(typeName.equalsIgnoreCase("")){
				response.sendRedirect("HomePage.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}