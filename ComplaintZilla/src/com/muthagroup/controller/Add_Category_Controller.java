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

public class Add_Category_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		HttpSession session=request.getSession();
		PrintWriter out = response.getWriter();
		try {
			Admin_index_vo index_vo = new Admin_index_vo();

			if (!request.getParameter("catagory_name").equals("")
					&& !request.getParameter("cat_init").equals("")) {

				index_vo.setCatagory_name(request.getParameter("catagory_name"));
				index_vo.setCat_init(request.getParameter("cat_init"));

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
