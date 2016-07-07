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

/**
 * Servlet implementation class Add_AutoMail_Controller
 */
public class Add_AutoMail_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		try {
			System.out.println("Controller Called....");
			Admin_index_vo bean = new Admin_index_vo();
			if (!request.getParameter("company").equals("")
					&& !request.getParameter("user_id").equals("")) {

				bean.setCompany(Integer.parseInt(request
						.getParameter("company")));
				bean.setU_id(Integer.parseInt(request.getParameter("user_id")));
				System.out.println("Values are fixed");
				System.out.println("Values for Beans = " + bean.getCompany()
						+ "\n" + bean.getU_id());
				Admin_Index_BO bo = new Admin_Index_BO(response);

				boolean flag = bo.insertData(bean, session);
				if (flag == true) {
					response.sendRedirect("Success.jsp");
				}
				
			}else
			{
				response.sendRedirect("Insertion_fail.jsp");
			}
			
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}

	}
}
