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

public class Add_Customer_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		try {
			Admin_index_vo index_vo = new Admin_index_vo();
			if (!request.getParameter("company").equals("")
					&& !request.getParameter("customer_name").equals("")
					&& !request.getParameter("customer_email").equals("")) {

				index_vo.setCompany(Integer.parseInt(request
						.getParameter("company")));
				index_vo.setCustomer_name(request.getParameter("customer_name"));
				index_vo.setCustomer_email(request
						.getParameter("customer_email"));
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
