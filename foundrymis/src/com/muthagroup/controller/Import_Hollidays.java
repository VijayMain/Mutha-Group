package com.muthagroup.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.ImportHollidays_dao;

public class Import_Hollidays extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String holli_date = request.getParameter("holiday");
			String remark = request.getParameter("remark");
			String comppass = request.getParameter("comppass");
			String yearpass = request.getParameter("yearpass");
			
			
			HttpSession session = request.getSession();
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			ImportHollidays_dao dao = new ImportHollidays_dao();
			dao.saveDate(uid,holli_date,comppass,yearpass,remark,response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
