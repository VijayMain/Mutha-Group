package com.muthagroup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.muthagroup.bo.Search_Request_BO;
import com.muthagroup.vo.Search_Request_Vo;
//============================================================================-->
//============================ Controller  ===================================-->
//============================================================================-->
public class Search_Request_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {

			// ************************************************************************************************************************

			SimpleDateFormat formatter = new SimpleDateFormat(
					"dd-MM-yyyy HH:mm:ss");

			HttpSession session = request.getSession();
			Search_Request_Vo bean = new Search_Request_Vo();
			bean.setCompany_name_sup(Integer.parseInt(request
					.getParameter("company_name_sup")));

			bean.setCompany_name_item(Integer.parseInt(request
					.getParameter("company_name_item")));
			System.out.println("Company Name Item = "
					+ bean.getCompany_name_item());
			bean.setItem_name_item(Integer.parseInt(request
					.getParameter("item_name")));

			bean.setApproval_type_app(Integer.parseInt(request
					.getParameter("approval_type_app")));

			System.out.println("Test ==== = " + bean.getEnd_date_sup() + "-"
					+ bean.getCompany_name_sup() + "-"
					+ bean.getCompany_name_item() + "-"
					+ bean.getApproval_type_app());

			Timestamp sdates = null, edates = null, sdatei = null, edatei = null, sdatea = null, edatea = null;

			bean.setCompany_name_item(Integer.parseInt(request
					.getParameter("company_name_item")));

			bean.setItem_name_item(Integer.parseInt(request
					.getParameter("item_name")));

			bean.setApproval_type_app(Integer.parseInt(request
					.getParameter("approval_type_app")));

			// ******************************************************************************************************************
			String start_date_sup = request.getParameter("start_date_sup");
			String end_date_sup = request.getParameter("end_date_sup");
			String start_date_item = request.getParameter("start_date_item");
			String end_date_item = request.getParameter("end_date_item");
			String start_date_app = request.getParameter("start_date_app");
			String end_date_app = request.getParameter("end_date_app");

			System.out.println("End date = " + end_date_item);

			int comp_Sup = bean.getCompany_name_sup();

			if (start_date_sup != "" && end_date_sup == "") {
				sdates = new java.sql.Timestamp(formatter.parse(start_date_sup)
						.getTime());
				bean.setStart_date_sup(sdates);
			} else if (end_date_sup != "" && start_date_sup == "") {
				edates = new java.sql.Timestamp(formatter.parse(end_date_sup)
						.getTime());
				bean.setEnd_date_sup(edates);
			} else if (end_date_sup != "" && start_date_sup != "") {
				edates = new java.sql.Timestamp(formatter.parse(end_date_sup)
						.getTime());
				sdates = new java.sql.Timestamp(formatter.parse(start_date_sup)
						.getTime());
				bean.setStart_date_sup(sdates);
				bean.setEnd_date_sup(edates);
			} else if (start_date_item != "" && end_date_item == "") {
				sdatei = new java.sql.Timestamp(formatter
						.parse(start_date_item).getTime());
				bean.setStart_date_item(sdatei);

			}

			else if (start_date_item == "" && end_date_item != "") {

				edatei = new java.sql.Timestamp(formatter.parse(end_date_item)
						.getTime());

				bean.setEnd_date_item(edatei);
			} else if (start_date_item != "" && end_date_item != "") {
				sdatei = new java.sql.Timestamp(formatter
						.parse(start_date_item).getTime());
				edatei = new java.sql.Timestamp(formatter.parse(end_date_item)
						.getTime());
				bean.setStart_date_item(sdatei);
				bean.setEnd_date_item(edatei);
			} else if (start_date_app != "" && end_date_app != "") {
				sdatea = new java.sql.Timestamp(formatter.parse(start_date_app)
						.getTime());
				bean.setStart_date_app(sdatea);
				edatea = new java.sql.Timestamp(formatter.parse(end_date_app)
						.getTime());
				bean.setEnd_date_app(edatea);

			} else if (start_date_app != "" && end_date_app == "") {
				sdatea = new java.sql.Timestamp(formatter.parse(start_date_app)
						.getTime());
				bean.setStart_date_app(sdatea);
			} else if (start_date_app == "" && end_date_app != "") {
				edatea = new java.sql.Timestamp(formatter.parse(end_date_app)
						.getTime());
				bean.setEnd_date_app(edatea);

			}
			System.out.println("Testing output = " + bean.getStart_date_item()
					+ "\n" + bean.getEnd_date_item());
			boolean flag = false;

			Search_Request_BO bo = new Search_Request_BO();

			flag = bo.searchResult(bean, session, request, response);

			if (flag == true) {
				response.sendRedirect("Search_Result.jsp");
			} else {
				response.sendRedirect("Cab_Home.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
//============================================================================--> 
//============================================================================-->