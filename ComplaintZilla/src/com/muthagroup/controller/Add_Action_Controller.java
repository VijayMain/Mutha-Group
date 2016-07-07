package com.muthagroup.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.bo.Admin_Index_BO;
import com.muthagroup.vo.Admin_index_vo;

public class Add_Action_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		try {
			Admin_index_vo index_vo = new Admin_index_vo();
			HttpSession session=request.getSession();
			if (!request.getParameter("Action_Type").equals("")) {

				index_vo.setAction_Type(request.getParameter("Action_Type"));

				Admin_Index_BO bo = new Admin_Index_BO(response);

				boolean flag = bo.insertData(index_vo, session);
				if (flag == true) {
					response.sendRedirect("Success.jsp");
				}
			}
			response.sendRedirect("Insertion_fail.jsp");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
